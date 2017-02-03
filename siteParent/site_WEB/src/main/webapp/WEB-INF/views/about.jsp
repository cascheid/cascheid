<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  	<div class="col-xs-12" id="main" style="background: rgba(128,128,128,.85); border-radius: 0 0 5px 5px; width:100%; height:90vh">
  		<div class="row">
		<h1 class="underline">About Me</h1>
		</div>
		<div class="row">
			Christopher A Scheid
		</div>
		<div class="row">
			<p>Java developer based in the Washington D.C. metro area. Main enterprise experience in Java/JEE, but also have professional experience with javascript, PL/SQL, JSP web applications, GWT, linux, and bash. Also have minor to moderate experience in lots of other random things from personal projects (like this one).</p>
		</div>
		<div class="fullCenter" style="padding:0px">
			<label>Contact: </label> <a href="mailto:chris@cascheid.com">chris@cascheid.com</a> 
		</div>
		<h2 class="underline">About My Site</h2>
		<div id="wrapper">
			<div id="tabContainer">
    			<div class="tabs">
					<ul>
						<li id="tabHeader_1">General</li>
						<li id="tabHeader_2">Homepage</li>
						<li id="tabHeader_3">Racing</li>
						<li id="tabHeader_4">Snake</li>
						<li id="tabHeader_5">Battleship</li>
					</ul>
				</div>
    			<div id="tabscontent" style="display:none">
    				<div class="tabpage" id="tabpage_1">&nbsp;&nbsp;&nbsp;&nbsp;The site is built in a Spring MVC web application. Client pages are all jsp pages served by spring controllers, controllers connect into utility classes and a dao layer using Spring JDBC to connect to a mysql database. Setup of the application is pretty straightforward and simple, and is built with maven to handle all dependencies.</div>
					<div class="tabpage" id="tabpage_2">&nbsp;&nbsp;&nbsp;&nbsp;The homepage was drawn mainly with HTML5 canvas. I researched some effects, and built water ripple logic inspired by code.almeros.com, created a mist effect from particles, and then bound them to fit the image (partially transparent top image, and fitted bottom image), which is a setting from Disney's The Lion King. I'm not a graphical UI designer, so forgive me if it's a little rough. The fish are just moving around via intervals within a set boundary.
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;The water ripple basically pulls the image data and modifies individual pixels by copying its neighboring rgb values over. The code is designed so that you can specify locations to "disturb" the water, and the lifecycle of these disruptions is kept track of via a map. The code was adopted from code.almeros.com, so for better replication I'd recommend looking there.
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;The mist effect is really just many particles all moving randomly around a defined frame (I specified at the base of the waterfall). These particles use an image which is more or less just a white diffusion with a transparent background, so this moving around makes it look like mist. This was modeled after a smoke effect found online which I liked the look of. After a little modification, this is what I got.
					</div>
					<div class="tabpage" id="tabpage_3">&nbsp;&nbsp;&nbsp;&nbsp;The racing game was the first thing I built with javascript animation. It just uses interval loops and lots of custom logic, and sprite sheets (from mariouniverse.com) for animation of everything besides the cars. The cars were all found searching online, and via some photoshop made to be transparent. I know there is an occasional flicker when loading the game in IE, I already fixed as much of it as seemed easy to do at the time, but hopefully whats left doesn't detract too much.
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;This game has the most number of pages associated to it of the site, despite most of them being pretty simple. This was basically my introduction to Spring MVC in particular; after creating the race itself, I built it out into a full Spring MVC application which eventually turned into my site.</div>
					<div class="tabpage" id="tabpage_4">&nbsp;&nbsp;&nbsp;&nbsp;The snake game is a VERY simple game I created just because that was what I always intended to create first. It just holds onto one array for the snake, and continually pops the tail of the snake and moves it to the head, making there only really be one movement each time. All of the background images are just pictures of places I've traveled.</div>
					<div class="tabpage" id="tabpage_5">&nbsp;&nbsp;&nbsp;&nbsp;This is a multiplayer battleship game built using SockJS to connect via websockets through my Spring application. Everything displayed on the page is drawn with HTML5 canvas. The ripple effect is the same as the main page, the fire effect inspired by several code pieces found online looking for effects, and the explosion is just a simple particle explosion. There may be performance differences based on browsers, which I may look at in the future (probably need a buffer canvas). Right now, the game only supports having one active game window (can't play multiple people in multiple tabs); I may support this in the future.</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		window.onload=function() {
			var container = document.getElementById("tabContainer");
		    // set default data, even though we'll hide it
		    var navitem = container.querySelector(".tabs ul li");
		    var ident = navitem.id.split("_")[1];
		    navitem.parentNode.setAttribute("data-current",ident);
		    var pages = container.querySelectorAll(".tabpage");
		    for (var i = 0; i < pages.length; i++) {
		      pages[i].style.display="none";
		    }

		    var tabs = container.querySelectorAll(".tabs ul li");
		    for (var i = 0; i < tabs.length; i++) {
		      tabs[i].onclick=displayPage;
		    }
		}

		function displayPage() {
			document.getElementById("tabscontent").style.display='';
			var current = this.parentNode.getAttribute("data-current");
			document.getElementById("tabHeader_" + current).removeAttribute("class");
			document.getElementById("tabpage_" + current).style.display="none";

			var ident = this.id.split("_")[1];
			this.setAttribute("class","tabActiveHeader");
			document.getElementById("tabpage_" + ident).style.display="block";
			this.parentNode.setAttribute("data-current",ident);
		}
	</script>
</body>
</html>