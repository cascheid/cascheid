package site.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.blitzball.BlitzballGameRoster;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballLeague;
import site.blitzball.BlitzballTeam;
import site.blitzball.BlitzballUtils;
import site.blitzball.TeamName;
import site.identity.Identity;
import site.identity.IdentityUtils;

@Controller
@Scope("session")
public class BlitzballController {
	Identity identity=null;
	BlitzballInfo blitzballInfo=null;
	BlitzballLeague activeLeague=null;
	BlitzballTeam activeOpponent=null;

	@RequestMapping("/blitzball")
	public ModelAndView getBlizballMenuBackground(@CookieValue(value = "identifier", defaultValue = "0") Long identifier){
		ModelAndView mv;
		if (identifier==0){//no cookie
			mv = new ModelAndView("pleaseLogin");
			mv.addObject("action","play Blitzball");
			return mv;
		} else {
			mv = new ModelAndView("blitzballMenuBackground");
		}
		if (identity==null||identity.getIdentifier()!=identifier){
			identity=IdentityUtils.getIdentityByIdentifier(identifier);
			blitzballInfo=BlitzballUtils.getBlitsballInfo(identifier);
			activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		if (activeLeague==null||activeLeague.getWeeksComplete()>=10){
			activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		return mv;
	}
	
	@RequestMapping("/blitzballMenu")
	public ModelAndView getBlizballMenu(){
		ModelAndView mv;
		if (identity==null){
			return new ModelAndView("timeout");
		} else if (blitzballInfo==null){
			mv = new ModelAndView("blitzballCreate");
			mv.addObject("teamName", new TeamName());
			return mv;
		}
		mv = new ModelAndView("blitzballMenu");
		mv.addObject("username", identity.getUsername());
		//mv.addObject("teamName", blitzballInfo.getTeam().getTeamName());
		return mv;
	}
	
	@RequestMapping("/createBlitzball")
	public ModelAndView createNewTeam(@ModelAttribute("teamName") TeamName teamName){
		ModelAndView mv;
		if (identity==null){
			return new ModelAndView("timeout");
		}
		String sError=teamName.checkValid();
		if (sError==null){
			blitzballInfo = BlitzballUtils.getNewBlitzballGameInfo(identity.getIdentifier(), teamName.getFullTeamName());
			mv = new ModelAndView("blitzballMenu");
		} else {
			mv = new ModelAndView("blitzballCreate");
			mv.addObject("teamName", new TeamName());
			mv.addObject("sError", sError);
		}
		return mv;
	}

	@RequestMapping("/blitzballLeague")
	public ModelAndView getLeagueStandings(){
		if (identity==null||blitzballInfo==null){
			//TODO return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballLeague");
		if (activeLeague==null||activeLeague.getWeeksComplete()>=10){
			activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		mv.addObject("league", activeLeague);
		return mv;
	}
	
	@RequestMapping("/blitzballLeagueSched")
	public ModelAndView getLeagueSchedule(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballSchedule");
		mv.addObject("week", activeLeague.getWeeksComplete()+1);
		//mv.addObject("schedule", BlitzballUtils.getLeagueSchedule(activeLeague.getLeagueID()));
		return mv;
	}
	
	@RequestMapping("/blitzballLeagueStats")
	public ModelAndView getLeagueStatistics(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballStats");
		//TODO implement
		return mv;
	}
	
	//public ModelAndView startLeagueGame(@RequestParam(value = "opponent") Long oppID){
	@RequestMapping("/blitzballLeagueGame")
	public ModelAndView startLeagueGame(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballStart");
		activeOpponent=BlitzballUtils.getLeagueOpponentByID(activeLeague);

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("blitzballGameRoster", new BlitzballGameRoster());
		return mv;
	}
	
	@RequestMapping("/blitzballStart")
	public ModelAndView loadGame(@ModelAttribute("blitzballTeam") BlitzballTeam blitzballTeam){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzball");
		mv.addObject("myTeam", blitzballInfo.getTeam());
		mv.addObject("oppTeam", activeOpponent);
		return mv;
	}
	
	@RequestMapping("/setBBGameTechs")
	public ModelAndView loadGameTechScreen(@ModelAttribute("blitzballGameRoster") BlitzballGameRoster blitzballGameRoster){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballGameTechs");
		
		blitzballInfo.setTeam(BlitzballUtils.getGameStartingTeam(blitzballInfo.getTeam(), blitzballGameRoster));

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
}
