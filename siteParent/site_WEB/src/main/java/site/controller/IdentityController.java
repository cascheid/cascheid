package site.controller;

import java.util.Collections;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import site.identity.Identity;
import site.identity.IdentityUtils;
import site.identity.IdentityView;
import site.racinggame.RacingGameUtils;
import site.view.ResultMessage;

@Controller
public class IdentityController {
	@Autowired 
	private Identity identity;
	
	@RequestMapping(value="/test")
	public ModelAndView getTestPage(){
		return new ModelAndView("test");
	}
	
	@RequestMapping(value="/test2")
	public ModelAndView getTestPage2(){
		return new ModelAndView("test2");
	}
	
	@RequestMapping(value="/test3")
	public ModelAndView getTestPage3(){
		return new ModelAndView("test3");
	}
	
	@RequestMapping(value="/getIdentity", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> getIdentity(){
		return new ResponseEntity<>(identity.getIdentityView(), HttpStatus.OK);
	}
	

	@RequestMapping(value="/loadUser", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> loadUser(@RequestParam String username, @RequestParam(required=false) String password, HttpServletResponse response){
		Identity newIdentity = IdentityUtils.getIdentityByUsername(username);
		if (newIdentity==null){
			ResultMessage result = new ResultMessage();
			result.setError(true);
			result.setResultMessage("Username does not exist.");
			return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
		} else {
			identity.updateIdentity(newIdentity);
			return new ResponseEntity<>(identity.getIdentityView(), HttpStatus.OK);
		}
	}
	
	@RequestMapping(value="createUser", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> createUser(@RequestParam String username, HttpServletResponse response){
		boolean bExists=IdentityUtils.checkExistingUsername(username);
		if (bExists){
			ResultMessage result = new ResultMessage();
			result.setError(true);
			result.setResultMessage("Username already exists.");
			return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
		} else {
			identity.setUsername(username);
			Long newIdentifier=IdentityUtils.insertIdentity(identity);
			identity.setIdentifier(newIdentifier);
			if (identity.getRacingGame()!=null){
				RacingGameUtils.insertRacingGameInfo(identity.getRacingGame(), newIdentifier);
			}
			Cookie cookie = new Cookie("identifier", newIdentifier.toString());
			cookie.setMaxAge(60*60*24*7);
	        response.addCookie(cookie);
			return new ResponseEntity<>(identity.getIdentityView(), HttpStatus.OK);
		}
	}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> logout(HttpSession session){
		session.invalidate();
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	
	@RequestMapping(value={"/", "/index"})
	public ModelAndView getIndex() {
		ModelAndView mv = new ModelAndView("index");
		return mv;
	}
	
	@RequestMapping("/testwater")
	public ModelAndView getTestWaterPage() {
		ModelAndView mv = new ModelAndView("testwater");
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
	
	@RequestMapping(value="/snakeResult", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> showSnakeResult(@RequestBody IdentityView scoreObj) {
		if (identity.getSnakeScore()==null||scoreObj.getSnakeScore()>identity.getSnakeScore()){
			identity.setSnakeScore(scoreObj.getSnakeScore());
			IdentityUtils.updateSnakeScore(identity.getIdentifier(), scoreObj.getSnakeScore());
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping(value = "/testFire")
	public ModelAndView getFireTestPage(){
		return new ModelAndView("fire-test/main");
	}
	
	
}
