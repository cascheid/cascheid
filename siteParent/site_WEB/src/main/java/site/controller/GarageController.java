package site.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import site.identity.Identity;
import site.identity.IdentityUtils;
import site.racinggame.RacingGame;
import site.racinggame.RacingGameUtils;
import site.racinggame.UserRacecar;

@Controller
@Scope("session")
public class GarageController {
}
