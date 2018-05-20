package cascheid.battleship;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException;

import cascheid.blitzball.BattleshipGameManager;

@Component
public class BattleshipHandler extends TextWebSocketHandler {
	@Autowired
	private BattleshipGameManager battleshipGameManager;
	
	ObjectMapper objectMapper = new ObjectMapper();
	Map<Long, ActiveBattleshipGame> games = new HashMap<Long, ActiveBattleshipGame>();
	HashMap<Long, WebSocketSession> sessions = new HashMap<Long, WebSocketSession>();
	Map<Long, Long> activeGameIDs = new HashMap<Long, Long>();
	
	
	@Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        super.handleTextMessage(session, message);
        ActiveBattleshipGame game;
        try{
            BattleshipGame gameInfo = objectMapper.readValue(message.asBytes(), BattleshipGame.class);
            Long gameID=gameInfo.getGameID();
            game = games.get(gameID);
            if (game==null){
            	BattleshipGame newGame = BattleshipUtils.getBattleshipGameByID(gameInfo.getGameID());
            	game = new ActiveBattleshipGame(newGame, BattleshipUtils.getBattleshipBoard(gameID, newGame.getUser1()), BattleshipUtils.getBattleshipBoard(gameID, newGame.getUser2()), BattleshipUtils.getBattleshipMoves(gameID, newGame.getUser1()), BattleshipUtils.getBattleshipMoves(gameID, newGame.getUser2()));
            	game.setUserActive(gameInfo.getUser1());
            	games.put(gameID, game);
            } else if (game.getGame().getUser2()==gameInfo.getUser1()&&game.isNewGame()){//2nd player created the board, let them know
            	game.getGame().setStatus("1TURN");
                game.setNewSecondPlayerBoard();
            	BattleshipMove startMv = new BattleshipMove();
            	startMv.setStatus("start");
                Long oppID=game.getGame().getUser1();
            	String json = objectMapper.writeValueAsString(startMv);
                TextMessage returnMessage = new TextMessage(json);
                WebSocketSession opponent=null;
                if (activeGameIDs.containsKey(oppID)&&activeGameIDs.get(oppID)==game.getGame().getGameID()){
                    opponent=sessions.get(oppID);
                    if (opponent!=null){
                    	opponent.sendMessage(returnMessage);
                    }
                }
            }
            activeGameIDs.put(gameInfo.getUser1(), gameID);
            sessions.put(gameInfo.getUser1(), session);
        } catch (UnrecognizedPropertyException e){
        	BattleshipMove newMv = objectMapper.readValue(message.asBytes(), BattleshipMove.class);
        	game=games.get(activeGameIDs.get(newMv.getUserID()));
        	newMv.setStatus(game.getShotStatus(newMv));
            String json = objectMapper.writeValueAsString(newMv);
            TextMessage returnMessage = new TextMessage(json);
            Long oppID=game.getOpponentID(newMv.getUserID());
            WebSocketSession opponent=null;
            if (activeGameIDs.containsKey(oppID)&&activeGameIDs.get(oppID)==game.getGame().getGameID()){
                opponent=sessions.get(oppID);
                if (opponent!=null){
                	opponent.sendMessage(returnMessage);
                }
            }
            if (newMv.getStatus().startsWith("hit")){
            	newMv.setStatus("hit");
            }
            json = objectMapper.writeValueAsString(newMv);
            returnMessage = new TextMessage(json);
            session.sendMessage(returnMessage);
            if (newMv.getStatus().startsWith("sunk")){
            	if (game.checkUserVictory(newMv.getUserID())){
            		BattleshipMove lastMove=new BattleshipMove();
            		lastMove.setStatus("win");
            		lastMove.setUserID(newMv.getUserID());
            		lastMove.setLoc(newMv.getLoc());
            		String winjson = objectMapper.writeValueAsString(lastMove);
            		TextMessage winMessage = new TextMessage(winjson);
                    session.sendMessage(winMessage);
                    if (opponent!=null){
                    	opponent.sendMessage(winMessage);
                    }
            	}
            }
        }
    }
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Iterator<Entry<Long, WebSocketSession>> it = sessions.entrySet().iterator();
		Long identifier=0l;
		while (it.hasNext()){
			Entry<Long, WebSocketSession> e = it.next();
			if (e.getValue().equals(session)){
				identifier=e.getKey();
				it.remove();
				break;
			}
		}
		Long gameID=activeGameIDs.get(identifier);
		if(games.get(gameID).checkRemoveGameUponClosing(identifier)){
			games.remove(gameID);
		}
		activeGameIDs.remove(identifier);
	}
	
	private class ActiveBattleshipGame{
		BattleshipGame game;
		ActiveBattleshipBoard user1Board;
		ActiveBattleshipBoard user2Board;
		List<BattleshipMove> user1Moves;
		List<BattleshipMove> user2Moves;
		boolean user1Active=false;
		boolean user2Active=false;
		
		public ActiveBattleshipGame(BattleshipGame game, BattleshipBoard user1Board, BattleshipBoard user2Board, List<BattleshipMove> user1Moves, List<BattleshipMove> user2Moves){
			this.game=game;
			this.user1Board=new ActiveBattleshipBoard(user1Board, user2Moves);
			this.user2Board=new ActiveBattleshipBoard(user2Board, user1Moves);
			this.user1Moves=user1Moves;
			this.user2Moves=user2Moves;
		}
		
		public BattleshipGame getGame(){
			return game;
		}
		
		public boolean isNewGame(){
			return (user1Moves.size()==0&&game.getStatus().equals("2TURN"));
		}
		
		public void setNewSecondPlayerBoard(){
			BattleshipBoard board = BattleshipUtils.getBattleshipBoard(game.getGameID(), game.getUser2());
			this.user2Board=new ActiveBattleshipBoard(board, user1Moves);
		}
		
		public void setUser1Active(boolean user1Active){
			this.user1Active=user1Active;
		}
		
		public void setUser2Active(boolean user2Active){
			this.user2Active=user2Active;
		}
		
		public Long getOpponentID(Long identifier){
			if (identifier==game.getUser1()){
				return game.getUser2();
			} else if (identifier==game.getUser2()){
				return game.getUser1();
			} else{
				return null;
			}
		}
		
		public void setUserActive(Long identifier){
			if (identifier.equals(game.getUser1())){
				this.user1Active=true;
			} else if (identifier.equals(game.getUser2())){
				this.user2Active=true;
			} else {
				throw new IllegalStateException("UserID doesn't match game.");
			}
		}
		
		public boolean checkRemoveGameUponClosing(Long identifier){
			if (identifier.equals(game.getUser1())){
				setUser1Active(false);
			} else if (identifier.equals(game.getUser2())){
				setUser2Active(false);
			} else {
				throw new IllegalStateException("UserID doesn't match game.");
			}
			
			return (!user1Active&&!user2Active);
		}
		
		public boolean checkUserVictory(Long identifier){
			if (identifier.equals(game.getUser1())){
				if (user2Board.checkAllSunk()){
					BattleshipUtils.updateBattleshipGameStatus(game.getGameID(), "1WIN");
					return true;
				}
			} else if (identifier.equals(game.getUser2())){
				if (user1Board.checkAllSunk()){
					BattleshipUtils.updateBattleshipGameStatus(game.getGameID(), "2WIN");
					return true;
				}
			} else {
				throw new IllegalStateException("UserID doesn't match game.");
			}
			
			return false;
		}
		
		public String getShotStatus(BattleshipMove mv){
			String sReturn="illegal";
			if (mv.getUserID().equals(game.getUser1())){
				if (game.getStatus().equals("1TURN")){
					if (user1Moves.contains(mv)){
						sReturn="illegal";
					} else {
						sReturn="miss";
						String hit=user2Board.getBoard().checkHit(mv.getLoc());
						if (!"".equals(hit)){
							sReturn=user2Board.assignHit(hit)+hit;
						}
						if (sReturn!=null&&!"illegal".equals(sReturn)){
							mv.setStatus(sReturn);
							user1Moves.add(mv);
							BattleshipUtils.insertBattleshipMove(game.getGameID(), mv);
							BattleshipUtils.updateBattleshipGameStatus(game.getGameID(), "2TURN");
							game.setStatus("2TURN");
							/*if (sReturn.equals("sunk")){
								sReturn+=hit;
							}*/
						}
					}
				}
			} else if (mv.getUserID().equals(game.getUser2())){
				if (game.getStatus().equals("2TURN")){
					if (user2Moves.contains(mv)){
						sReturn="illegal";
					} else {
						sReturn="miss";
						String hit=user1Board.getBoard().checkHit(mv.getLoc());
						if (!"".equals(hit)){
							sReturn=user1Board.assignHit(hit)+hit;
						}
						if (!"illegal".equals(sReturn)){
							user2Moves.add(mv);
							mv.setStatus(sReturn);
							BattleshipUtils.insertBattleshipMove(game.getGameID(), mv);
							BattleshipUtils.updateBattleshipGameStatus(game.getGameID(), "1TURN");
							game.setStatus("1TURN");
							/*if (sReturn.equals("sunk")){
								sReturn+=hit;
							}*/
						}
					}
				}
			} else {
				throw new IllegalStateException("User ID doesn't match game.");
			}
			return sReturn;
		}
	}
	
	private class ActiveBattleshipBoard{
		private BattleshipBoard board;
		private int carrierHealth=5;
		private int battleshipHealth=4;
		private int destroyerHealth=3;
		private int submarineHealth=3;
		private int patrolHealth=2;
		
		public ActiveBattleshipBoard(BattleshipBoard board, List<BattleshipMove> oppMoves){
			this.setBoard(board);
			for (BattleshipMove mv : oppMoves){
				if (mv.getStatus().equals("sunkcarrier")){
					carrierHealth=0;
				}
				if (mv.getStatus().equals("sunkbattleship")){
					battleshipHealth=0;
				}
				if (mv.getStatus().equals("sunkdestroyer")){
					destroyerHealth=0;
				}
				if (mv.getStatus().equals("sunksubmarine")){
					submarineHealth=0;
				}
				if (mv.getStatus().equals("sunkpatrol")){
					patrolHealth=0;
				}
				if (mv.getStatus().equals("hitcarrier")){
					carrierHealth--;
				}
				if (mv.getStatus().equals("hitbattleship")){
					battleshipHealth--;
				}
				if (mv.getStatus().equals("hitdestroyer")){
					destroyerHealth--;
				}
				if (mv.getStatus().equals("hitsubmarine")){
					submarineHealth--;
				}
				if (mv.getStatus().equals("hitpatrol")){
					patrolHealth--;
				}
			}
		}

		public BattleshipBoard getBoard() {
			return board;
		}

		public void setBoard(BattleshipBoard board) {
			this.board = board;
		}
		
		public String assignHit(String shipName){
			if ("carrier".equals(shipName)){
				carrierHealth--;
				if (carrierHealth<=0){
					return "sunk";
				}
			} else if ("battleship".equals(shipName)){
				battleshipHealth--;
				if (battleshipHealth<=0){
					return "sunk";
				}
			} else if ("destroyer".equals(shipName)){
				destroyerHealth--;
				if (destroyerHealth<=0){
					return "sunk";
				}
			} else if ("submarine".equals(shipName)){
				submarineHealth--;
				if (submarineHealth<=0){
					return "sunk";
				}
			} else if ("patrol".equals(shipName)){
				patrolHealth--;
				if (patrolHealth<=0){
					return "sunk";
				}
			} else {
				return "illegal";
			}
			return "hit";
		}
		
		public boolean checkAllSunk(){
			return (carrierHealth<=0&&battleshipHealth<=0&&destroyerHealth<=0&&submarineHealth<=0&&patrolHealth<=0);
		}
	}
}
