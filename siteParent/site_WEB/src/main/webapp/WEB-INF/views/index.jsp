<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ taglib prefix="cascheid" tagdir="/WEB-INF/tags" %>
<title>CAScheid Home</title>
<cascheid:staticFiles debug="true"/>
</head>
<body class="container-fluid site-body" data-ng-app="indexApp">
	<canvas class="bodyCanvas" id="bodyCanvas"></canvas>
	<div data-ng-cloak class="row" data-ng-controller="indexCtrl as index">
		<div class="col-xs-12">
			<div data-uib-tabset>
				<div data-uib-tab data-classes="tab-index" data-index="0" data-select="index.selectHome(true)">
					<div data-uib-tab-heading>
						<i class="glyphicon glyphicon-home"></i> Home
					</div>
				</div>
				<div data-uib-tab data-classes="tab-index" data-index="1" data-select="index.selectHome(false)">
					<div data-uib-tab-heading>
						<i class="glyphicon glyphicon-globe"></i> Games
					</div>
					<jsp:include page="gamesIndex.jsp" />
				</div>
				<div data-uib-tab data-classes="tab-index" data-index="2" data-select="index.selectHome(false)">
					<div data-uib-tab-heading>
						<i class="glyphicon glyphicon-user"></i> About
					</div>
					<jsp:include page="about.jsp" />
				</div>
				<toggle style="padding-top:5px" data-ng-show="index.homeTabSelected" class="pull-right" on="Animations On" off="Animations Off" ng-change="index.toggleAnim()" id="animationsToggle" ng-model="index.animationsToggle"></toggle>
			</div>
		</div>
	</div>
	<img id="top" class="background-image" src="img/misc/top.png" style='display:none'>
	<img id="fish1" class="fish" src="img/sprites/fish.png" style='display:none'>
	<img id="fish2" class="fish" src="img/sprites/fish.png" style='display:none'>
	
	
	<script type="text/ng-template" id="indextabset.html">
	<div style="height:5vh">
		<ul style="height:5vh; border:none" class="nav nav-tabs" ng-transclude></ul>
		<div class="tab-content">
			<div class="tab-pane" ng-repeat="tab in tabset.tabs" ng-class="{active: tabset.active === tab.index}" uib-tab-content-transclude="tab">
    		</div>
  		</div>
	</div>
	</script>
	
	<script type="text/ng-template" id="indextab.html">
	<li style="height:5vh" ng-class="[{active: active}, classes]" class="uib-tab nav-item">
		<a style="height:5vh" href ng-click="select($event)" class="nav-link" uib-tab-heading-transclude>{{heading}}</a>
	</li>

	</script>
</body>
</html>