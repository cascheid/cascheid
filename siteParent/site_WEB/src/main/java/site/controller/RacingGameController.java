package site.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import site.identity.Identity;
import site.identity.IdentityUtils;
import site.racinggame.RaceInfo;
import site.racinggame.RaceResult;
import site.racinggame.Racecar;
import site.racinggame.RacingGameUtils;
import site.racinggame.Upgrade;
import site.racinggame.UserRacecar;
import site.view.ResultMessage;

@Controller
public class RacingGameController {
	@Autowired
	Identity identity;
	
	@RequestMapping(value="/getRacingGame", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> getRacingGame(){
		if (identity.getRacingGame()==null){
			identity.setRacingGame(RacingGameUtils.getRacingGameObject(identity.getRacingGameIdentifier(), identity.getIdentifier()));
			identity.getRacingGame().setPurchaseableCars(RacingGameUtils.getAllAvailableCarsToPurchase(identity.getRacingGame()));
		}
		
		return new ResponseEntity<>(identity.getRacingGame(), HttpStatus.OK);
	}
	
	@RequestMapping("/purchaseCar")
	@ResponseBody
	public ResponseEntity<?> purchaseCar(@RequestParam(value = "carID", required = true) Integer carID){
		Racecar raceCar = RacingGameUtils.getRacecarByID(carID);
		if (identity.getRacingGame().getAvailableCash().compareTo(raceCar.getPrice())<0){
			ResultMessage result = new ResultMessage();
			result.setError(true);
			result.setResultMessage("Not Enough Money");
			return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
		}
		RacingGameUtils.purchaseCar(identity.getRacingGame(), raceCar);
		return new ResponseEntity<>(identity.getRacingGame(), HttpStatus.OK);
	}
	
	@RequestMapping(value="getUpgrades", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> getUpgrades(@RequestParam String racingClass){
		List<Upgrade> upgradeOptions = RacingGameUtils.getUpgradesByClass(racingClass);
		for (Upgrade existing : identity.getRacingGame().getSelectedCar().getUpgradeList()){
			for (Upgrade option : upgradeOptions){
				if (existing.getUpgradeID()==option.getUpgradeID()){
					option.setPrice(option.getPrice().add(existing.getPrice()));
				}
			}
		}
		return new ResponseEntity<>(upgradeOptions, HttpStatus.OK);
	}
	
	@RequestMapping(value="purchaseUpgrade", method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> purchaseUpgrade(@RequestParam Integer upgradeID){
		Upgrade upgrade = RacingGameUtils.getUpgradeByID(upgradeID);
		BigDecimal price = upgrade.getPrice();
		for (Upgrade existing : identity.getRacingGame().getSelectedCar().getUpgradeList()){
			if (existing.getUpgradeID()==upgradeID){
				price.add(upgrade.getPrice());
			}
		}
		if (identity.getRacingGame().getAvailableCash().compareTo(price)<0){
			ResultMessage result = new ResultMessage();
			result.setError(true);
			result.setResultMessage("Not Enough Money");
			return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
		}
		identity.getRacingGame().setAvailableCash(identity.getRacingGame().getAvailableCash().subtract(price));
		identity.getRacingGame().getSelectedCar().addUpgrade(upgrade);
		if (identity.getRacingGame().getRacingIdentifier()!=null&&identity.getRacingGame().getRacingIdentifier()>0){
			RacingGameUtils.addNewUpgrade(identity.getRacingGame().getSelectedCar(), upgrade);
			//TODO save cash
		}
		return new ResponseEntity<>(identity.getRacingGame().getSelectedCar(), HttpStatus.OK);
	}
	
	@RequestMapping("/startRace")
	@ResponseBody
	public ResponseEntity<?> openUserRaceFrame(@RequestParam String racingClass, @RequestParam String raceType, @RequestParam Integer carID){
		identity.getRacingGame().setSelectedClass(racingClass);
		if (carID!=identity.getRacingGame().getSelectedCar().getCarID()){
			for (UserRacecar car : identity.getRacingGame().getCarList()){
				if (car.getCarID()==carID){
					identity.getRacingGame().setSelectedCar(car);
					break;
				}
			}
		}
		RaceInfo raceInfo = new RaceInfo();
		raceInfo.setRaceType(raceType);
		raceInfo.setRacingClass(racingClass);
		Set<Racecar> opponents;
		if (raceType.equals("user")){
			identity.getRacingGame().setSelectedMode("user");
			LinkedHashMap<String, Integer> feeMap = RacingGameUtils.getFeeMap();
			identity.getRacingGame().setAvailableCash(identity.getRacingGame().getAvailableCash().subtract(new BigDecimal(feeMap.get(racingClass))));
			opponents = new HashSet<Racecar>(RacingGameUtils.getRandomOpponentsByClass(racingClass));
			raceInfo.setRacer1(identity.getRacingGame().getSelectedCar());
		} else {
			identity.getRacingGame().setSelectedMode("spectate");
			opponents = new HashSet<Racecar>(RacingGameUtils.getSpectateCarsByCarID(carID));
		}
		raceInfo.setLapDistance(RacingGameUtils.getLapDistanceByClass(racingClass));
		raceInfo.setNoLaps(RacingGameUtils.getNumberOfLapsByClass(racingClass));
		for (Racecar car : opponents){
			raceInfo.addRacer(car);
		}
		return new ResponseEntity<>(raceInfo, HttpStatus.OK);
	}
	
	@RequestMapping("/racingResults")
	@ResponseBody
	public ResponseEntity<?> racingResults(@RequestBody RaceResult raceResult){
		if ("user".equals(raceResult.getFirstPlace())){
			raceResult.setFirstPlace(IdentityUtils.getDisplayedUser(identity));
			raceResult.setUserFinish(1);
			if (raceResult.getRacingClass().equals(identity.getRacingGame().getRacingClass())&&!"SS".equals(identity.getRacingGame().getRacingClass())){
				if ("E".equals(identity.getRacingGame().getRacingClass())){
					identity.getRacingGame().setRacingClass("D");
					identity.getRacingGame().setSelectedClass("D");
				} else if ("D".equals(identity.getRacingGame().getRacingClass())){
					identity.getRacingGame().setRacingClass("C");
					identity.getRacingGame().setSelectedClass("C");
				} else if ("C".equals(identity.getRacingGame().getRacingClass())){
					identity.getRacingGame().setRacingClass("B");
					identity.getRacingGame().setSelectedClass("B");
				}  else if ("B".equals(identity.getRacingGame().getRacingClass())){
					identity.getRacingGame().setRacingClass("A");
					identity.getRacingGame().setSelectedClass("A");
				}  else if ("A".equals(identity.getRacingGame().getRacingClass())){
					identity.getRacingGame().setRacingClass("S");
					identity.getRacingGame().setSelectedClass("S");
				}  else if ("S".equals(identity.getRacingGame().getRacingClass())){
					identity.getRacingGame().setRacingClass("SS");
				}
				raceResult.setNewClass(identity.getRacingGame().getRacingClass());
				identity.getRacingGame().setPurchaseableCars(RacingGameUtils.getAllAvailableCarsToPurchase(identity.getRacingGame()));
			}
			identity.getRacingGame().setAvailableCash(identity.getRacingGame().getAvailableCash().add(RacingGameUtils.getPurseByClass(raceResult.getRacingClass(), 1)));
		} else if ("user".equals(raceResult.getSecondPlace())){
			raceResult.setSecondPlace(IdentityUtils.getDisplayedUser(identity));
			raceResult.setUserFinish(2);
			identity.getRacingGame().setAvailableCash(identity.getRacingGame().getAvailableCash().add(RacingGameUtils.getPurseByClass(raceResult.getRacingClass(), 2)));
		} else if ("user".equals(raceResult.getThirdPlace())){
			raceResult.setThirdPlace(IdentityUtils.getDisplayedUser(identity));
			raceResult.setUserFinish(3);
			identity.getRacingGame().setAvailableCash(identity.getRacingGame().getAvailableCash().add(RacingGameUtils.getPurseByClass(raceResult.getRacingClass(), 3)));
		}
		raceResult.setFirstPlaceTime(raceResult.getFirstPlaceTime().setScale(2, RoundingMode.HALF_UP));
		raceResult.setSecondPlaceTime(raceResult.getSecondPlaceTime().setScale(2, RoundingMode.HALF_UP));
		raceResult.setThirdPlaceTime(raceResult.getThirdPlaceTime().setScale(2, RoundingMode.HALF_UP));
		if (identity.getRacingGame().getRacingIdentifier()!=null&&identity.getRacingGame().getRacingIdentifier()>0){
			RacingGameUtils.updateRacingGame(identity.getRacingGame());
		}
		return new ResponseEntity<>(raceResult, HttpStatus.OK);
	}
	
	@RequestMapping("/spectateResults")
	public ModelAndView spectateResults(
			@ModelAttribute("raceResult") RaceResult raceResult){
		if (identity.getRacingGame()==null){
			return new ModelAndView("timeout");
		}
		ModelAndView mv = new ModelAndView("spectateResults");
		raceResult.setFirstPlaceTime(raceResult.getFirstPlaceTime().setScale(2, RoundingMode.HALF_UP));
		raceResult.setSecondPlaceTime(raceResult.getSecondPlaceTime().setScale(2, RoundingMode.HALF_UP));
		raceResult.setThirdPlaceTime(raceResult.getThirdPlaceTime().setScale(2, RoundingMode.HALF_UP));
		mv.addObject("raceResult", raceResult);
		return mv;
	}
	
	@RequestMapping(value = "/saveracinggame")
	//@ResponseStatus(value = HttpStatus.OK)
	public ModelAndView saveNewUser(@RequestParam(value = "identifier") Long identifier,
			@RequestParam(value = "sError", required=false) String sError){
		if (identity.getRacingGame()!=null){
			RacingGameUtils.insertRacingGameInfo(identity.getRacingGame(), identifier);
		}
		ModelAndView mv = new ModelAndView("newUserRedirect");
		mv.addObject("identifier", identifier);
		mv.addObject("type", "done");
		//mv.addObject("username", identity.getUsername());
		mv.addObject("sError", sError);
		return mv;
	}
	
}
