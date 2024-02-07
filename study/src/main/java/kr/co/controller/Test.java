package kr.co.controller;
 
import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/*.xml" })
public class Test {
 
    @Inject
    private DataSource datas;
 
    @org.junit.Test
    public void testConnection() throws Exception {
        try (Connection con = datas.getConnection()) {
            System.out.println(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}