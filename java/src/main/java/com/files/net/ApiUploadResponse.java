package com.files.net;

import com.actionverb.files.util.HBClient;
import com.actionverb.files.util.Utils;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.Date;
import java.util.LinkedList;

public class ApiUploadResponse {
  long id;
  String path;
  String created_at;
  private JsonArray uploads;

  public ApiUploadResponse(long id, String path, String created_at, JsonArray uploads) {
    this.id = id;
    this.path = path;
    this.created_at = created_at;
    this.uploads = uploads;
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getPath() {
    return path;
  }

  public void setPath(String path) {
    this.path = path;
  }

  public String getCreated_at() {
    return created_at;
  }

  public Date getCreated_atAsDate() {
    Date created_dt = null;

    try {
      if (this.created_at != null && this.created_at.length() > 0) {
        created_dt = Utils.parseApiDateTime(this.created_at);
      }
    } catch (Exception e) {
      HBClient.getInstance().reportError(e);
    } finally {
      if (created_dt == null) {
        created_dt = new Date((new Date()).getTime() - (24 * 60 * 60000)); // return an expired date if we don't get a valid one from the api
      }
    }

    return created_dt;
  }

  public void setCreated_at(String created_at) {
    this.created_at = created_at;
  }

  public JsonArray getUploads() {
    return uploads;
  }

  public LinkedList<ApiPartResponse> getUploadsAsLinkedList() {
    Type apiPartResponseType = new TypeToken<LinkedList<ApiPartResponse>>() {
    }.getType();
    Gson gson = new Gson();
    return gson.fromJson(uploads, apiPartResponseType);
  }

  public void setUploads(JsonArray uploads) {
    this.uploads = uploads;
  }
}
