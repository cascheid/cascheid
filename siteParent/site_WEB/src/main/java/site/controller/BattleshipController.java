package site.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import site.battleship.BattleshipBoard;
import site.identity.Identity;
import site.identity.IdentityUtils;

@Controller
@Scope("session")
public class BattleshipController {
	Identity identity=null;
	
	@RequestMapping("/battleship")
	public ModelAndView getBattleshipIndex(@CookieValue(value = "identifier", defaultValue = "0") Long identifier){
		ModelAndView mv = new ModelAndView("battleshipBoardCreate");
		if (identity==null){
			identity=IdentityUtils.getIdentityByIdentifier(identifier);
		}
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("opponent", "Das");
		mv.addObject("battleshipBoard", new BattleshipBoard());
		return mv;
	}
	
	@RequestMapping("/startBattleship")
	public ModelAndView getBattleshipGame(@ModelAttribute("battleshipBoard") BattleshipBoard battleshipBoard){
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("battleship");
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("opponent", "Das");
		mv.addObject("battleshipBoard", battleshipBoard);
		return mv;
	}
}


