package site.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
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
			identifier = IdentityUtils.insertIdentity(identity);
			identity.setIdentifier(identifier);
		} else {
			identity = IdentityUtils.getIdentityByIdentifier(identifier);
		}
		Cookie cookie = new Cookie("identifier", identifier.toString());
		cookie.setMaxAge(60*60*24*7);
        response.addCookie(cookie);
		mv.addObject("identifier", identifier);
		return mv;
	}
	
	@RequestMapping("/gamesIndex")
	public ModelAndView getGamesIndex() {
		ModelAndView mv = new ModelAndView("gamesIndex");
		mv.addObject("identifier", identity.getIdentifier());
		return mv;
	}
	 
	@RequestMapping("/topframe")
	public ModelAndView showTopFrame() {
		ModelAndView mv = new ModelAndView("topFrame");
		mv.addObject("identifier", identity.getIdentifier());
		return mv;
	}
	 
	@RequestMapping("/leftframe")
	public ModelAndView showLeftFrame() {
		ModelAndView mv = new ModelAndView("leftFrame");
		return mv;
	}
	 
	@RequestMapping("/displayframe")
	public ModelAndView showDisplayFrame() {
		ModelAndView mv = new ModelAndView("displayFrame");
		return mv;
	}
	
	
}
