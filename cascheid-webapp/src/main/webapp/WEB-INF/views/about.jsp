<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<div class="index-content-main" data-ng-controller="aboutCtrl as about">
	<div class="row">
		<div class="col-xs-12">
			<div uib-accordion close-others="false">
				<div uib-accordion-group class="base-transparent">
					<div uib-accordion-heading>
						<h2 class="underline">About Me</h2>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<h3>Christopher A Scheid</h3>
							<p>Java developer based in the Washington D.C. metro area. Large scale enterprise experience in Java/JEE, Spring MVC, AngularJS, and GWT applications. Also have professional experience in MySQL/PLSQL, linux, and bash scripting.</p>
							<h3>Experience</h3>
							<div class="row">
								<div class="col-xs-4">
									<label for="javaExp">Java (Spring, JEE)</label>
									<div data-uib-progressbar class="background-light-grey" data-animate="false" data-value="about.javaExperience.percent" data-type="success">{{about.javaExperience.desc}}</div>
								</div>
								<div class="col-xs-4">
									<label for="jsExp">JavaScript (Vanilla, Angular, JQuery)</label>
									<div data-uib-progressbar class="background-light-grey" data-animate="false" data-value="about.jsExperience.percent" data-type="success">{{about.jsExperience.desc}}</div>
								</div>
								<div class="col-xs-4">
									<label for="sqlExp">SQL (PL/SQL, MySQL)</label>
									<div data-uib-progressbar class="background-light-grey" data-animate="false" data-value="about.sqlExperience.percent" data-type="success">{{about.sqlExperience.desc}}</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<label for="unixExp">Unix/Bash/Shell</label>
									<div data-uib-progressbar class="background-light-grey" data-animate="false" data-value="about.unixExperience.percent" data-type="success">{{about.unixExperience.desc}}</div>
								</div>
								<div class="col-xs-4">
									<label for="cssExp">CSS/SASS</label>
									<div data-uib-progressbar class="background-light-grey" data-animate="false" data-value="about.cssExperience.percent" data-type="success">{{about.cssExperience.desc}}</div>
								</div>
								<div class="col-xs-4">
									<label for="toolsExp">Process Tools (Maven, Ant, NPM, Bower, Grunt, Jira)</label>
									<div data-uib-progressbar class="background-light-grey" data-animate="false" data-value="about.toolsExperience.percent" data-type="success">{{about.toolsExperience.desc}}</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" align="center">
						<label for="contactLink">Contact: </label>
						<a id="contactLink" href="mailto:chris@cascheid.com">chris@cascheid.com</a> 
					</div>
				</div>
				<div uib-accordion-group class="base-transparent">
					<div uib-accordion-heading>
						<h2 class="underline">About My Site</h2>
					</div>
					<div class="row">
					</div>
					<uib-tabset class="tab-about">
						<div data-uib-tab class="tab-about" data-index="0" data-heading="General">
							<div class="row">
		    					<div style="padding:15px 30px">
		    						<p>&nbsp;&nbsp;&nbsp;&nbsp;The site is built in a Spring MVC web application. Client pages are all jsp pages served by spring controllers, controllers connect into utility classes and a dao layer using Spring JDBC to connect to a mysql database. Setup of the application is pretty straightforward and simple, and is built with maven to handle all dependencies.</p>
		    					</div>
		    				</div>
						</div>
						<div data-uib-tab data-index="1" data-heading="Homepage">
							<div class="row">
		    					<div style="padding:15px 30px">
		    						&nbsp;&nbsp;&nbsp;&nbsp;The homepage was drawn mainly with HTML5 canvas. I researched some effects, and built water ripple logic inspired by code.almeros.com, created a mist effect from particles, and then bound them to fit the image (partially transparent top image, and fitted bottom image), which is a setting from Disney's The Lion King. I'm not a graphical UI designer, so forgive me if it's a little rough. The fish are just moving around via intervals within a set boundary.
									<br />
									&nbsp;&nbsp;&nbsp;&nbsp;The water ripple basically pulls the image data and modifies individual pixels by copying its neighboring rgb values over. The code is designed so that you can specify locations to "disturb" the water, and the lifecycle of these disruptions is kept track of via a map. The code was adopted from code.almeros.com, so for better replication I'd recommend looking there.
									<br />
									&nbsp;&nbsp;&nbsp;&nbsp;The mist effect is really just many particles all moving randomly around a defined frame (I specified at the base of the waterfall). These particles use an image which is more or less just a white diffusion with a transparent background, so this moving around makes it look like mist. This was modeled after a smoke effect found online which I liked the look of. After a little modification, this is what I got.
								</div>
							</div>
						</div>
						<div data-uib-tab data-index="2" data-heading="Racing">
							<div class="row">
		    					<div style="padding:15px 30px">
		    						&nbsp;&nbsp;&nbsp;&nbsp;The racing game was the first thing I built with javascript animation. It just uses interval loops and lots of custom logic, and sprite sheets (from mariouniverse.com) for animation of everything besides the cars. The cars were all found searching online, and via some photoshop made to be transparent. I know there is an occasional flicker when loading the game in IE, I already fixed as much of it as seemed easy to do at the time, but hopefully whats left doesn't detract too much.
									<br />
									&nbsp;&nbsp;&nbsp;&nbsp;This game has the most number of pages associated to it of the site, despite most of them being pretty simple. This was basically my introduction to Spring MVC in particular; after creating the race itself, I built it out into a full Spring MVC application which eventually turned into my site.</div>
									<div>
								</div>
							</div>
						</div>
						<div data-uib-tab data-index="3" data-heading="Snake">
							<div class="row">
		    					<div style="padding:15px 30px">
		    						&nbsp;&nbsp;&nbsp;&nbsp;The snake game is a VERY simple game I created just because that was what I always intended to create first. It just holds onto one array for the snake, and continually pops the tail of the snake and moves it to the head, making there only really be one movement each time. All of the background images are just pictures of places I've traveled.
		    					</div>
		    				</div>
						</div>
						<div data-uib-tab data-index="4" data-heading="Battleship">
							<div class="row">
		    					<div style="padding:15px 30px">
		    						&nbsp;&nbsp;&nbsp;&nbsp;This is a multiplayer battleship game built using SockJS to connect via websockets through my Spring application. Everything displayed on the page is drawn with HTML5 canvas. The ripple effect is the same as the main page, the fire effect inspired by several code pieces found online looking for effects, and the explosion is just a simple particle explosion. There may be performance differences based on browsers, which I may look at in the future (probably need a buffer canvas). Right now, the game only supports having one active game window (can't play multiple people in multiple tabs); I may support this in the future.
		    					</div>
		    				</div>
						</div>
					</uib-tabset>
				</div>
			</div>
		</div>
	</div>
</div>