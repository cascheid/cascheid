package site.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.blitzball.BlitzballGame;
import site.blitzball.BlitzballGameMarks;
import site.blitzball.BlitzballGameRoster;
import site.blitzball.BlitzballGameTechs;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballPlayer;
import site.blitzball.BlitzballPlayerStatistics;
import site.blitzball.BlitzballTeam;
import site.blitzball.BlitzballUtils;
import site.blitzball.BlitzballWeekResults;
import site.blitzball.TeamName;
import site.identity.Identity;
import site.identity.IdentityUtils;

@Controller
@Scope("session")
public class BlitzballController {
	Identity identity=null;
	BlitzballInfo blitzballInfo=null;
	//BlitzballLeague activeLeague=null;
	BlitzballTeam activeOpponent=null;
	BlitzballGame activeGame=null;
	BlitzballWeekResults weekResults = null;

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
		if (blitzballInfo!=null&&(blitzballInfo.getLeague()==null||blitzballInfo.getLeague().getWeeksComplete()>=10)){
			blitzballInfo=BlitzballUtils.getActiveLeague(blitzballInfo);
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
		mv.addObject("numPlayers", blitzballInfo.getNumberOfPlayers());
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
		if (blitzballInfo.getLeague()==null||blitzballInfo.getLeague().getWeeksComplete()>=10){
			blitzballInfo=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		activeGame = BlitzballUtils.getLeagueGame(blitzballInfo.getLeague());
		activeOpponent=BlitzballUtils.getLeagueOpponentByID(blitzballInfo.getLeague());
		ModelAndView mv;
		if (activeGame!=null&&activeGame.getHalvesComplete()>0){
			//resume active game
			mv = loadBlitzballGame();
		} else {
			//load standings
			mv = new ModelAndView("blitzballLeague");
			mv.addObject("standings", blitzballInfo.getLeague().getLeagueStandings());
			mv.addObject("oppName", activeOpponent.getTeamName());
			mv.addObject("prize", blitzballInfo.getLeague().getPrize());
		}
		return mv;
	}
	
	@RequestMapping("/blitzballLeagueSched")
	public ModelAndView getLeagueSchedule(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballLeagueSchedule");
		mv.addObject("week", blitzballInfo.getLeague().getWeeksComplete()+1);
		mv.addObject("schedule", blitzballInfo.getLeague().getSchedule());
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
		List<BlitzballPlayerStatistics> statistics = blitzballInfo.getLeague().getPlayerStatistics();
		statistics.sort(new Comparator<BlitzballPlayerStatistics>(){
			public int compare(BlitzballPlayerStatistics p1, BlitzballPlayerStatistics p2) {
				return p2.getGoals().compareTo(p1.getGoals());
			};
		
		});
		mv.addObject("oppName", activeOpponent.getTeamName());
		mv.addObject("statistics", blitzballInfo.getLeague().getPlayerStatistics());
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
	
	@RequestMapping("/bbTechDisplay")
	public ModelAndView getPlayerTechsDisplay(@RequestParam(value = "id") Integer playerID){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballTechDisplay");
		
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("techList", BlitzballUtils.getTechList());
			BlitzballPlayer player = BlitzballUtils.getBlitzballPlayer(blitzballInfo, playerID);
			player.getLearnedTechs().add(30);
			player.getLearnedTechs().add(54);
			player.getLearnedTechs().add(57);
			mv.addObject("currPlayer", BlitzballUtils.getBlitzballPlayer(blitzballInfo, playerID));
			mv.addObject("techListJSON", objectMapper.writeValueAsString(BlitzballUtils.getTechList()));
			//mv.addObject("currPlayer", objectMapper.writeValueAsString(BlitzballUtils.getBlitzballPlayer(blitzballInfo, playerID)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;	
	}
	
	//public ModelAndView startLeagueGame(@RequestParam(value = "opponent") Long oppID){
	@RequestMapping("/blitzballStartGame")
	public ModelAndView loadBlitzballGame(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballStart");
		//in loading league activeOpponent=BlitzballUtils.getLeagueOpponentByID(activeLeague);
		mv.addObject("myTeam", blitzballInfo.getTeam());/*
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		mv.addObject("blitzballGameRoster", new BlitzballGameRoster());
		return mv;
	}
	
	@RequestMapping("/blitzballGame")
	public ModelAndView playBlitzballGame() {
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
		//TODO link to actual game
		//ModelAndView mv = new ModelAndView("test");
		if (activeGame.getHalvesComplete()==1){
			BlitzballUtils.simulateGame(activeGame);
			activeGame.setHalvesComplete(2);
		} else {
			BlitzballUtils.simulateGame(activeGame);
			activeGame.setHalvesComplete(1);
		};
		/*ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("myTeam", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeam", objectMapper.writeValueAsString(activeOpponent));
			mv.addObject("blitzballGameMarks", blitzballGameMarks);
			mv.addObject("blitzballGameInfo", activeGame);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;*/
		return submitHalfResults(0l, activeGame);
	}
	
	@RequestMapping("/blitzballIntermission")
	public ModelAndView submitHalfResults(@CookieValue(value = "identifier", defaultValue = "0") Long identifier, 
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
					blitzballInfo=BlitzballUtils.getActiveLeague(blitzballInfo);
					activeOpponent = BlitzballUtils.getLeagueOpponentByID(blitzballInfo.getLeague());
				}
			}
		}
		//activeGame = blitzballGameInfo;
		boolean teamLevelUp = BlitzballUtils.persistBlitzballGame(activeGame, blitzballInfo);
		ModelAndView mv;
		if (activeGame.getHalvesComplete()>=2&&(!activeGame.getIsOvertimeGame()||activeGame.getTeam1Score()!=activeGame.getTeam2Score())){
			weekResults = BlitzballUtils.simulateWeeksGames(blitzballInfo, activeGame);
			weekResults.setTeamLevelUp(teamLevelUp);
			if (activeGame.getLeagueGameID()!=null&&activeGame.getTourneyGameID()==null){
				weekResults.setType("league");
				if (weekResults.getWeekNo()==10){
					BlitzballUtils.handleLeagueComplete(blitzballInfo, weekResults);
				}
			} else if (activeGame.getTourneyGameID()!=null&&activeGame.getLeagueGameID()==null){
				weekResults.setType("tourney");
				if (weekResults.getWeekNo()==3){
					//TODO complete tournament
				}
			} else {
				throw new IllegalStateException("Couldn't determine game type for week results");
			}
			
		} else {//halftime or overtime
			activeGame=blitzballGameInfo;
			weekResults=null;
		}
		
		mv = new ModelAndView("blitzballGameResult");
		
		ObjectMapper objectMapper = new ObjectMapper();
		mv.addObject("myTeam", blitzballInfo.getTeam());
		mv.addObject("oppTeam", activeOpponent);
		mv.addObject("blitzballGameInfo", blitzballGameInfo);
		try {
			mv.addObject("expMap", objectMapper.writeValueAsString(BlitzballUtils.getExpLevelMap()));
			mv.addObject("myTeamJSON", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeamJSON", objectMapper.writeValueAsString(activeOpponent));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/bbProcessHalf")
	public ModelAndView processHalftimeNextPage(){
		if (identity==null||blitzballInfo==null||activeGame==null){
			return new ModelAndView("timeout");
		}
		if (activeGame.getHalvesComplete()>=2&&(!activeGame.getIsOvertimeGame()||activeGame.getTeam1Score()!=activeGame.getTeam2Score())){
			return getWeekResults();
		} else {
			return loadBlitzballGame();
		}
	}

	private ModelAndView getWeekResults(){
		if (identity==null||blitzballInfo==null||weekResults==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv;
		if (weekResults.getType().equals("league")){
			mv = new ModelAndView("bbLeagueWeekResults");
		} else if (weekResults.getType().equals("tourney")){
			mv = new ModelAndView("bbTourneyWeekResults");
		} else {
			throw new IllegalStateException("Invalid weekResults type");
		}
		mv.addObject("weekResults", weekResults);
		if (weekResults.getLeagueResult()!=null){
			mv.addObject("leagueResult", weekResults.getLeagueResult());
		}
		return mv;
	}
	
	@RequestMapping("/bbSignPlayer")
	@ResponseBody
	public void signPlayer(@RequestParam(value = "playerID") Integer playerID,
			@RequestParam(value = "contractLength") Integer contractLength){
		if (identity==null||blitzballInfo==null){
			//TODO show error somehow return new ModelAndView("timeout");
		}
		String position = "BENCH2";
		if (blitzballInfo.getTeam().getLeftWing()==null){
			position="LW";
		} else if (blitzballInfo.getTeam().getRightWing()==null){
			position="RW";
		} else if (blitzballInfo.getTeam().getMidfielder()==null){
			position="MF";
		} else if (blitzballInfo.getTeam().getLeftBack()==null){
			position="LB";
		} else if (blitzballInfo.getTeam().getRightBack()==null){
			position="RB";
		} else if (blitzballInfo.getTeam().getKeeper()==null){
			position="BK";
		} else if (blitzballInfo.getTeam().getBench1()==null){
			position="BENCH1";
		}
		BlitzballUtils.signPlayer(blitzballInfo, playerID, position, contractLength);
	}

	@RequestMapping("/bbTestExpiringContracts")
	public ModelAndView testExpiringContractsPage(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballExpiringContracts");
		List<BlitzballPlayer> expiringPlayers = new ArrayList<BlitzballPlayer>();
		expiringPlayers.add(BlitzballUtils.getBlitzballPlayer(blitzballInfo, 25));
		expiringPlayers.add(BlitzballUtils.getBlitzballPlayer(blitzballInfo, 10));
		List<BlitzballPlayer> renewedPlayers = new ArrayList<BlitzballPlayer>();
		renewedPlayers.add(BlitzballUtils.getBlitzballPlayer(blitzballInfo, 25));
		renewedPlayers.add(BlitzballUtils.getBlitzballPlayer(blitzballInfo, 55));
		List<BlitzballPlayer> myExpiredPlayers = new ArrayList<BlitzballPlayer>();
		myExpiredPlayers.add(blitzballInfo.getTeam().getLeftWing());
		myExpiredPlayers.add(blitzballInfo.getTeam().getKeeper());

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			mv.addObject("expiringPlayers", objectMapper.writeValueAsString(expiringPlayers));
			mv.addObject("renewedPlayers", objectMapper.writeValueAsString(renewedPlayers));
			mv.addObject("myExpiredPlayers", objectMapper.writeValueAsString(myExpiredPlayers));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/bbTestGameResults")
	public ModelAndView testGameResults(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		if (activeOpponent==null){
			activeOpponent = BlitzballUtils.getLeagueOpponentByID(blitzballInfo.getLeague());
		}
		BlitzballGame game = BlitzballUtils.simulateGame(BlitzballUtils.getLeagueGame(blitzballInfo.getLeague()));
		BlitzballUtils.persistBlitzballGame(game, blitzballInfo);
		ModelAndView mv;
		
		mv = new ModelAndView("blitzballGameResult");
		
		ObjectMapper objectMapper = new ObjectMapper();
		mv.addObject("myTeam", blitzballInfo.getTeam());
		mv.addObject("oppTeam", activeOpponent);
		mv.addObject("blitzballGameInfo", game);
		blitzballInfo.getTeam().getRightWing().setUpdatedStats(Arrays.asList("sht", "hp", "end"));
		for (BlitzballPlayerStatistics stats : game.getPlayerStatistics()){
			if (stats.getPlayerID().equals(blitzballInfo.getTeam().getMidfielder().getPlayerID())){
				stats.getTechsLearned().add(blitzballInfo.getTeam().getLeftBack().getTech1());
			} else if (stats.getPlayerID().equals(blitzballInfo.getTeam().getRightWing().getPlayerID())){
				stats.getTechsLearned().add(blitzballInfo.getTeam().getRightWing().getKeyTech1());
				stats.getTechsLearned().add(blitzballInfo.getTeam().getMidfielder().getTech1());
			}
		}
		try {
			mv.addObject("expMap", objectMapper.writeValueAsString(BlitzballUtils.getExpLevelMap()));
			mv.addObject("myTeamJSON", objectMapper.writeValueAsString(blitzballInfo.getTeam()));
			mv.addObject("oppTeamJSON", objectMapper.writeValueAsString(activeOpponent));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/bbTestPage")
	public ModelAndView getTestMenuBackground(@CookieValue(value = "identifier", defaultValue = "0") Long identifier){
		ModelAndView mv;
		if (identifier==0){//no cookie
			mv = new ModelAndView("pleaseLogin");
			mv.addObject("action","play Blitzball");
			return mv;
		} else {
			mv = new ModelAndView("blitzballTestBackground");
			mv.addObject("testPage", "bbTestGameResults");
		}
		if (identity==null||identity.getIdentifier()!=identifier){
			identity=IdentityUtils.getIdentityByIdentifier(identifier);
			blitzballInfo=BlitzballUtils.getBlitsballInfo(identifier);
			//activeLeague=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		if (blitzballInfo!=null&&(blitzballInfo.getLeague()==null||blitzballInfo.getLeague().getWeeksComplete()>=10)){
			blitzballInfo=BlitzballUtils.getActiveLeague(blitzballInfo);
		}
		return mv;
	}
	
	@RequestMapping("/resetBlitzballGame")
	public String resetBlitzballGame(@CookieValue(value = "identifier", defaultValue = "0") Long identifier){
		if (identifier==0){//no cookie, main page can handle it
			return "redirect:blitzball";
		}
		if (identity==null||identity.getIdentifier()!=identifier){
			identity=IdentityUtils.getIdentityByIdentifier(identifier);
			blitzballInfo=BlitzballUtils.getBlitsballInfo(identifier);
		}
		BlitzballUtils.resetBlitzballInfo(blitzballInfo.getTeam().getTeamID());
		blitzballInfo=null;
		activeOpponent=null;
		activeGame=null;
		weekResults = null;
		return "redirect:blitzball";
	}
	
	@RequestMapping("/bbRecruit")
	public ModelAndView getRecruitingPage(){
		if (identity==null||blitzballInfo==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("blitzballRecruit");
		mv.addObject("myTeam", blitzballInfo.getTeam());
		mv.addObject("allPlayers", BlitzballUtils.getAllPlayers(blitzballInfo.getTeam().getTeamID()));
		List<Long> teamIDs = new ArrayList<Long>();
		teamIDs.add(0l);
		for (BlitzballTeam team : blitzballInfo.getOpponents()){
			teamIDs.add(team.getTeamID());
		}
		mv.addObject("teamIDs", teamIDs);
		return mv;
		
	}
}
