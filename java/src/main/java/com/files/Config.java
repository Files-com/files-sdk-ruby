package com.files;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Properties;
import java.util.zip.ZipEntry;

public class Config {
  private static final Logger log = LogManager.getLogger(Config.class);

  private static Config instance = null;
  private String hostname = "unknown";

  public static final List<String> blacklist_usernames = Arrays.asList("root", "mysql", "apache", "tomcat", "www", "deploy", "administrator");

  public static final List<Integer> upstream_errors = Arrays.asList(502,504);

  private Properties properties;

  protected Config() {
    properties = new Properties();
    try (InputStream file = Config.class.getResourceAsStream("/files-sdk.properties");) {
      properties.load(file);
    } catch (IOException e) {
      log.warn("could not load configurator properties");
    }
  }

  // thread safe
  public static Config getInstance() {
    if (instance == null) {
      synchronized (Config.class) {
        if (instance == null) {
          instance = new Config();
        }
      }
    }
    return instance;
  }

  public boolean getAllowInsecureBackend(String def) {
    return Boolean.valueOf(properties.getProperty("allowInsecureBackend", def).toLowerCase());
  }

  public String getApiRoot(String def) {
    return properties.getProperty("apiRoot", def);
  }

  public int getUpstreamMaxConnections() {
    return Integer.valueOf((properties.getProperty("upstreamMaxConnections", "500")));
  }

  public int getUpstreamTimeout() {
    return Integer.valueOf((properties.getProperty("upstreamTimeout", "5000")));
  }


}
