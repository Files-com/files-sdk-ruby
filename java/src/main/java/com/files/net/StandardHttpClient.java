package com.files.net;

import com.files.Config;
import okhttp3.ConnectionPool;
import okhttp3.OkHttpClient;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

import java.util.concurrent.TimeUnit;

public class StandardHttpClient {
  private static StandardHttpClient instance;
  protected static final Logger log = LogManager.getLogger(StandardHttpClient.class);
  protected OkHttpClient okHttpClient;

  protected StandardHttpClient() {
    Config config = Config.getInstance();

    ConnectionPool pool = new ConnectionPool(config.getUpstreamMaxConnections(), config.getUpstreamTimeout(), TimeUnit.MILLISECONDS);
    OkHttpClient.Builder builder = new OkHttpClient.Builder()
      .cache(null)
      .connectionPool(pool)
      .connectTimeout(60, TimeUnit.SECONDS)
      .readTimeout(60, TimeUnit.SECONDS)
      .retryOnConnectionFailure(false)
      .writeTimeout(60, TimeUnit.SECONDS);

    okHttpClient = builder.build();
  }

  public static StandardHttpClient getInstance() {
    if (instance == null) {
      synchronized (StandardHttpClient.class) {
        if (instance == null) {
          instance = new StandardHttpClient();
        }
      }
    }
    return instance;
  }

  public OkHttpClient getDefault() {
    return okHttpClient;
  }
}
