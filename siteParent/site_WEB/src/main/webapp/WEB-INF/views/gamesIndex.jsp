<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<div class="index-content-main" data-ng-controller="gamesCtrl as games">
	<div id="gameTop" class="row">
		<div class="col-xs-3">
			<label class="large">Logged in as: <span data-ng-bind="$root.username?$root.username:'Anonymous'">Anonymous</span></label>
		</div>
		<div class="col-xs-6">
			<button class="btn btn-primary" type="button" data-ng-show="!$root.username" data-ng-click="games.loadUser()">Load User</button>
			<button class="btn btn-primary" type="button" id="btnCreate" data-ng-show="!$root.username" data-ng-click="games.createUser()">Save as New User</button>
			<button class="btn btn-primary" type="button" id="btnChange" data-ng-show="$root.username" data-ng-click="games.signout()">Sign Out</button>
		</div>
		<div class="col-xs-3 pull-right">
			<a title="List of Games" href="gamesIndex" target="_self">All Games</a>
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
		<md-grid-list md-cols="1" md-cols-sm="2" md-cols-md="3" md-cols-gt-md="6" md-row-height-gt-md="1:1" md-row-height="4:3" md-gutter="8px" md-gutter-gt-sm="4px">
			<md-grid-tile ui-sref="racing.store" ui-sref-active="active" md-rowspan="2" md-colspan="2" md-colspan-sm="1" md-colspan-xs="1" ng-class="tile.background">
				<!--<md-icon md-svg-icon="{{tile.icon}}"></md-icon>-->
				<md-grid-tile-footer><h3>Racing!</h3></md-grid-tile-footer>
			</md-grid-tile>
			<md-grid-tile ui-sref="snake" ui-sref-active="active" md-rowspan="2" md-colspan="2" md-colspan-sm="1" md-colspan-xs="1" ng-class="tile.background">
				<!--<md-icon md-svg-icon="{{tile.icon}}"></md-icon>-->
				<md-grid-tile-footer><h3>Snake</h3></md-grid-tile-footer>
			</md-grid-tile>
		</md-grid-list>
		<a ui-sref="racing.store" ui-sref-active="active">Racing</a>
		<a ui-sref="snake" ui-sref-active="active">Snake</a>
	</script>
</div>