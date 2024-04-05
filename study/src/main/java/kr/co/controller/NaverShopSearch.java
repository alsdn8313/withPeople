package kr.co.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.util.JSONPObject;

public class NaverShopSearch {

	public String search() throws Exception {
        RestTemplate rest = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        //headers.add("X-Naver-Client-Id", "q2rgNFqo261t37lqiYrf");
        //headers.add("X-Naver-Client-Secret", "6WdM8Wq3mI");
        headers.add("X-Naver-Client-Id", "Ht2MQLw6laQKDnwTWTG4");
        headers.add("X-Naver-Client-Secret", "YcqrlzpBex");

        StringBuilder sb = new StringBuilder();
        String body = sb.toString();

        String item = "GAS SH-3500[3]";
        
        HttpEntity<String> requestEntity = new HttpEntity<String>(body, headers);
        ResponseEntity<String> responseEntity = rest.exchange("https://openapi.naver.com/v1/search/shop.json?query="+item+"&exclude=rental:cbshop&sort=asc&display=1", HttpMethod.GET, requestEntity, String.class);
        //ResponseEntity<String> responseEntity = rest.exchange("https://openapi.naver.com/v1/search/shop.json?query="+item+"&include=used&sort=asc&display=1", HttpMethod.GET, requestEntity, String.class);
        HttpStatus httpStatus = responseEntity.getStatusCode();
        int status = httpStatus.value();
        
        JSONPObject json = new JSONPObject(body, responseEntity.getBody());
        
        System.out.println("############################## : " + responseEntity.getBody());
        
        String response = responseEntity.getBody();
        //System.out.println("Response status: " + status);
        //System.out.println(response);

        return response;
    }

    public static void main(String[] args) throws Exception {
        NaverShopSearch naverShopSearch = new NaverShopSearch();
        naverShopSearch.search();
    }


}
