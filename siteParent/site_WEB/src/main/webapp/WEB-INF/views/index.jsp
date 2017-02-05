<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CAScheid Home</title>
<script src="build/vendor.js"></script>
<!--<script src="build/cascheid.js"></script>-->
<script src="js/index.js"></script>
<script src="js/about.js"></script>
<link href="build/vendor.css" rel="stylesheet">
<link href="build/cascheid.css" rel="stylesheet">
</head>
<body class="container-fluid site-body" ng-app="indexApp">
	<canvas class="bodyCanvas" id="bodyCanvas"></canvas>
	<div class="row" ng-controller="indexCtrl">
		<div class="col-xs-12">
			<uib-tabset>
				<uib-tab classes="tab-index" index="0" heading="Home">
  					<div class="index-content-main">
						<div class="form-inline">
							<label for="animationsToggle">Animations</label>
							<toggle id="animationsToggle" ng-model="animationToggle"></toggle>
						</div>
					</div>
				</uib-tab>
				<uib-tab classes="tab-index" index="1" heading="Games">
					<jsp:include page="gamesIndex.jsp" />
				</uib-tab>
				<uib-tab classes="tab-index" index="2" heading="About">
					<jsp:include page="about.jsp" />
				</uib-tab>
			</uib-tabset>
		</div>
	</div>
	<img id="top" src="img/misc/top.png" style='display:none'>
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