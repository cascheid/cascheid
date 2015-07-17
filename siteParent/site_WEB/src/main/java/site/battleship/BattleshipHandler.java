package site.battleship;

import java.util.ArrayList;
import java.util.List;



import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.ObjectMapper;

public class BattleshipHandler extends TextWebSocketHandler {
	BattleshipGame game = new BattleshipGame();
	BattleshipBoard myBoard = null;
	BattleshipBoard theirBoard = null;
	List<BattleshipMove> moves = new ArrayList<BattleshipMove>();
	ObjectMapper objectMapper = new ObjectMapper();
	
	@Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        super.handleTextMessage(session, message);
        
        if (game==null){//just now loading handler
        	
        } else {
        	BattleshipMove newMv = objectMapper.readValue(message.asBytes(), BattleshipMove.class);
        	for (BattleshipMove mv : moves){
        		if (mv.equals(newMv)){//already fired here
        			newMv.setStatus("repeat");
        			break;
        		}
        	}
        	if (!newMv.getStatus().equals("repeat")){
        		//TODO battleshipUtils
                newMv.setStatus("hit");
        	}
            String json = objectMapper.writeValueAsString(newMv);
            TextMessage returnMessage = new TextMessage(json);
            session.sendMessage(returnMessage);
        }
    }
}
