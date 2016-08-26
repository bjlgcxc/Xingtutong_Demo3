package com.springmvc.utils;

import javax.servlet.ServletContextEvent;
import org.springframework.web.util.Log4jConfigListener;

/**
 * Log4j日志监听
 * 
 * @author caixiaocong
 */
public class Log4jConfigListenerExt extends Log4jConfigListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.setProperty("log4j_path",event.getServletContext().getRealPath("/"));
        super.contextInitialized(event);
    }    
}

