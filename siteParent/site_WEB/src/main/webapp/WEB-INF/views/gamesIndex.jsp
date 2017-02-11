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
		<a ui-sref="racing.store" ui-sref-active="active">Racing</a>
		<a ui-sref="snake" ui-sref-active="active">Snake</a>
	</script>
</div>