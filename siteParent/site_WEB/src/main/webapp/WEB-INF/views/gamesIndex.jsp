<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<div class="index-content-main" data-ng-controller="gamesCtrl as games">
	<div id="gameTop" class="row">
		<div class="col-xs-3">
			<label class="large">Logged in as: <span data-ng-bind="$root.identity.username?$root.identity.username:'Anonymous'">Anonymous</span></label>
		</div>
		<div class="col-xs-6">
			<button class="btn btn-primary" type="button" data-ng-show="!$root.identity.username" data-ng-click="games.loadUser()">Load User</button>
			<button class="btn btn-primary" type="button" id="btnCreate" data-ng-show="!$root.identity.username" data-ng-click="games.createUser()">Save as New User</button>
			<button class="btn btn-primary" type="button" id="btnChange" data-ng-show="$root.identity.username" data-ng-click="games.signout()">Sign Out</button>
		</div>
		<div class="col-xs-3 pull-right">
			<a title="List of Games" ui-sref="gamesIndex" ui-sref-active="active">All Games</a>
		</div>
	</div>
	<div class="borderedDiv row">
		<div class="col-xs-12">
    		<ui-view></ui-view>
		</div>
		<!-- <iframe id="leftFrame" name="leftFrame" style="width:20%; visibility:hidden; border-right: solid 2px #000000" frameborder=0 src="leftframe?identifier=${identifier}" onload="this.style.visibility='visible';"></iframe>
		<iframe id="displayFrame" name="displayFrame" style="width:78%; visibility:hidden" frameborder=0 src="displayframe?identifier=${identifier}" onload="this.style.visibility='visible';"></iframe> -->
	</div>
	<script type="text/ng-template" id="gamesList.html">
		<div class="row">
			<div class="col-xs-12">
				<h2 style="text-align:center">Select a Game to Play</h2>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<md-grid-list md-cols="4" d-cols-md="6" md-cols-gt-md="8" md-row-height="2:1">
					<md-grid-tile style="background:red;" class="gameTile" ui-sref="racing.store" ui-sref-active="active" md-rowspan="2" md-colspan="2" ng-class="tile.background">
						<md-icon class="gameIcon" md-svg-src="img/misc/racing.svg"></md-icon>
						<md-grid-tile-footer class="gameTileFooter">Racing!</md-grid-tile-footer>
					</md-grid-tile>
					<md-grid-tile style="background:lightgreen;" class="gameTile" ui-sref="snake" ui-sref-active="active" md-rowspan="2" md-colspan="2"ng-class="tile.background">
						<md-icon class="gameIcon" md-svg-src="img/misc/snake.svg"></md-icon>
						<md-grid-tile-footer class="gameTileFooter">Snake</md-grid-tile-footer>
					</md-grid-tile>
					<md-grid-tile style="background:lightblue;" class="gameTile" ui-sref="battleship" ui-sref-active="active" md-rowspan="2" md-colspan="2" ng-class="tile.background">
						<md-icon class="gameIcon" md-svg-src="img/misc/racing.svg"></md-icon>
						<md-grid-tile-footer class="gameTileFooter">Battleship</md-grid-tile-footer>
					</md-grid-tile>
				</md-grid-list>
			</div>
		</div>
	</script>
</div>