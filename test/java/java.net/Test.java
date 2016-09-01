package com.test;

import java.io.*;
import java.lang.reflect.Array;
import java.net.*;

public class Test {
    public static String getHTML(String urlToRead) throws Exception {
        StringBuilder result = new StringBuilder();
        URL url = new URL(urlToRead);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String line;
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        rd.close();

        if (url.toString().matches(".*numbers$")) {
            if (result.toString().isEmpty()) { // TODO match on the response code being \d+
                System.err.println("java.net/HttpURLConnection is conflating response code and body, but in a particularly stange way"); // nice consistency on the class casing..
                System.err.println("request url[" + url.toString() + "]");
                System.err.println("response body[" + result.toString() + "]");
                System.err.println("response code[" + conn.getResponseCode() + "]");
                System.exit(1);
            }
        }
        return result.toString();
    }

    public static void main(String[] args) throws Exception
    {
        String meta = getHTML("http://1863BFAF.pwnz.org:4567/meta");
        System.out.println(meta);

        // split on , strip quotes and iterate
        String[] results = meta.split(",");

        for (String result : results) {
            String lresult  = result.toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", "");
            String response = getHTML(lresult);
            System.out.println("url:[" + lresult + "] response[" + response + "]");
        }

    }

}
