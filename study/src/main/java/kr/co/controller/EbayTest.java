package kr.co.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.util.JSONPObject;

public class EbayTest {

	public String search() {
        RestTemplate rest = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("X-Naver-Client-Id", "q2rgNFqo261t37lqiYrf");
        headers.add("X-Naver-Client-Secret", "6WdM8Wq3mI");

        StringBuilder sb = new StringBuilder();
        String body = sb.toString();

        String item = "A06B-6081-H101";
        
        HttpEntity<String> requestEntity = new HttpEntity<String>(body, headers);
        //ResponseEntity<String> responseEntity = rest.exchange("https://openapi.naver.com/v1/search/shop.json?query="+item+"&exclue=rental:cbshop&sort=asc&display=50", HttpMethod.GET, requestEntity, String.class);
        ResponseEntity<String> responseEntity = rest.exchange("https://openapi.naver.com/v1/search/shop.json?query="+item+"&exclue=rental:cbshop&sort=asc&display=50", HttpMethod.GET, requestEntity, String.class);
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
