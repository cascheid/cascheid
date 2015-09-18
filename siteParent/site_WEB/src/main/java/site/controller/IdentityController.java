package site.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import site.identity.Identity;
import site.identity.IdentityUtils;

@Controller
@Scope("session")
public class IdentityController {
	Identity identity=null;
	
	@RequestMapping(value={"/", "/index"})
	public ModelAndView getIndex( @CookieValue(value = "identifier", defaultValue = "0") Long identifier,
            HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("index");
		if (identifier==0){
			identity = new Identity();
		} else {
			identity = IdentityUtils.getIdentityByIdentifier(identifier);
			Cookie cookie = new Cookie("identifier", identifier.toString());
			cookie.setMaxAge(60*60*24*7);
	        response.addCookie(cookie);
		}
		//mv.addObject("identifier", identifier);
		return mv;
	}
	
	@RequestMapping("/about")
	public ModelAndView getAboutPage() {
		ModelAndView mv = new ModelAndView("about");
		return mv;
	}
	
	@RequestMapping("/gamesIndex")
	public ModelAndView getGamesIndex(@CookieValue(value = "identifier", defaultValue = "0") Long identifier,
			@RequestParam(value = "sError", required=false) String sError){
		ModelAndView mv = new ModelAndView("gamesIndex");
		if (identity==null){
			identity=IdentityUtils.getIdentityByIdentifier(identifier);
		}
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("username", identity.getUsername());
		mv.addObject("sError", sError);
		return mv;
	}
	 
	/*@RequestMapping("/topframe")
	public ModelAndView showTopFrame() {
		ModelAndView mv = new ModelAndView("topFrame");
		mv.addObject("identifier", identity.getIdentifier());
		return mv;
	}*/
	 
	@RequestMapping("/leftframe")
	public ModelAndView showLeftFrame() {
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("leftFrame");
		mv.addObject("identifier", identity.getIdentifier()==null?0l:identity.getIdentifier());
		return mv;
	}
	 
	@RequestMapping("/displayframe")
	public ModelAndView showDisplayFrame() {
		ModelAndView mv = new ModelAndView("displayFrame");
		return mv;
	}
	
	@RequestMapping("/snakeFrame")
	public ModelAndView showSnakeFrame() {
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("snakeFrame");
		mv.addObject("highScore", identity.getSnakeScore()==null?0:identity.getSnakeScore());
		return mv;
	}
	
	@RequestMapping("/snakeResult")
	public ModelAndView showSnakeResult(
			@RequestParam(value = "score", required = true, defaultValue="0") Integer score) {
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("snakeResult");
		mv.addObject("lastHighScore", identity.getSnakeScore());
		mv.addObject("score", score);
		if (identity.getSnakeScore()==null||score>identity.getSnakeScore()){
			identity.setSnakeScore(score);
			IdentityUtils.updateSnakeScore(identity.getIdentifier(), score);
		}
		return mv;
	}
	
	@RequestMapping(value = "/updateUser")
	public ModelAndView updateUserName(@RequestParam(value = "name") String userName,
			@RequestParam(value = "type") String type,
			HttpServletResponse response) {
		if (identity==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("newUserRedirect");
		String sError=null;
		if (type.equals("create")){
			boolean bExists=IdentityUtils.checkExistingUsername(userName);
			if (bExists){
				sError="Username already exists.";
			} else {
				identity.setUsername(userName);
				Long newIdentifier=IdentityUtils.insertIdentity(identity);
				identity.setIdentifier(newIdentifier);
				Cookie cookie = new Cookie("identifier", newIdentifier.toString());
				cookie.setMaxAge(60*60*24*7);
		        response.addCookie(cookie);
		        type="done";
				//identity = IdentityUtils.getIdentityByUsername(userName);
			}
		} else if ("load".equals(type)){
			Identity newIdentity = IdentityUtils.getIdentityByUsername(userName);
			if (newIdentity==null){
				sError="Username does not exist.";
			} else {
				identity = newIdentity;
				Cookie cookie = new Cookie("identifier", identity.getIdentifier().toString());
				cookie.setMaxAge(60*60*24*7);
		        response.addCookie(cookie);
			}
		} else if ("change".equals(type)){
			boolean bExists=IdentityUtils.checkExistingUsername(userName);
			if (bExists){
				sError="Username already exists.";
			} else {
				identity.setUsername(userName);
				IdentityUtils.updateUsername(identity.getIdentifier(), userName);
			}
		}
		mv.addObject("identifier", identity.getIdentifier());
		mv.addObject("type", type);
		//mv.addObject("username", identity.getUsername());
		mv.addObject("sError", sError);
		return mv;
	}
	
	
}
