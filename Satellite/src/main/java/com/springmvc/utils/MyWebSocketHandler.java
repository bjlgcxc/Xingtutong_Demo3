package com.springmvc.utils;

import java.io.IOException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/**
 * WebSocket的处理类,用于前端与后台之间的双端通信
 * 
 * @author caixiaocong
 */
public class MyWebSocketHandler extends TextWebSocketHandler implements WebSocketHandler {
	
	private static final Log log =  LogFactory.getLog(MyWebSocketHandler.class);
	
	WebSocketSession session;
	
	@Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    this.session = session;
	    log.info("webSocket connect.");
    }
	
	// handle message receive
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
	    try {
	        session.sendMessage(new TextMessage("hello"));  
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
    }
    
    // send message
    public void sendMessage() throws IOException{
    	if(session!=null && session.isOpen()){
    		session.sendMessage(new TextMessage("hello"));
    		log.info("webSocket send message");
    	}
    }
  
}  