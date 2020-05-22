package com.files;

import java.io.File;
import java.util.Properties;

import com.files.net.ApiSession;

import org.apache.logging.log4j.Logger;

public class FilesClient {

    private static final Logger log = org.apache.log4j.Logger.getLogger("FTP");

    protected static ApiSession apiSession;
    private Properties properties;

    public FilesClient()
    {
        try (InputStream inputStream = ClassLoader.getSystemResourceAsStream("files.properties")){
            this.properties = inputStream;
        }
        this.apiSession = new ApiSession();
    }
}
