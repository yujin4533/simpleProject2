package com.simple.project2;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebsocketEchoHandler extends TextWebSocketHandler {

	private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
	private static Logger chattingLogger= LoggerFactory.getLogger("chattingLogger");
	

	@Override
	public void afterConnectionEstablished(WebSocketSession wsession) throws Exception{
		connectedUsers.add(wsession);

		chattingLogger.debug(">> 고유번호 : "+wsession.getId()+" 접속<<");
		chattingLogger.debug(">> 연결PC : "+wsession.getRemoteAddress().getHostName());
		chattingLogger.debug(">> 연결IP : "+wsession.getRemoteAddress().getAddress().getHostAddress());

		for (WebSocketSession webSocketSession : connectedUsers) {
			if (!wsession.getId().equals(webSocketSession.getId()))
				webSocketSession.sendMessage(new TextMessage("[" +wsession.getRemoteAddress().getAddress().getHostAddress().substring(0,6)+ "****]" + "님이 <span style='color: red;'>입장</span>했습니다.")); 
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession wsession, TextMessage message) throws Exception{
		String str_message = message.getPayload();
	
		
        for (WebSocketSession webSocketSession : connectedUsers) {
        	if (!wsession.getId().equals(webSocketSession.getId())) {
            	webSocketSession.sendMessage(
                	new TextMessage("[" +wsession.getRemoteAddress().getAddress().getHostAddress().substring(0,6)+ "****]" + " ▶ " + str_message ));  
            }
        }
 
        chattingLogger.debug(">> 작성IP : "+wsession.getRemoteAddress().getAddress().getHostAddress());
        chattingLogger.debug(">> 작성내용 : "+message.getPayload());
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession wsession, CloseStatus status) throws Exception{
		
		connectedUsers.remove(wsession);
		
		for (WebSocketSession webSocketSession : connectedUsers) {
			if (!wsession.getId().equals(webSocketSession.getId()))
				webSocketSession.sendMessage(new TextMessage("[" +wsession.getRemoteAddress().getAddress().getHostAddress().substring(0,6)+ "****]" + "님이 <span style='color: red;'>퇴장</span>했습니다.")); 
		}
		
		chattingLogger.debug(">> 고유번호 : "+wsession.getId()+" 퇴장<<");
	}
	
	// init-method(@PostConstruct)
	public void init() throws Exception{
		
	}
	
}
