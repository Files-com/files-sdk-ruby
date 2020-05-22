package com.files.net;

import com.files.Config;
import okhttp3.ConnectionPool;
import okhttp3.OkHttpClient;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.security.cert.CertificateException;
import java.util.concurrent.TimeUnit;

public class InsecureHttpClient {
  private static InsecureHttpClient instance;
  protected static final Logger log = LogManager.getLogger(InsecureHttpClient.class);
  protected OkHttpClient okHttpClient;

  protected InsecureHttpClient() {
    Config config = Config.getInstance();
    ConnectionPool pool = new ConnectionPool(config.getUpstreamMaxConnections(), config.getUpstreamTimeout(), TimeUnit.MILLISECONDS);
    try {
      // Create a trust manager that does not validate certificate chains
      final TrustManager[] trustAllCerts = new TrustManager[]{
        new X509TrustManager() {
          @Override
          public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) throws CertificateException {
          }

          @Override
          public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) throws CertificateException {
          }

          @Override
          public java.security.cert.X509Certificate[] getAcceptedIssuers() {
            return new java.security.cert.X509Certificate[]{};
          }
        }
      };

      // Install the all-trusting trust manager
      final SSLContext sslContext = SSLContext.getInstance("SSL");
      sslContext.init(null, trustAllCerts, new java.security.SecureRandom());
      // Create an ssl socket factory with our all-trusting manager
      final SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();

      OkHttpClient.Builder builder = new OkHttpClient.Builder();
      builder.cache(null);
      builder.connectionPool(pool);
      builder.hostnameVerifier((hostname, session) -> true);
      builder.retryOnConnectionFailure(false);
      builder.sslSocketFactory(sslSocketFactory, (X509TrustManager) trustAllCerts[0]);

      okHttpClient = builder.build();
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  public static InsecureHttpClient getInstance() {
    if (instance == null) {
      synchronized (InsecureHttpClient.class) {
        if (instance == null) {
          instance = new InsecureHttpClient();
        }
      }
    }
    return instance;
  }

  public OkHttpClient getDefault() {
    return okHttpClient;
  }
}
