package site.controller;

import java.util.Comparator;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.blitzball.BlitzballGame;
import site.blitzball.BlitzballGameMarks;
import site.blitzball.BlitzballGameRoster;
import site.blitzball.BlitzballGameTechs;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballLeague;
import site.blitzball.BlitzballPlayerStatistics;
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
	BlitzballGame activeGame=null;

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
			//activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		if (blitzballInfo!=null&&(activeLeague==null||activeLeague.getWeeksComplete()>=10)){
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
			return new ModelAndView("timeout");
		}
		if (activeLeague==null||activeLeague.getWeeksComplete()>=10){
			activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		activeGame = BlitzballUtils.getLeagueGame(activeLeague);
		activeOpponent=BlitzballUtils.getLeagueOpponentByID(activeLeague);
		ModelAndView mv;
		if (activeGame!=null&&activeGame.getHalvesComplete()>0){
			//resume active game
			mv = new ModelAndView("blitzball");
			mv.addObject("myTeam", blitzballInfo.getTeam());
			mv.addObject("oppTeam", activeOpponent);
		} else {
			//load standings
			mv = new ModelAndView("blitzballLeague");
			mv.addObject("standings", activeLeague.getLeagueStandings());
			mv.addObject("oppName", activeOpponent.getTeamName());
		}
		return mv;
	}
	
	@RequestMapping("/blitzballLeagueSched")
	public ModelAndView getLeagueSchedule(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballLeagueSchedule");
		mv.addObject("week", activeLeague.getWeeksComplete()+1);
		mv.addObject("schedule", activeLeague.getSchedule());
		mv.addObject("oppName", activeOpponent.getTeamName());
		return mv;
	}
	
	@RequestMapping("/blitzballLeagueStats")
	public ModelAndView getLeagueStatistics(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballLeagueStatistics");

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("techList", objectMapper.writeValueAsString(BlitzballUtils.getTechList()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<BlitzballPlayerStatistics> statistics = activeLeague.getPlayerStatistics();
		statistics.sort(new Comparator<BlitzballPlayerStatistics>(){
			public int compare(BlitzballPlayerStatistics p1, BlitzballPlayerStatistics p2) {
				return p2.getGoals().compareTo(p1.getGoals());
			};
		
		});
		mv.addObject("oppName", activeOpponent.getTeamName());
		mv.addObject("statistics", activeLeague.getPlayerStatistics());
		return mv;
	}
	
	@RequestMapping("/bbStatDisplay")
	public ModelAndView getPlayerStatisticsDisplay(@RequestParam(value = "id") Integer playerID){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballStatDisplay");
		
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("player", objectMapper.writeValueAsString(BlitzballUtils.getBlitzballPlayer(blitzballInfo, playerID)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
		
	}
	
	//public ModelAndView startLeagueGame(@RequestParam(value = "opponent") Long oppID){
	@RequestMapping("/blitzballLeagueGame")
	public ModelAndView startLeagueGame(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballStart");
		//in loading league activeOpponent=BlitzballUtils.getLeagueOpponentByID(activeLeague);

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
	
	@RequestMapping("/blitzballGame")
	public ModelAndView getBlitzballGame() {
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("test");
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
			mv.addObject("blitzballGameInfo", new BlitzballGame(blitzballInfo.getTeam(), activeOpponent));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/setBBGameRoster")
	public ModelAndView loadGameTechScreen(@ModelAttribute("blitzballGameRoster") BlitzballGameRoster blitzballGameRoster){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballGameTechs");
		
		blitzballInfo.setTeam(BlitzballUtils.getUpdatedRoster(blitzballInfo.getTeam(), blitzballGameRoster));

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("techList", objectMapper.writeValueAsString(BlitzballUtils.getTechList()));
			mv.addObject("blitzballGameTechs", new BlitzballGameTechs());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/setBBGameTechs")
	public ModelAndView loadGameMarkScreen(@ModelAttribute("blitzballGameTechs") BlitzballGameTechs blitzballGameTechs){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballGameMarks");
		
		blitzballInfo.setTeam(BlitzballUtils.getUpdatedTeamTechs(blitzballInfo.getTeam(), blitzballGameTechs));

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
			mv.addObject("techList", objectMapper.writeValueAsString(BlitzballUtils.getTechList()));
			mv.addObject("blitzballGameMarks", new BlitzballGameMarks());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/setBBGameMarks")
	public ModelAndView loadGameReady(@ModelAttribute("blitzballGameMarks") BlitzballGameMarks blitzballGameMarks){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballGameStart");

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			if (activeGame==null){
				mv.addObject("halftime", 1);
				activeGame = new BlitzballGame(blitzballInfo.getTeam(), activeOpponent);
			} else {
				mv.addObject("halftime", 2);
			}
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
			mv.addObject("blitzballGameMarks", blitzballGameMarks);
			mv.addObject("blitzballGameInfo", activeGame);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/blitzballIntermission")
	public ModelAndView submitHalftime(@CookieValue(value = "identifier", defaultValue = "0") Long identifier, 
			@ModelAttribute("blitzballGameInfo") BlitzballGame blitzballGameInfo){
		if (identity==null||blitzballInfo==null){
			if (identifier==0){//no cookie
				ModelAndView mv = new ModelAndView("pleaseLogin");
				mv.addObject("action","play Blitzball");
				return mv;
			} else {
				identity=IdentityUtils.getIdentityByIdentifier(identifier);
				blitzballInfo=BlitzballUtils.getBlitsballInfo(identifier);
				if (blitzballGameInfo.getLeagueGameID()!=null){
					activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
					activeOpponent = BlitzballUtils.getLeagueOpponentByID(activeLeague);
				}
			}
		}
		ModelAndView mv = new ModelAndView("test");
		activeGame=blitzballGameInfo;
		BlitzballUtils.persistBlitzballGame(activeGame);
		if (activeGame.getHalvesComplete()>=2){
			if (activeGame.getLeagueGameID()!=null){
				//league game, increment
			} else if (activeGame.getTourneyGameID()!=null){//TODO tournament implementation
				if (activeGame.getTeam1Score()==activeGame.getTeam2Score()){
					//tied, go to overtime
				} else if (activeGame.getTeam1Score()>activeGame.getTeam2Score()){
					//advance team 1
				} else {
					//advance team 2
				}
			}
		}

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
			mv.addObject("blitzballGameInfo", blitzballGameInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/bbGameResult")
	public ModelAndView submitGameResult(@CookieValue(value = "identifier", defaultValue = "0") Long identifier, 
			@ModelAttribute("blitzballGameInfo") BlitzballGame blitzballGameInfo){
		if (identity==null||blitzballInfo==null){
			if (identifier==0){//no cookie
				ModelAndView mv = new ModelAndView("pleaseLogin");
				mv.addObject("action","play Blitzball");
				return mv;
			} else {
				identity=IdentityUtils.getIdentityByIdentifier(identifier);
				blitzballInfo=BlitzballUtils.getBlitsballInfo(identifier);
			}
			if (blitzballInfo!=null&&(activeLeague==null||activeLeague.getWeeksComplete()>=10)){
				activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
			}
		}
		ModelAndView mv = new ModelAndView("blitzballGameStart");
		activeGame=null;
		
		//TODO blitzballutils to save stats/result, contract extension screen
		return mv;
	}
	
	
	
}
