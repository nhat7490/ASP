package com.caps.asp.util;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;
import com.google.maps.model.LatLng;

public class GoogleAPI {
    private static final String API_KEY = "AIzaSyCOgT-ZG2h-mTHElFEiv_3EJXFTppNgIAk";

    public GeocodingResult getLocationName(double latitudeDeg, double longitudeDeg) {

        GeoApiContext context = new GeoApiContext.Builder()
                .apiKey(API_KEY)
                .build();

        String name = "(Unknown)";
        try {
            GeocodingResult[] results = GeocodingApi
                    .reverseGeocode(context, new LatLng(latitudeDeg, longitudeDeg)).await();

            // There may be multiple results with sequentially less data in each;
            // just return the first one, since it should have the most info.
            for (GeocodingResult result : results) {
                return result;
            }
        }
        catch (Exception e) {
        }

        return null;
    }
}
