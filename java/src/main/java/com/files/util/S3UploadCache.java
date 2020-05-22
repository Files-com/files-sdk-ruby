package com.files.util;

import com.files.net.ApiUploadResponse;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.logging.log4j.Logger;

public class S3UploadCache {
  private static final Logger log = Logger.getLogger(PathCache.class);

  private static S3UploadCache instance = null;
  private static List queue = Collections.synchronizedList(new ArrayList());
  // This is wrapped to make sure it's thread safe
  private SortedLRUMap<String, LinkedList<ApiUploadResponse>> cache = new SortedLRUMap<String, LinkedList<ApiUploadResponse>>(4000);


  protected S3UploadCache() {
  }

  // thread safe
  public static S3UploadCache getInstance() {
    if (instance == null) {
      synchronized (S3UploadCache.class) {
        if (instance == null) {
          instance = new S3UploadCache();
        }
      }
    }
    return instance;
  }

  public int cacheSize() {
    return cache.size();
  }

  public int size(String key) {
    LinkedList<ApiUploadResponse> apiResults = cache.get(key);
    if (apiResults == null) {
      return 0;
    }
    return apiResults.size();
  }


  public ApiUploadResponse poll(String key) {
    // brick gives us 24 hours, but we want to expire at 23 just to be safe
    Long expires = (new Date()).getTime() - (23 * 60 * 60 * 1000);

    LinkedList<ApiUploadResponse> apiResults = cache.get(key);
    if (apiResults == null) {
      return null;
    }
    ApiUploadResponse a;
    synchronized (apiResults) {
      a = apiResults.pollFirst();
    }
    if (a == null) {
      return null;
    }
    if (a.getCreated_atAsDate().getTime() <= expires) {
      log.debug("S3UploadCache[" + key + "] polling next due to expired entry.");
      return this.poll(key);
    }

    return a;
  }

  public void add(String key, ApiUploadResponse v) {
    LinkedList<ApiUploadResponse> apiResults = cache.get(key);
    if (apiResults == null) {
      apiResults = new LinkedList<ApiUploadResponse>();
      cache.put(key, apiResults);
    }
    synchronized (apiResults) {
      apiResults.addLast(v);
    }
  }

  public void addAll(String key, LinkedList<ApiUploadResponse> items) {
    LinkedList<ApiUploadResponse> apiResults = cache.get(key);
    if (apiResults == null) {
      apiResults = new LinkedList<ApiUploadResponse>();
      cache.put(key, apiResults);
    }
    synchronized (apiResults) {
      apiResults.addAll(items);
    }
  }

  public void addFetchInProgress(String k) {
    queue.add(k);
  }

  public void deleteFetchInProgress(String k) {
    queue.remove(k);
  }

  public boolean fetchInProgress(String k) {
    return queue.contains(k);
  }

  public long ageInSeconds() {
    return cache.ageInSeconds();
  }

}
