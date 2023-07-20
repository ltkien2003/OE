package com.poly.extensions;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.List;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.VideoListResponse;
import com.google.api.services.youtube.model.VideoSnippet;

@SuppressWarnings({ "deprecation", "unused" })
public class YouTubeAPI {
	public static boolean checkIdVideo(String id) {
		try {
	        String apiKey = "AIzaSyDjB_Pi1Jia370Gutro1YglOx2HzseGl7U";
	        String videoUrl = "https://youtu.be/" + id;

	        String[] urlParts = videoUrl.split("/");
	        String videoId = urlParts[urlParts.length - 1];

	        HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
	        JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();

			GoogleCredential credential = new GoogleCredential.Builder()
	                .setTransport(httpTransport)
	                .setJsonFactory(jsonFactory)
	                .build();

	        YouTube youtube = new YouTube.Builder(httpTransport, jsonFactory, new HttpRequestInitializer() {
	            public void initialize(HttpRequest request) throws IOException {
	            }
	        }).setApplicationName("Video Resolution Checker").build();

	        List<String> videoFields = Arrays.asList("snippet", "contentDetails", "statistics");
	        YouTube.Videos.List videoRequest = youtube.videos().list(videoFields);
	        videoRequest.setKey(apiKey);
	        videoRequest.setId(Arrays.asList(videoId));
	        VideoListResponse videoResponse = videoRequest.execute();
	        VideoSnippet snippet = videoResponse.getItems().get(0).getSnippet();
	        return true;
		} catch (Exception e) {
			return false;
		}
	}
}