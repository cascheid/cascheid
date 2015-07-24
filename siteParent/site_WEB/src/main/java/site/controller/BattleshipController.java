package site.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import site.battleship.BattleshipBoard;
import site.battleship.BattleshipGame;
import site.battleship.BattleshipMove;
import site.battleship.BattleshipUtils;
import site.battleship.UiBattleshipGame;
import site.identity.Identity;
import site.identity.IdentityUtils;

@Controller
@Scope("session")
public class BattleshipController {
	Identity identity=null;
	Identity activeOpponent=null;
	BattleshipGame activeGame;
	
	@RequestMapping("/battleship")
	public ModelAndView getBattleshipIndex(@CookieValue(value = "identifier", defaultValue = "0") Long identifier){
		ModelAndView mv = new ModelAndView("battleshipList");
		if (identity==null){
			identity=IdentityUtils.getIdentityByIdentifier(identifier);
		}
		List<BattleshipGame> games = BattleshipUtils.getBattleshipGamesByIdentifier(identity.getIdentifier());
		List<UiBattleshipGame> activeGameList = new ArrayList<UiBattleshipGame>();
		for (BattleshipGame game : games){
			UiBattleshipGame uiGame = new UiBattleshipGame();
			uiGame.setGameID(game.getGameID());
			Identity opp = null;
			String gameStatus = game.getStatus();
			if (game.getUser1()==identity.getIdentifier()){
				opp = IdentityUtils.getIdentityByIdentifier(game.getUser2());
				if (game.getStatus().equals("1TURN")){
					gameStatus="YOUR TURN";
				} else if (game.getStatus().equals("2TURN")){
					gameStatus="OPPONENT TURN";
				}
			} else if (game.getUser2()==identity.getIdentifier()){
				opp = IdentityUtils.getIdentityByIdentifier(game.getUser1());
				if (game.getStatus().equals("2TURN")){
					gameStatus="YOUR TURN";
				} else if (game.getStatus().equals("1TURN")){
					gameStatus="OPPONENT TURN";
				}
			}
			uiGame.setOpponent(opp.getUsername());
			uiGame.setStatus(gameStatus);
			activeGameList.add(uiGame);
		}
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("activeGameList", activeGameList);
		return mv;
	}
	
	@RequestMapping("/battleshipCreate")
	public ModelAndView getBoardCreation(
			@RequestParam(value = "gameID", required=false) Long gameID, 
			@RequestParam(value = "opponent", required=false) String opponentName){
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("battleshipBoardCreate");
		if (gameID!=null&&gameID>0){
			activeGame = BattleshipUtils.getBattleshipGameByID(gameID);
			if (!activeGame.getUser2().equals(identity.getIdentifier())){//not invited to this game
				return null;
			}
			activeOpponent = IdentityUtils.getIdentityByIdentifier(activeGame.getUser1());
		} else {
			activeOpponent = IdentityUtils.getIdentityByUsername(opponentName);
			if (activeOpponent==null){
				return null;
			}
			activeGame = new BattleshipGame();
			activeGame.setUser1(identity.getIdentifier());
			activeGame.setUser2(activeOpponent.getIdentifier());
			activeGame.setStatus("1TURN");
		}
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("opponent", activeOpponent.getUsername());
		mv.addObject("battleshipBoard", new BattleshipBoard());
		return mv;
	}
	
	@RequestMapping("/loadBattleship")
	public ModelAndView getExistingGame(
			@RequestParam(value = "gameID", required=true) Long gameID){
		if (identity==null){
			return new ModelAndView("timeout");
		}
		activeGame = BattleshipUtils.getBattleshipGameByID(gameID);
		if (activeGame==null){
			return null;
		}
		BattleshipBoard battleshipBoard = BattleshipUtils.getBattleshipBoard(gameID, identity.getIdentifier());
		ModelAndView mv;
		if (battleshipBoard==null){
			mv = new ModelAndView("battleshipBoardCreate");
			if (gameID!=null&&gameID>0){
				activeGame = BattleshipUtils.getBattleshipGameByID(gameID);
				if (!activeGame.getUser2().equals(identity.getIdentifier())){//not invited to this game
					return null;
				}
				activeOpponent = IdentityUtils.getIdentityByIdentifier(activeGame.getUser1());
			}
			mv.addObject("identifier", identity.getIdentifier());
			mv.addObject("opponent", activeOpponent.getUsername());
			mv.addObject("battleshipBoard", new BattleshipBoard());
		} else {
			mv = new ModelAndView("battleship");

			boolean myTurn=false;
			if (activeGame.getUser2().equals(identity.getIdentifier())){
				activeOpponent = IdentityUtils.getIdentityByIdentifier(activeGame.getUser1());
				if (activeGame.getStatus().equals("2TURN")){
					myTurn=true;
				}
			} else if (activeGame.getUser1().equals(identity.getIdentifier())){
				activeOpponent = IdentityUtils.getIdentityByIdentifier(activeGame.getUser2());
				if (activeGame.getStatus().equals("1TURN")){
					myTurn=true;
				}
			} else {
				return null;
			}
			List<BattleshipMove> myMoves = BattleshipUtils.getBattleshipMoves(gameID, identity.getIdentifier());
			List<BattleshipMove> oppMoves = BattleshipUtils.getBattleshipMoves(gameID, activeOpponent.getIdentifier());
			List<String> mySunkenShips=new ArrayList<String>();
			List<String> oppSunkenShips=new ArrayList<String>();
			for (BattleshipMove move : oppMoves){
				if (move.getStatus().startsWith("sunk")){
					mySunkenShips.add(move.getStatus().substring(4, move.getStatus().length()));
					move.setStatus("hit");
				} else if (move.getStatus().startsWith("hit")){
					move.setStatus("hit");
				}
			}
			for (BattleshipMove move : myMoves){
				if (move.getStatus().startsWith("sunk")){
					oppSunkenShips.add(move.getStatus().substring(4, move.getStatus().length()));
					move.setStatus("hit");
				} else if (move.getStatus().startsWith("hit")){
					move.setStatus("hit");
				}
			}
			mv.addObject("identifier", identity.getIdentifier());
			mv.addObject("gameID", activeGame.getGameID());
			mv.addObject("myTurn", myTurn);
			mv.addObject("opponent", activeOpponent.getUsername());
			mv.addObject("battleshipBoard", battleshipBoard);
			ObjectMapper objectMapper = new ObjectMapper();
			try {
				mv.addObject("myMoves", objectMapper.writeValueAsString(myMoves));
				mv.addObject("oppMoves", objectMapper.writeValueAsString(oppMoves));
				mv.addObject("mySunkenShips", objectMapper.writeValueAsString(mySunkenShips));
				mv.addObject("oppSunkenShips", objectMapper.writeValueAsString(oppSunkenShips));
			} catch (JsonProcessingException e) {
				e.printStackTrace();
				mv.addObject("myMoves", "[]");
				mv.addObject("oppMoves", "[]");
				mv.addObject("mySunkenShips", "[]");
				mv.addObject("oppSunkenShips", "[]");
			}
		}
		return mv;
	}
	
	@RequestMapping("/startBattleship")
	public ModelAndView getBattleshipGame(@ModelAttribute("battleshipBoard") BattleshipBoard battleshipBoard){
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("battleship");
		Long gameID=activeGame.getGameID();
		if (gameID==null){
			gameID=BattleshipUtils.insertBattleshipGame(activeGame);
			BattleshipUtils.updateBattleshipGameStatus(gameID, "2TURN");
		} else {
			BattleshipUtils.updateBattleshipGameStatus(gameID, "1TURN");
		}
		BattleshipUtils.insertBattleshipBoard(gameID, identity.getIdentifier(), battleshipBoard);
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("gameID", gameID);
		mv.addObject("myTurn", false);
		mv.addObject("opponent", activeOpponent.getUsername());
		mv.addObject("battleshipBoard", battleshipBoard);
		return mv;
	}
}


