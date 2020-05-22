package com.files.net;

import com.files.util.S3UploadCache;
import com.files.exception.ApiAuthenticationException;
import com.files.exception.ApiErrorException;
import com.files.exception.ApiFileNotFoundException;
import com.files.exception.ApiForbiddenException;
import com.files.exception.ApiMissingGatewayException;
import com.files.exception.ApiNonReportableException;
import com.files.exception.ApiOverRateException;
import com.files.exception.ApiReportedRuntimeException;
import com.files.exception.ApiRuntimeException;
import com.files.exception.ReportableIOException;
import com.files.util.StatisticsInterface;
import com.actionverb.files.util.BuildNumber;
import com.actionverb.files.util.HBClient;
import com.actionverb.files.util.KeyUtils;
import com.actionverb.files.util.PathUtils;
import com.actionverb.files.util.Utils;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import gnu.java.io.PipedInputStream;
import gnu.java.io.PipedOutputStream;

import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okio.BufferedSink;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpHeaders;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.MDC;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Type;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.UUID;


public class ApiSession {
  public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
  /**
   * Initialize a new session object.
   *
   * @param user
   * @param apiRoot
   * @param ifname
   * @param stats
   * @throws ApiAuthenticationException
   */
  public ApiSession(String user, String apiRoot, InterfaceName ifname, Statistics stats) {
    this.username = user;  // set the username early
    this.apiRoot = apiRoot;
    this.ifname = ifname;
    this.stats = stats;

    // We will use this key to differentiate the cached paths for each session
    this.sessionKey = UUID.randomUUID().toString();
  }

  /**
   * Authenticate this session against the files service
   *
   * @param user
   * @param password
   * @param publickey
   * @throws ApiAuthenticationException
   * @throws ApiOverRateException
   */
  @Override
  public void authenticate(String user, String password, String publickey) throws ApiAuthenticationException, ApiOverRateException {

    // Treat non-ASCII characters as blank so that broken clients that send garbage have that garbage ignored
    // This strategy works because the API defines limits on usernames that limit them to only ASCII characters
    user = user.replaceAll("[^\\x00-\\x7F]", "");

    this.username = user; // set the username early
    // set the ip for HB
    try {
      // clear the MDC to make sure we aren't overlapping, for anything inside this thread
      MDC.clear();
      MDC.put("remoteIp", remoteIP);
      MDC.put("userName", user);
      MDC.put("interface", interfaceNameToString(ifname));
    } catch (NullPointerException ex) {
      // NOOP
    }

    // Always fail anonymous and let
    if (user.toLowerCase().contentEquals("anonymous")) {
      // throw to our corresponding interface
      throw new ApiAuthenticationException("Authentication failed.");
    }

    // keep blacklist usernames from hitting the API
    if (Config.getInstance().getBlacklistUsernames().stream().parallel().anyMatch(user.toLowerCase()::contentEquals)) {
      IpTracking.getInstance().addLoginFailedTick(remoteIP);
      // throw to our corresponding interface
      throw new ApiAuthenticationException("Authentication failed.");
    }

    String cacheKey = "auth:" + user + ":" + Utils.hash(user + ":" + password + ":" + publickey + ":" + interfaceNameToString(ifname) + ":" + remoteIP + ":" + localIP);
    String userCacheKey = "user:" + user + ":" + Utils.hash(remoteIP + ":" + localIP);
    try {
      LockManager.getInstance().lock(cacheKey);
    } catch (Exception e) {
      this.log.error(e);
    }

    JsonObject content = (JsonObject) getCache(cacheKey);
    if (content != null && (content.get("expires_at").getAsLong() < System.currentTimeMillis())) {
      content = null;
    }
    if (content != null && !content.has("id")) {
      if (content.has("error")) {
        LockManager.getInstance().unlock(cacheKey);
        /**
         * Its important we don't count public keys here because of horrible clients like FileZilla
         */
        if (publickey == null || publickey.isEmpty()) {
          log.info(logMsg("Login cached failure"));
        }
        throw new ApiAuthenticationException(content.get("error").getAsString());
      }
      content = null;
    }

    if (content == null) {
      MultipartBody.Builder formData = new MultipartBody.Builder();
      formData.setType(MultipartBody.FORM);

      if (user != null) formData.addFormDataPart("username", user);
      if (password != null) formData.addFormDataPart("password", password);
      if (publickey != null) formData.addFormDataPart("public_key", publickey);
      if (ifname != null) formData.addFormDataPart("interface", interfaceNameToString(ifname));
      if (Config.getInstance().getAwsRegion() != null) formData.addFormDataPart("preferred_region", Config.getInstance().getAwsRegion());

      RequestResult result = null;

      try {
        result = restPost(API_PATH_SESSIONS, formData, null, false);
      } catch (ApiErrorException | ApiRuntimeException ex) {
        LockManager.getInstance().unlock(cacheKey);
        // this instance of a 429 can be safely thrown, but is our old full api rate limit, used during emergencies
        if (ex instanceof ApiOverRateException) {
          throw (ApiOverRateException) ex;
        }
        throw new ApiAuthenticationException("Upstream authentication failed.");
      }

      if (result.code >= 400) {
        String errorReason = "Authentication failed.";
        if (result.code == 401) {
          if (!result.getError().contains("HTTP Error")){
            String errorType = result.getErrorType();
            String errorSubType = result.getErrorSubType();
            if (errorType != null && result.getErrorSubType() != null){
              if (errorType.contains("two-factor")){
                if (errorSubType.equals("u2f")){
                  errorReason = "This user requires U2F; which, is only supported in web browsers.  If you need to connect via an external client, you can create an API key for this user. Then connect using @api as the username and the API key as the password.";
                } else if (errorSubType.equals("native")){
                  errorReason = "This user requires Native Yubikey Authentication; which, is only supported in web browsers.  If you need to connect via an external client, you can create an API key for this user. Then connect using @api as the username and the API key as the password.";
                } else if (errorSubType.equals("totp")){
                  errorReason = "This user requires a TOTP password. To connect via an external client, you can enter your normal password followed by the six digits from your authenticator app.";
                }
              }
            } else {
              errorReason = result.getError();
            }
          }
        }

        if (result.code < 500) {
          content = new JsonObject();
          if (result.code == 429) {
            content.addProperty("expires_at", System.currentTimeMillis() + 1000 * 90);
          } else {
            content.addProperty("expires_at", System.currentTimeMillis() + 1000 * 60 * 60 * 24);
          }
          content.addProperty("error", errorReason);
          putCache(cacheKey, content);

          if (StringUtils.isEmpty(publickey)) {
            log.info(logMsg(String.format("Login uncached failure. Count: %s. Upstream response code: %s. Response body: %s", IpTracking.getInstance().getLoginFailedTick(remoteIP), result.code, content)));
            IpTracking.getInstance().addLoginFailedTick(remoteIP); // uncached failure
          } else {
            log.info(logMsg("Login uncached failure with public key"));
          }
        }

        LockManager.getInstance().unlock(cacheKey);

        if (result.code == 429) { // throw overrate so that we can move on
          throw new ApiOverRateException();
        } else {
          throw new ApiAuthenticationException(errorReason);
        }
      }

      content = (JsonObject) result.json;
      content.addProperty("expires_at", System.currentTimeMillis() + 1000 * 300); // Cache logins for 5 minutes
      apiKey = content.get("id").getAsString();

      // save our login object to the cache
      putCache(cacheKey, content);
      putCache(userCacheKey, content);
    } else {
      apiKey = content.get("id").getAsString();
    }
    LockManager.getInstance().unlock(cacheKey); // safe to unlock now

    authTime = new Date();
    requireSSL = content.get("ssl_required").getAsBoolean();
    if (content.has("tls_disabled")) {
      requireTLS = content.get("tls_disabled").getAsBoolean() ? false : true; // convert this to this applications meaning
    }
    if (content.has("root_path")) {
      rootPath = content.get("root_path").getAsString();
    }
    if (content.has("site_id")) {
      siteId = content.get("site_id").getAsString();
    }
    if (content.has("use_provided_modified_at") && content.get("use_provided_modified_at").getAsBoolean()) {
      useProvidedMTime = true;
    }
    if (content.has("windows_mode_ftp") && content.get("windows_mode_ftp").getAsBoolean()) {
      useWindowsModeFTP = true;
    }
    if (content.has("multiple_regions") && content.get("multiple_regions").getAsBoolean()) {
      multipleRegions = true;
    }
    if (content.has("max_dir_listing_size")) {
      maxDirListingSize = content.get("max_dir_listing_size").getAsInt();
    }

    // determine if this site or the global setting requires this
    configureUseSpdy();

    try {
      MDC.put("siteId", siteId);
    } catch (NullPointerException ex) {
      // noop
    }
    // setup the cache key for prefetched uploads
    uploadsCacheKey = "uploads:" + siteId + ":" + username;
    apiGetUploads();
  }

  public void configureUseSpdy() {
    String[] site_ids = Config.getInstance().getSpdyPreferredSiteIds().split(",");
    for (String sid : site_ids) {
      if (sid.equals(siteId)) {
        useSpdy = true;
      }
    }
    if (Config.getInstance().getSpdyPreferred()) {
      useSpdy = true;
    }
  }

  public JsonObject getCheckUser(String username) {
    String userCacheKey = "user:" + username + ":" + Utils.hash(remoteIP + ":" + localIP);
    JsonObject user = (JsonObject) getCache(userCacheKey);

    try {
      if (user == null) {
        MultipartBody.Builder body = new MultipartBody.Builder();
        body.setType(MultipartBody.FORM);
        body.addFormDataPart("username", username);
        RequestResult result = restPost(PathUtils.concatPath(API_PATH_SESSIONS, "check_user"), body, null, true);

        if (result.code >= 300) {
          user = new JsonObject();
          user.addProperty("ssl_required", true);
          user.addProperty("tls_required", true);
          user.addProperty("site_id", 0);
        } else {
          user = (JsonObject) result.json;
        }
        putCache(userCacheKey, user);
      }
    } catch (ApiErrorException ex) {
      log.warn(logMsg(ex.getMessage()));
    }

    return user;
  }

  /**
   * @param source
   * @param origDestination
   */
  public void copy(String source, String origDestination) throws ApiReportedRuntimeException {
    clearPathFromCache(origDestination);

    String destination = PathUtils.concatSafeUri("/", rootPath, origDestination);
    List<NameValuePair> params = new ArrayList<>(1);
    MultipartBody.Builder body = new MultipartBody.Builder();
    body.setType(MultipartBody.FORM);
    body.addFormDataPart("copy-destination", destination);
    JsonElement result = null;
    try {
      result = restPost(PathUtils.concatPath(API_PATH_FILES, rootPath, source), body, null, true).json;
    } catch(ApiErrorException ex) {
      if (ex.getCode() >= 500) {
        log.error(logMsg(ex.toString()));
      } else {
        throw new ApiReportedRuntimeException(lastEventException.getCode(), "action:copy", source);
      }
    }

    if (result == null || !result.isJsonArray()) {
      throw new ApiReportedRuntimeException(500, "action:copy", source);
    }
  }

  /**
   * @param origPath
   */
  public boolean createFolder(String origPath) throws ApiReportedRuntimeException {
    clearPathFromCache(origPath);
    RequestResult result = null;
    try {
      result = restPost(PathUtils.concatSafeUri(API_PATH_FOLDERS, rootPath, origPath));
    } catch(ApiErrorException ex) {
      if (ex.getCode() >= 500) {
        log.error(logMsg(ex.toString()));
        throw new ApiReportedRuntimeException(500, "action:mkdir", origPath);
      } else {
        throw new ApiReportedRuntimeException(ex.getCode(), "action:mkdir", origPath);
      }
    }
    if(result.getCode() == 403){
      throw new ApiReportedRuntimeException(403, "action:mkdir", String.format("%s.  %s", origPath, result.getError()));
    }

    if(result.getCode() >= 300) {
      throw new ApiReportedRuntimeException(result.getCode(), "action:mkdir", origPath);
    }

    return true;
  }

  /**
   * @param path
   * @return
   */
  public boolean delete(String path) throws ApiRuntimeException {
    clearPathFromCache(path);

    boolean deleteSuccess = false;
    try {
      deleteSuccess = restDelete(PathUtils.concatSafeUri(API_PATH_FILES, rootPath, path)).isHTTPSuccess();
    } catch(ApiErrorException ex) {
      log.error(logMsg(ex.toString()));
    }
    if (stats != null && deleteSuccess) {
      stats.setTotalDeleteNumber();
    }
    return deleteSuccess;
  }

  /**
   * Download the entire file to the provided stream. Used by DAV.
   *
   * @param path
   * @param outputStream
   * @throws IOException
   */
  public void download(String path, OutputStream outputStream) throws ApiErrorException, IOException {
    apiDownload(path, outputStream, 0L, -1L);
  }

  /**
   * Download to the provided stream with an offset. Used by DAV.
   *
   * @param path
   * @param outputStream
   * @param start
   * @param end
   * @throws IOException
   */
  public void download(String path, OutputStream outputStream, long start, long end) throws ApiErrorException, IOException {
    apiDownload(path, outputStream, start, end);
  }

  /**
   * Create a download stream given the params provided. Used by FTP and SFTP.
   *
   * @param path
   * @param start
   * @param end
   * @return
   * @throws IOException
   */
  public InputStream createDownloadInputStream(String path, long start, long end) throws IOException {
    PipedInputStream pipedIn = new PipedInputStream();
    try {
      PipedOutputStream pipedOut = new PipedOutputStream(pipedIn);

      new Thread(new Runnable() {
        @Override
        public void run() {
          try {
            apiDownload(path, pipedOut, start, end);
          } catch (ApiErrorException ex) {
            ApiReportedRuntimeException proxy_ex = new ApiReportedRuntimeException(ex.getCode(), "action:get", PathUtils.normPath(path));
            log.warn(logMsg(proxy_ex.getBrickMessage()));
            pipedIn.setTriggerException(new ReportableIOException(proxy_ex));
          } catch (ApiReportedRuntimeException ex) {
            pipedIn.setTriggerException(new ReportableIOException(ex));
          } catch (ApiRuntimeException | IOException ex) {
            log.warn(logMsg(ex.getMessage()));
            pipedIn.setTriggerException(ex);
          } finally {
            try {
              pipedOut.close();
            } catch (IOException ex) {
              //don't care
            }
          }
        }
      }).start();
    } catch (IOException ex) {
      // new InputStream, guaranteed not to throw
    }

    return pipedIn;
  }

  /**
   * Pass the S3 object to the provided output stream.
   *
   * @param path
   * @param outputStream
   * @param start
   * @param end
   * @return
   * @throws IOException
   */
  private long apiDownload(String path, OutputStream outputStream, long start, long end) throws ApiReportedRuntimeException, ApiErrorException, IOException {
    List<NameValuePair> params = new ArrayList<>(2);
    if (Config.getInstance().getAwsRegion() != null) {
      params.add(new BasicNameValuePair("preferred_region", Config.getInstance().getAwsRegion()));
    }
    if (useSpdy) {
      params.add(new BasicNameValuePair("prefer_spdy", "true"));
    }
    JsonObject result = (JsonObject) restGet(PathUtils.concatSafeUri(API_PATH_FILES, rootPath, path), params).json;
    if (result.has("http-code") && result.get("http-code").getAsInt() == 404) {
      throw new ApiReportedRuntimeException(404, "action:get", path);
    } else if(result.has("http-code") && result.get("http-code").getAsInt() == 423) {
      throw new ApiReportedRuntimeException(423, "action:get", path);
    } else if (result.has("error")) {
      throw new ApiFileNotFoundException();
    }
    String uri = result.get("download_uri").getAsString();
    Long apiSize = null;

    // handle a null size from our API
    if (result.has("size") && !result.get("size").isJsonNull()) {
      apiSize = result.get("size").getAsLong();
    }

    if (apiSize != null && (start > apiSize || (end >= start ? end : 0) > apiSize)) {
      log.error(logMsg("Client requested invalid range " + start + "-" + end + ", we only have " + apiSize ));
      throw new IOException("Invalid restart");
    }

    /* **
     * Quickly return the size if they are trying to start at the end of the file.
     * This should result in a valid 226 success for clients like LFTP that will always try to resume at the last byte.
     */
    if (apiSize != null && apiSize == start) {
      return apiSize;
    }


    long size = 0L;
    Response response = null;
    try {
      int responseCode = 404;
      long s3StartTime = System.currentTimeMillis();
      boolean bSafeToRetryS3 = false;
      String upstreamFailureBody = "";
      do {
        OkHttpClient.Builder clientBuilder;
        if (Config.getInstance().getAllowInsecureBackend()) {
          log.info(logMsg("INSECURE REQUEST"));
          clientBuilder = InsecureHttpClient.getInstance().getDefault().newBuilder();
        } else {
          clientBuilder = StandardHttpClient.getInstance().getDefault().newBuilder();
        }

        clientBuilder.retryOnConnectionFailure(true);
        OkHttpClient client = clientBuilder.build();

        Request request;

        if (start > 0) {
          request = new Request.Builder().url(Utils.forceMandatoryUriEncode(uri)).header("Range", "bytes=" + start + "-" + (end >= start ? end : "")).build();
        } else {
          request = new Request.Builder().url(Utils.forceMandatoryUriEncode(uri)).build();
        }

        response = client.newCall(request).execute();

        responseCode = response.code();
        // report the response code to Statsd/Metrics
        stats.setS3ResponseCodeCount("get" ,responseCode);

        if (responseCode >= 400 && response.body() != null) {
          upstreamFailureBody = response.body().string();
          response.body().close();
        }
        if (responseCode == 400 && upstreamFailureBody.contains("RequestTimeout")) {
          bSafeToRetryS3 = true;
        } else if (Config.getInstance().getS3RetryAllowed() && responseCode >= 500 && (System.currentTimeMillis() - s3StartTime) < 18 * 1000) {
          bSafeToRetryS3 = true;
        } else {
          bSafeToRetryS3 = false;
        }
      } while (bSafeToRetryS3);

      // 416 range not available, we don't need to report this to HB as it is a known invalid restart request for the object stored in s3
      if (responseCode == 416) {
        throw new IOException("Invalid restart");
      }

      // Log/Report S3 error codes, prevent XML from returning to client
      if (responseCode >= 300) {
        log.error(logMsg("Download S3 Upstream Failure Code: " + responseCode + " [" + upstreamFailureBody + "]"));
        HBClient.getInstance().reportError("Download S3 Upstream Failure Code: " + responseCode + " [" + upstreamFailureBody + "]");
        throw new IOException("Upstream error");
      }

      InputStream inputStream = null;
      try {
        inputStream = response.body().byteStream();
        size = IOUtils.copyLarge(inputStream, outputStream);
      } catch (Exception e){

      } finally {
        inputStream.close();
        response.body().close();
      }


    } catch (NullPointerException ex) {
      log.error(logMsg("NullPointerException in apiDownload"));
      HBClient.getInstance().reportError(ex);
      if (response != null) {
        response.body().close();
      }
      throw new IOException("Upstream error");
    }

    if (stats != null) {
      stats.setTotalDownloadNumber();
      stats.setTotalDownloadSize(size);
      stats.setSiteTotalDownloadNumber(siteId);
    }

    return size;
  }

  /**
   * @param path
   * @return
   */
  public boolean exists(String path) {
    return apiGetFileInfo(path) != null;
  }

  /**
   * Used to find a file object.
   *
   * @param path
   * @return
   */
  public ApiFile get(String path) throws ApiRuntimeException {
    JsonObject ojson = apiGetFileInfo(path);
    if (ojson == null) {
      /*
       * We must throw an exception if the path is blank/root
       * or we will end up with a stackoverflow error in FtpServer.
       * It also causes as many calls for apiGetFileInfo (and API)
       * as it can process until it overflows.
       */
      if (path.isEmpty()) {
        throw new ApiNonReportableException();
      }

      // return a file object with exists=false
      return new ApiFile(this, path);
    } else {
      /*
       * We ignore the path value given to us by the API because
       * it may not match the case of the path we queried, and
       * when we query a path by a specfic case sensitive name
       * then we need to preserve that case in the path of the
       * created object so that further operations on this file
       * use the case given by the user.  --MHB 2015/04/20
       */
      ojson.addProperty("path", PathUtils.concatPath(rootPath, PathUtils.normPath(path)));
      return JsonObjectToApiFile(ojson);
    }
  }

  private void apiGetUploads() {
    if (S3UploadCache.getInstance().size(uploadsCacheKey) > 1 || S3UploadCache.getInstance().fetchInProgress(uploadsCacheKey)) {
      return;
    }
    if (multipleRegions) {
      return;
    }
    S3UploadCache.getInstance().addFetchInProgress(uploadsCacheKey);


    new Thread(new Runnable() {
      @Override
      public void run() {

        // retrieve a smaller number of parts since we have a lot of files that are < 20MB
        RequestResult result = null;


        JsonObject resultJson = new JsonObject();
        resultJson.addProperty("count", Integer.toString(MAX_UPLOADS_FETCH));
        resultJson.addProperty("parts", Integer.toString(5));


        try {
          RequestBody body= new RequestBody() {
            @Override
            public MediaType contentType() {
              return MediaType.parse("application/json; charset=utf-8");
            }

            @Override
            public void writeTo(BufferedSink bufferedSink) throws IOException {
              bufferedSink.write(resultJson.toString().getBytes());
            }
          };
          result = restPost(API_PATH_UPLOADS, null, body,true);
        } catch(ApiErrorException ex) {
          log.error(logMsg(ex.toString()));
          S3UploadCache.getInstance().deleteFetchInProgress(uploadsCacheKey);
          return;
        }
        if (result != null && result.code == 403) {
          S3UploadCache.getInstance().deleteFetchInProgress(uploadsCacheKey);
          return;
        }
        try {
          Type apiUploadResponseType = new TypeToken<LinkedList<ApiUploadResponse>>() {}.getType();
          Gson gson = new Gson();
          LinkedList<ApiUploadResponse> tmpUploads = gson.fromJson(result.json, apiUploadResponseType);

          synchronized (this) {
            S3UploadCache.getInstance().addAll(uploadsCacheKey, tmpUploads);
          }
        } catch (Exception ex) {
          // Report for an exception that has not already been reported
          if (!(ex instanceof ApiRuntimeException)) {
            HBClient.getInstance().reportError(ex);
          }
          log.error(logMsg(ex.toString()));
          // NO OP, generally the user does not have write permissions
        } finally {
          S3UploadCache.getInstance().deleteFetchInProgress(uploadsCacheKey);
        }
      }
    }).start();
  }

  private void apiSetUploadPath(long uploadId, String path) {
    if (uploadId == 0L) {
      return;
    }
    new Thread(new Runnable() {
      @Override
      public void run() {

        List<NameValuePair> params = new ArrayList<>(1);

        RequestResult result = null;

        FormBody.Builder body = new FormBody.Builder();
        body.add("path", PathUtils.concatPath(rootPath, path));
        try {
          result = restPatch(PathUtils.concatSafeUri(API_PATH_UPLOADS, null, Long.toString(uploadId)), body);
        } catch (ApiErrorException ex) {
          synchronized (this) {
            lastEventException = ex;
            log.error(logMsg(ex.toString()));
          }
          return;
        }

        if (result.code >= 300) {
          synchronized (this) {
            lastEventException = new ApiErrorException(result.code, "");
          }
        }
      }
    }).start();
  }

  private JsonObject apiGetFileInfo(String path) throws ApiNonReportableException {
    String cacheKey = "path:" + siteId + ":stat:" + PathUtils.normPath(PathUtils.concatPath(rootPath, path)) + ":" + username;
    JsonObject ojson = (JsonObject) getCache(cacheKey);
    if (ojson != null) {
      // our stat objects should always have a type=(file\directory)
      if (!ojson.has("type")) {
        return null;
      }
      return ojson;
    }

    ojson = (JsonObject) getStatFromDirCache(path);
    if (ojson != null) {
      return ojson;
    }

    List<NameValuePair> params = new ArrayList<>(1);
    params.add(new BasicNameValuePair("action", "stat"));
    RequestResult result = null;
    try {
      result = restGet(PathUtils.concatSafeUri(API_PATH_FILES, rootPath, path), params);
    } catch(ApiErrorException ex){
      throw new ApiRuntimeException();
    }
    if (result.code == 403 || result.code == 404) {
      putCache(cacheKey, new JsonObject()); // cache the stat call
      return null;
    }

    if (result.code == 401) {
      throw new ApiReportedRuntimeException(result.code, "api:getInfo");
    }

    ojson = (JsonObject) result.json;
    if (ojson != null && ojson.has("error")) {
      throw new ApiRuntimeException(false);
    }
    if (ojson != null) {
      putCache(cacheKey, ojson);
    }

    return ojson;
  }


  private JsonObject getStatFromDirCache(String path) {
    int page = 0;
    JsonArray result;
    String parent = PathUtils.getParent(path);
    if (path == null || PathUtils.normPath(path) == null || PathUtils.normPath(path).isEmpty()) {
      return null;
    }
    do {
      page++;
      String cacheKey = "path:" + siteId + ":list:" + PathUtils.normPath(PathUtils.concatPath(rootPath, parent)) + "::" + page + ":" + MAX_LIST_PER_PAGE + ":" + username;
      JsonElement cached = getCache(cacheKey);
      if (cached != null) {
        result = (JsonArray) cached;
        if (result.size() > 0) {
          for (JsonElement e : result) {
            JsonObject o = (JsonObject) e;
            if (o.get("path").getAsString().equals(PathUtils.normPath(PathUtils.concatPath(rootPath, path)))) {
              return o;
            }
          }
        }
      } else {
        result = null;
      }
    } while (result != null && result.size() == MAX_LIST_PER_PAGE);

    return null;
  }

  public List<ApiFile> list(String path, String pattern) throws ApiFileNotFoundException {
    JsonArray listArray = apiList(path, pattern);
    if (listArray == null) {
      listArray = new JsonArray();
    }
    List<ApiFile> children = new ArrayList<>(listArray.size());
    for (JsonElement e : listArray) {
      children.add(JsonObjectToApiFile((JsonObject) e));
    }
    return children;
  }

  private JsonArray apiList(String path) throws ApiFileNotFoundException {
    return apiList(path, null);
  }

  private JsonArray apiList(String path, String pattern) throws ApiFileNotFoundException {
    if (pattern != null && !pattern.isEmpty()) {
      pattern = PathUtils.normPath(PathUtils.concatPath(rootPath, path, pattern));
    } else if (pattern == null) {
      pattern = "";
    }
    JsonArray results = new JsonArray();
    String cursor = null;
    int page = 0;
    JsonArray result;
    do {
      page++;
      String cacheKey = "path:" + siteId + ":list:" + PathUtils.normPath(PathUtils.concatPath(rootPath, path)) + ":" + pattern + ":" + page + ":" + MAX_LIST_PER_PAGE + ":" + username;
      JsonElement cached = getCache(cacheKey);

      if (cached != null) {
        result = (JsonArray) cached;
      } else {
        List<NameValuePair> params = new ArrayList<>(2);
        params.add(new BasicNameValuePair("cursor", cursor));
        params.add(new BasicNameValuePair("per_page", Integer.toString(MAX_LIST_PER_PAGE)));
        if (pattern != null && !pattern.isEmpty()) {
          params.add(new BasicNameValuePair("filter", pattern));
        }
        RequestResult getResult = null;

        try {
          getResult = restGet(PathUtils.concatSafeUri(API_PATH_FOLDERS, rootPath, path), params);
        } catch(ApiErrorException ex) {
          log.error(logMsg(ex.toString()));
          throw new ApiFileNotFoundException();
        }

        if (getResult.code == 404) {
          throw new ApiFileNotFoundException();
        }
        try {
          result = (JsonArray) getResult.json;
        } catch (ClassCastException ex) {
          log.error(logMsg("ClassCastException: JsonArray [" + getResult.code + "] `" + getResult.json.toString() + "`"));
          return new JsonArray();
        }
        cursor = getResult.getCursor();
        putCache(cacheKey, getResult.json);
        if (stats != null && page > 1) {
          stats.setTotalLargeDirListing();
        }
      }
      results.addAll(result);
    } while (result.size() == MAX_LIST_PER_PAGE && results.size() < maxDirListingSize);
    return results;
  }

  public List<ApiLockItem> createLock(String path, String owner, String type, String scope, String depth, long timeout) {
    JsonArray locks = new JsonArray();
    locks.add(apiCreateLock(path, owner, type, scope, depth, timeout));
    return toApiLockItems(locks);
  }

  private JsonObject apiCreateLock(String origPath, String owner, String type, String scope, String depth, long timeout) {
    depth = depth.equals("zero") ? "0" : depth;


    MultipartBody.Builder body = new MultipartBody.Builder();
    body.setType(MultipartBody.FORM);
    body.addFormDataPart("owner", owner);
    body.addFormDataPart("type", type);
    body.addFormDataPart("scope", scope);
    body.addFormDataPart("depth", depth);
    body.addFormDataPart("timeout", Long.toString(timeout));


    JsonObject result = null;
    try {
      result = (JsonObject) restPost(PathUtils.concatSafeUri(API_PATH_LOCKS, rootPath, origPath), body, null,true).json;
    } catch(ApiErrorException ex) {
      log.error(logMsg(ex.toString()));
    }
    return result;
  }

  public List<ApiLockItem> getLock(String path) {
    return getLock(path, false);
  }

  public List<ApiLockItem> getLock(String path, Boolean recursive) {
    return  toApiLockItems(apiGetLock(path, recursive));
  }

  //@Deprecated
  //private JsonObject apiGetLock(String origPath) {
  //    return apiGetLock(origPath, false);
  //}

  private JsonArray apiGetLock(String origPath, Boolean recursive) {
    RequestResult res;
    try {
      List<NameValuePair> params = null;
      if (recursive) {
        params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("include_children", "true"));
      }

      res = restGet(PathUtils.concatSafeUri(API_PATH_LOCKS, rootPath, origPath), params);
    } catch (ApiErrorException ex) {
      log.error(logMsg(ex.toString()));
      return null;
    }
    if (res == null || !res.isHTTPSuccess()) {
      return null;
    }

    return (JsonArray) res.json;
  }

  public void deleteLock(String origPath, String token) {
    FormBody.Builder formBody = new FormBody.Builder();
    formBody.add("token", token);

    try {
      restDelete(PathUtils.concatSafeUri(API_PATH_LOCKS, rootPath, origPath), formBody);
    } catch(ApiErrorException ex) {
      log.error(logMsg(ex.toString()));
    }
  }

  private static List<ApiLockItem> toApiLockItems(JsonArray lockResults) {
    if (lockResults == null || lockResults.isJsonNull())  {
      return null;
    }

    List<ApiLockItem> output = new ArrayList<ApiLockItem>();
    // #TODO || !lockResult.has("token"))
    for(int i=0; i < lockResults.size(); i++) {
      JsonObject lockResult = lockResults.get(i).getAsJsonObject();
      output.add(new ApiLockItem(
        lockResult.get("token").getAsString(),
        lockResult.get("owner").getAsString(),
        lockResult.get("type").getAsString().equals("read") ?
          ApiLockItem.LockType.READ :
          ApiLockItem.LockType.WRITE,
        lockResult.get("scope").getAsString().equals("shared") ?
          ApiLockItem.LockScope.SHARED :
          ApiLockItem.LockScope.EXCLUSIVE,
        lockResult.get("depth").getAsString().equals("0") ?
          ApiLockItem.LockDepth.ZERO :
          ApiLockItem.LockDepth.INFINITY,
        lockResult.get("timeout").getAsLong(),
        lockResult.get("path").getAsString()
      ));
    }
    return output;
  }


  /**
   * @param source
   * @param origDestination
   */
  public boolean move(String source, String origDestination) throws ApiReportedRuntimeException {
    clearPathFromCache(source);
    clearPathFromCache(origDestination);

    String destination = PathUtils.concatSafeUri("/", rootPath, origDestination);

    MultipartBody.Builder body = new MultipartBody.Builder();
    body.setType(MultipartBody.FORM);
    body.addFormDataPart("move-destination", destination);

    RequestResult result = null;
    try {
      result = restPost(PathUtils.concatSafeUri(API_PATH_FILES, rootPath, source), body, null,true);
    }catch(ApiErrorException ex) {
      if (ex.getCode() >= 500) {
        log.error(logMsg(ex.toString()));
        return false;
      } else {
        throw new ApiReportedRuntimeException(ex.getCode(), "action:move", source);
      }
    }
    if(result.getCode() >= 300) {
      throw new ApiReportedRuntimeException(result.getCode(), "action:move", source);
    }

    return true;
  }

  public boolean apiProvidedMTime(String path, Date provided_mtime) {
    DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX");

    clearPathFromCache(path);
    FormBody.Builder body = new FormBody.Builder();
    body.add("provided_mtime", sdf.format(provided_mtime));

    try {
      RequestResult result = restPatch(PathUtils.concatSafeUri(API_PATH_FILES, rootPath, path), body);
      if ((result.code == 200 || result.code == 201) && result.json.getAsJsonObject().has("id")) {
        String cacheKey = "path:" + siteId + ":stat:" + PathUtils.normPath(PathUtils.concatPath(rootPath, path)) + ":" + username;
        putCache(cacheKey, (JsonObject) result.json);
      }
      if (result.code == 200 || result.code == 201) {
        return true;
      }
    } catch (ApiErrorException | ApiRuntimeException ex) {
      log.error(logMsg(ex.getMessage()));
    }

    return false;
  }


  public long upload(String name, InputStream in, long offset, Map<String, Object> options) throws ApiForbiddenException, org.eclipse.jetty.io.EofException {
    LinkedList<ApiPartResponse> apiResults;
    long uploadId;
    ApiUploadResponse upload = null;

    // get our next upload
    try {
      // We need anything looking like a resume to fall through
      if (offset <= 0) {
        upload = S3UploadCache.getInstance().poll(uploadsCacheKey);
      }
      if (upload != null) {
        apiResults = upload.getUploadsAsLinkedList();
        uploadId = upload.getId();
      } else {
        uploadId = 0;
        String apiCallPath = PathUtils.concatSafeUri(API_PATH_FILES, rootPath, name);
        apiResults = requestUploadPart(apiCallPath, 1, null, offset);
      }
      apiGetUploads();
    } catch (ApiErrorException ex) {
      ApiReportedRuntimeException proxy_ex = new ApiReportedRuntimeException(ex.getCode(), "action:put", PathUtils.normPath(name));
      log.warn(logMsg(proxy_ex.getBrickMessage()));
      throw new ApiForbiddenException("");
    } catch (ApiReportedRuntimeException ex) {
      throw new ApiForbiddenException("");
    } catch (ApiRuntimeException | ApiForbiddenException ex) {
      log.warn(logMsg(ex.getMessage()));
      throw new ApiForbiddenException("");
    }
    return apiUpload(name, in, offset, apiResults, uploadId, options);
  }


  public OutputStream createUploadOutputStream(String path, long offset, Map<String, Object> options) throws IOException {
    PipedInputStream pipedIn = new PipedInputStream(true);
    PipedOutputStream pipedOut = new PipedOutputStream(pipedIn);
    LinkedList<ApiPartResponse> apiResults;
    long uploadId;
    ApiUploadResponse upload = null;

    // get our next upload
    try {
      // We need anything looking like a resume to fall through
      if (offset <= 0) {
        upload = S3UploadCache.getInstance().poll(uploadsCacheKey);
      }
      if (upload != null) {
        apiResults = upload.getUploadsAsLinkedList();
        uploadId = upload.getId();
      } else {
        uploadId = 0;
        String apiCallPath = PathUtils.concatSafeUri(API_PATH_FILES, rootPath, path);
        apiResults = requestUploadPart(apiCallPath, 1, null, offset);
      }
      apiGetUploads(); // prefetch more uploads, once we know the user is uploading
    } catch (ApiErrorException ex) {
      ReportableIOException proxy_ex = new ReportableIOException(ex.getCode(), "action:put", PathUtils.normPath(path));
      log.warn(logMsg(proxy_ex.getBrickMessage()));
      throw proxy_ex;
    } catch (ApiReportedRuntimeException ex) {
      throw new ReportableIOException(ex);
    } catch (ApiRuntimeException | ApiForbiddenException ex) {
      log.warn(logMsg(ex.getMessage()));
      throw new IOException(logMsg(ex.getMessage()));
    }


    new Thread(new Runnable() {
      @Override
      public void run() {
        try {
          apiUpload(path, pipedIn, offset, apiResults, uploadId, options);
        } catch (ApiReportedRuntimeException ex) {
          pipedIn.setTriggerException(new ReportableIOException(ex));
        } catch (ApiRuntimeException | ApiForbiddenException ex) {
          log.warn(logMsg(ex.getMessage()));
          pipedIn.setTriggerException(ex);
        } catch (NullPointerException ex) {
          log.warn(logMsg(ex.getMessage()));
          pipedIn.setTriggerException(ex);
        } catch (org.eclipse.jetty.io.EofException ex) {
          log.error(ex);
        }
        pipedIn.complete();
      }
    }).start();
    return pipedOut;
  }

  private long apiUpload(String path, InputStream inputStream, long offset, LinkedList<ApiPartResponse> apiResults) throws ApiForbiddenException, org.eclipse.jetty.io.EofException {
    return apiUpload(path, inputStream, offset, apiResults, 0L, new HashMap<String, Object>());
  }

  private long apiUpload(String path, InputStream inputStream, long offset, LinkedList<ApiPartResponse> apiResults, long uploadId, Map<String, Object> options) throws ApiForbiddenException, org.eclipse.jetty.io.EofException {
    if (inputStream == null) {
      inputStream = new ByteArrayInputStream(new byte[0]);
    }
    boolean bFailing = false;
    boolean bSafeToFinalize = true;
    HashMap<Integer, String> etags = new HashMap<>();
    MessageDigest MD5 = null;
    MessageDigest CRC32B = null;
    try {
      MD5 = MessageDigest.getInstance("MD5");
      CRC32B = MessageDigest.getInstance("CRC32B");
    } catch (NoSuchAlgorithmException e) {
      log.error(e);
    }

    DigestInputStream isMD5 = new DigestInputStream(inputStream, MD5);
    DigestInputStream isCRC = new DigestInputStream(isMD5, CRC32B);

    clearPathFromCache(path);

    List<NameValuePair> params;
    long uploadSize = 0;
    RequestResult result;
    String originalPath = PathUtils.normPath(path);
    String apiPath = PathUtils.concatSafeUri(API_PATH_FILES, rootPath, path);
    String ref = null;
    int part = 1;
    ApiPartResponse apiResult;
    try {
      long partsize = 5242880L; // default 5mb
      long length;

      do {
        long startTime = System.currentTimeMillis();
        if (apiResults != null && apiResults.size() > 0) {
          apiResult = apiResults.pollFirst();
        } else {
          apiResult = null;
        }

        if (apiResult == null || (apiResult != null && apiResult.getRef() == null)) {
          apiResults = requestUploadPart(apiPath, part, ref, offset);
          apiResult = apiResults.pollFirst();
        }

        if (part == 1) {
          partsize = apiResult.getPartsize();
          ref = apiResult.getRef();
        } else {
          partsize = apiResult.getPartsize();
        }

        // make sure we don't end up with missmatched parts
        if (apiResult.getPart_number() != part) {
          log.error(logMsg("User needed part_number: " + part + " but had: " + apiResult.getPart_number()));
          bSafeToFinalize = false;
          throw new ApiReportedRuntimeException(413, "action:put", originalPath);
        }


        if (part > apiResult.getAvailable_parts()) {
          log.error(logMsg("User needed part_number: " + part));
          bSafeToFinalize = false;
          throw new ApiReportedRuntimeException(413, "action:put", originalPath);
        }

        if (lastEventException != null) {
          throw new ApiReportedRuntimeException(lastEventException.getCode(), "action:put", originalPath);
        }


        try (ByteArrayOutputStream bOutput = new ByteArrayOutputStream()) {
          length = IOUtils.copyLarge(isCRC, bOutput, 0, partsize);
          // we are at the end of the stream
          if (length <= 0 && part > 1) {
            break;
          }

          // we have an expired part request, we need to fetch new one(s)
          if ((new Date()).compareTo(apiResult.getExpiresAsDate()) >= 0) {
            apiResults = requestUploadPart(apiPath, part, ref, offset);
            apiResult = apiResults.pollFirst();
            if (apiResult == null) {
              throw new ApiReportedRuntimeException(413, "action:put", originalPath);
            }
          }

          // When we have the a full first part, send a async request to name the path for the pre-fetched uploads
          if (part == 1 && length == partsize) {
            apiSetUploadPath(uploadId, originalPath);
          }

          long s3StartTime = System.currentTimeMillis();

          URI uri = new URIBuilder(apiResult.getUpload_uri()).build();

          int upstreamStatus = 600;
          String upstreamFailureBody = "";
          boolean bSafeToRetryS3 = false;
          do {
            OkHttpClient.Builder clientBuilder;
            if (Config.getInstance().getAllowInsecureBackend()) {
              log.info(logMsg("INSECURE REQUEST: S3"));
              clientBuilder = InsecureHttpClient.getInstance().getDefault().newBuilder();
            } else {
              clientBuilder = StandardHttpClient.getInstance().getDefault().newBuilder();
            }

            clientBuilder.retryOnConnectionFailure(true);

            OkHttpClient client = clientBuilder.build();

            Response response = null;
            try {
              RequestBody requestBody = RequestBody.create(bOutput.toByteArray(), MediaType.parse("application/octet-stream"),(int)offset, bOutput.toByteArray().length);

              Request request = new Request.Builder().put(requestBody).header("Content-Type", "application/octet-stream").removeHeader("Transfer-Encoding").url(Utils.forceMandatoryUriEncode(uri.toString())).build();
              response = client.newCall(request).execute();
              upstreamStatus = response.code();
              // report the response code to Statsd/Metrics
              stats.setS3ResponseCodeCount("put", upstreamStatus);
              if (upstreamStatus >= 400) {
                upstreamFailureBody = response.body().string();
              } else if(response.header("ETag") != null) {
                etags.put(part, response.header("ETag"));
              }
            } catch (IOException ex) {
              HBClient.getInstance().reportError(ex);
              log.debug(logMsg("S3 Connection Exception: " + uri));
              upstreamStatus = 502;
            } finally {
              response.body().close();
            }
            if (upstreamStatus == 400 && upstreamFailureBody.contains("RequestTimeout")) {
              bSafeToRetryS3 = true;
            } else if (Config.getInstance().getS3RetryAllowed() && upstreamStatus >= 500 && upstreamStatus != 600 && (System.currentTimeMillis() - s3StartTime) < 18 * 1000) {
              bSafeToRetryS3 = true;
            } else {
              bSafeToRetryS3 = false;
            }
          } while (bSafeToRetryS3);

          bOutput.close(); // close our outputStream used for the HTTP request
          if (upstreamStatus >= 400) {
            if (part == 1) {
              bSafeToFinalize = false;
            }
            log.error(logMsg("S3 Upstream Failure Code: " + upstreamStatus + " [" + upstreamFailureBody + "]"));
            throw new ApiReportedRuntimeException(0, "aws:put", originalPath);
          }

          log.debug(logMsg("Elapsed Millis S3: " + Long.toString(System.currentTimeMillis() - s3StartTime)));
        }

        log.debug(logMsg("Elapsed Millis Part: " + Long.toString(System.currentTimeMillis() - startTime)));
        uploadSize += length;
        part++;

      } while (length == partsize);

    } catch (ApiErrorException e) {
      bFailing = true;
      throw new ApiReportedRuntimeException(e.getCode(), "action:put", originalPath);
    } catch (ApiReportedRuntimeException e) {
      bFailing = true;
      throw e;
    } catch (URISyntaxException | IOException e) {
      if (e instanceof org.eclipse.jetty.io.EofException) {
        throw (org.eclipse.jetty.io.EofException) e;
      }
      StringWriter sw = new StringWriter();
      PrintWriter pw = new PrintWriter(sw);
      e.printStackTrace(pw);
      log.debug(logMsg(sw.toString())); // stack trace as a string
      bFailing = true;
      throw new ApiRuntimeException(e);
    } finally {

      clearPathFromCache(path); // clear at the end as well as the beginning

      if (part == 1) {
        bSafeToFinalize = false;
      }

      if (ref == null || ref.isEmpty()) {
        bSafeToFinalize = false;
      }

      if (bSafeToFinalize) {
        if (bFailing) {
          log.warn(logMsg("forcing finalize during exception"));
        }

        JsonObject finalizationRequest = new JsonObject();
        finalizationRequest.addProperty("action", "end");
        finalizationRequest.addProperty("ref", ref);
        if (offset <= 0) { // not resuming
          if (optionsForPath.containsKey(path)) {
            options.putAll(optionsForPath.get(path));
            optionsForPath.remove(path);
          }
          finalizationRequest.addProperty("md5", Hex.encodeHexString(isMD5.getMessageDigest().digest()));
          finalizationRequest.addProperty("crc32b", Hex.encodeHexString(isCRC.getMessageDigest().digest()));
          finalizationRequest.addProperty("length", Long.toString(uploadSize));
          if (options != null && options.containsKey("provided_mtime") && options.get("provided_mtime") != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX");
            sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
            finalizationRequest.addProperty("provided_mtime", sdf.format((Date) options.get("provided_mtime")));
          }
        }
        JsonArray jsonEtags = new JsonArray();
        etags.forEach((k,v) -> {
          JsonObject etag = new JsonObject();
          etag.addProperty("part", k);
          // AWS can send double quoted values but we don't want to send that to the BrickFTP API escaped like that
          etag.addProperty("etag", v);
          jsonEtags.add(etag);
        });

        finalizationRequest.add("etags", jsonEtags);

        Gson gson = new GsonBuilder().serializeNulls().setFieldNamingPolicy(FieldNamingPolicy.UPPER_CAMEL_CASE).create();
        String body = finalizationRequest.toString();
        try {
          log.debug(logMsg("POST BODY: " + gson.toJson(finalizationRequest)));
        }catch(Exception ex) {
          HBClient.getInstance().reportError(ex);
          log.error(logMsg("UnsupportedEncodingException on upload finalization"));
          throw new ApiReportedRuntimeException(500, "action:end", originalPath);
        }

        String finalBody = body;
        RequestBody requestBody = new RequestBody() {
          @Override
          public MediaType contentType() {
            return MediaType.parse("application/json; charset=utf-8");
          }

          @Override
          public void writeTo(BufferedSink bufferedSink) throws IOException {
            bufferedSink.write(finalBody.toString().getBytes());
          }
        };

        try {
          if ((result = restPost(apiPath,null, requestBody, true)).isError()) {
            if (!bFailing) {
              throw new ApiReportedRuntimeException(result.getCode(), "action:end", originalPath);
            } else {
              log.error(logMsg("finalize during exception failed: " + result.getError()));
            }
          } else {
            if (result.code == 201 && result.json.getAsJsonObject().has("id")) {
              String cacheKey = "path:" + siteId + ":stat:" + PathUtils.normPath(PathUtils.concatPath(rootPath, path)) + ":" + username;
              putCache(cacheKey, (JsonObject) result.json);
            }
          }
        } catch (ApiErrorException ex) {
          throw new ApiReportedRuntimeException(ex.getCode(), "action:end", originalPath);
        }
      }
    }

    if (stats != null) {
      stats.setTotalUploadNumber();
      stats.setTotalUploadSize(uploadSize);
      stats.setSiteTotalUploadNumber(siteId);
    }

    return uploadSize;
  }

  private LinkedList<ApiPartResponse> requestUploadPart(String path, int part, String ref, long offset)  throws ApiErrorException, ApiForbiddenException, ApiRuntimeException {
    RequestResult result;


    MultipartBody.Builder body = new MultipartBody.Builder();
    body.setType(MultipartBody.FORM);
    body.addFormDataPart("action", "put");
    body.addFormDataPart("part", Integer.toString(part));
    body.addFormDataPart("parts", Integer.toString(MAX_PARTS_PER_API_REQUEST));

    if (Config.getInstance().getAwsRegion() != null) {
      body.addFormDataPart("preferred_region", Config.getInstance().getAwsRegion());
    }
    if (useSpdy) {
      body.addFormDataPart("prefer_spdy", "true");
    }

    if (part == 1 && offset > 0) {
      body.addFormDataPart("restart", Long.toString(offset));
    }
    if (ref != null) {
      body.addFormDataPart("ref", ref);
    }
    if ((result = restPost(path, body, null, true)).code == 403) {
      throw new ApiErrorException(403, result.getError());
    }
    if (result.isError()) {
      throw new ApiErrorException(result.getCode(), result.getError());
    }


    // if we only get a single object response, deserialize it to our obj and add it to the list
    if (result.json instanceof JsonObject) {
      Type apiPartResponseType = new TypeToken<ApiPartResponse>() {
      }.getType();
      Gson gson = new Gson();
      LinkedList<ApiPartResponse> list = new LinkedList<ApiPartResponse>();
      list.add(gson.fromJson(result.json, apiPartResponseType));
      return list;
    }

    Type apiPartResponseType = new TypeToken<LinkedList<ApiPartResponse>>() {
    }.getType();
    Gson gson = new Gson();
    return gson.fromJson(result.json, apiPartResponseType);
  }


  private RequestResult restDelete(String path) throws ApiErrorException {
    return restDelete(path, new FormBody.Builder());
  }

  private RequestResult restDelete(String path, FormBody.Builder body) throws ApiErrorException {
    try {
      URIBuilder builder = new URIBuilder(apiRoot);
      builder.setPath(path);

      Request.Builder request = new Request.Builder();
      request.delete(body.build());
      request.url(builder.build().toString());
      return restRequest(request);
    } catch (URISyntaxException e) {
      throw new ApiRuntimeException(e);
    }
  }

  private RequestResult restGet(String path) throws ApiErrorException {
    return restGet(path, null);
  }

  private RequestResult restGet(String path, List<NameValuePair> params) throws ApiErrorException {
    try {
      URIBuilder builder = new URIBuilder(apiRoot);
      builder.setPath(path);
      if (params != null) {
        builder.addParameters(params);
      }
      URI uri = builder.build();

      Request.Builder request = new Request.Builder();
      request.url(Utils.forceMandatoryUriEncode(uri.toString()));

      return restRequest(request);
    } catch (URISyntaxException e) {
      throw new ApiRuntimeException(e);
    }
  }

  private RequestResult restPatch(String path) throws ApiErrorException {
    return restPatch(path, null, true);
  }

  private RequestResult restPatch(String path, FormBody.Builder body) throws ApiErrorException {
    return restPatch(path, body, true);
  }

  private RequestResult restPatch(String path, FormBody.Builder body, boolean retryWhileOverrate) {
    try {
      URIBuilder builder = new URIBuilder(apiRoot);
      builder.setPath(path);

      URI uri = builder.build();

      Request.Builder request = new Request.Builder();
      request.url(Utils.forceMandatoryUriEncode(uri.toString()));
      if (body != null){
        request.patch(body.build());
      }
      try {
        return restRequest(request, retryWhileOverrate);
      } catch (ApiErrorException ex) {
        log.error(logMsg(ex.toString()));
        return null;
      }
    } catch (URISyntaxException  e) {
      throw new ApiRuntimeException(e);
    }
  }

  private RequestResult restPost(String path) throws ApiErrorException {
    return restPost(path, null, null, true);
  }

  private RequestResult restPost(String path, MultipartBody.Builder formBody, RequestBody requestBody) throws ApiErrorException {
    return restPost(path, formBody, requestBody, true);
  }

  private RequestResult restPost(String path, MultipartBody.Builder postBody, RequestBody requestBody, boolean retryWhileOverrate) throws ApiErrorException {
    try {
      URIBuilder builder = new URIBuilder(apiRoot);
      builder.setPath(path);
      Request.Builder request = new Request.Builder();
      if (postBody != null) {
        request.post(postBody.build());
      }
      else if (requestBody != null) {
        request.post(requestBody);
      } else {
        request.post(RequestBody.create(new byte[0]));
      }


      request.url(Utils.forceMandatoryUriEncode(builder.build().toString()));

      return restRequest(request, retryWhileOverrate);
    } catch (URISyntaxException e) {
      throw new ApiRuntimeException("", e);
    }
  }

  private RequestResult restRequest(Request.Builder request) throws ApiErrorException {
    return restRequest(request, true);
  }

  private RequestResult restRequest(Request.Builder request, boolean retryWhileOverrate) throws ApiErrorException {
    boolean isOverrate = false;
    int retryAttempts = 0;
    String cursor = null;
    try {

      // Inner loop, and try to retry when the request fails or is over the rate limt
      do {
        try {
          OkHttpClient client;
          if (Config.getInstance().getAllowInsecureBackend()) {
            log.info(logMsg("INSECURE REQUEST"));
            client = InsecureHttpClient.getInstance().getDefault();
          } else {
            client = StandardHttpClient.getInstance().getDefault();
          }

          request.header("X-TrustedRelay-Auth", KeyUtils.getHMAC());
          if (!this.remoteIP.isEmpty()) {
            request.header("X-Brick-Remote-Addr", remoteIP);
          }
          if (!this.localIP.isEmpty()) {
            request.header("X-Brick-Local-Addr", localIP);
          }
          if (!this.acceptLanuage.isEmpty()) {
            request.header("Accept-Language", this.acceptLanuage);
          }
          if (this.encryptionCipher != null && !this.encryptionCipher.isEmpty()) {
            request.header("X-SSL-Cipher", this.encryptionCipher);
          }
          if (this.encryptionProtocol != null && !this.encryptionProtocol.isEmpty()) {
            request.header("X-SSL-Protocol", this.encryptionProtocol);
          }
          if (BuildNumber.getInstance().getUserAgentString().length() > 0) {
            request.header(HttpHeaders.USER_AGENT, BuildNumber.getInstance().getUserAgentString());
          }


          String cookies = "BrickAPI=" + apiKey;
          request.header("Cookie", cookies);
          Request requested = request.build();
          log.debug(logMsg("REQUEST:  " + requested));
          Response response = null;
          try {
            response = client.newCall(requested).execute();

            int status = response.code();

            String stringEntity = null;
            stringEntity = response.body().string();
            response.body().close();

            JsonParser parser = new JsonParser();
            JsonElement jResponse = null;
            RequestResult result = null;

            if (response.header("x-files-cursor") != null) {
              cursor = response.header("x-files-cursor");
            }

            if (stringEntity.length() == 0) {
              if (status != 204) {
                log.error(logMsg("HttpClient gateway returned [" + status + "] with empty content"));
                throw new ApiRuntimeException("", "HttpClient gateway returned [" + status + "] with empty content");
              } else {
                result = new RequestResult(stringEntity, status, cursor);
              }
            } else {
              try {
                jResponse = parser.parse(stringEntity);
                result = new RequestResult(jResponse, status, cursor);
              } catch (Exception e) {
                result = new RequestResult(stringEntity, status, cursor);
              }
            }



            log.debug(logMsg("RESPONSE[" + status + "] (" + request.toString() + "): " + stringEntity));


            // result code >= 500 and not a valid json encoded error message
            if (status >= 501 && (result.getError() != null || result.json != null && !result.json.isJsonObject())) {
              log.error(logMsg("HttpClient got unknown 5XX of [" + status + "] with invalid json."));
              isOverrate = true;
              throw new ApiOverRateException();
            }

            if (result.isError() && result.code == 429 && has429LoginLockoutIpFailure(result.json)) {
              return result;
            }else if(result.isError() && result.code == 429) {
              throw new ApiOverRateException();
            }

            if (result.isError() && !result.isHTTPClientError()) {
              throw new ApiErrorException(result.code, result.getError());
            }

            return result;
          } catch (ApiMissingGatewayException | ApiOverRateException e) {
            log.error(logMsg("Over-rate or retry-able error encountered."));
            retryAttempts += 1;

            if (!retryWhileOverrate || (retryAttempts * SLEEP_TIME_MS) >= MAX_SLEEP_RETRY_TIME_MS) {
              throw e;
            }

            log.error(logMsg("sleeping..."));
            sleep(SLEEP_TIME_MS);
          }
        } catch (IOException | NullPointerException e) {
          log.error(logMsg("HttpClient exception: " + e.getMessage()));
          retryAttempts += 1;

          if (!retryWhileOverrate || (retryAttempts * SLEEP_TIME_MS) >= MAX_SLEEP_RETRY_TIME_MS) {
            throw new ApiRuntimeException("", "IOException retry expired");
          }

          isOverrate = true;
          sleep(SLEEP_TIME_MS); // We want to sleep so we have time to recover
        }
      } while (isOverrate);

    } catch (org.apache.http.ParseException | ClassCastException | JsonSyntaxException e) {
      log.error(logMsg("Parse Exception: " + e.getMessage()));

      throw new ApiRuntimeException("", e); // Don't pass the parent message it might leak
    }

    return null;
  }

  private boolean has429LoginLockoutIpFailure(JsonElement json) {
    if (json != null && json.isJsonObject() && ((JsonObject)json).has("errors")) {
      JsonArray errors = ((JsonObject)json).getAsJsonArray("errors");
      for (JsonElement a: errors) {
        if(((JsonObject)a).has("type") && ((JsonObject)a).get("type").getAsString().equals("429-login-lockout-ip-failures")) {
          return true;
        }
      }
    }

    return false;
  }

}
