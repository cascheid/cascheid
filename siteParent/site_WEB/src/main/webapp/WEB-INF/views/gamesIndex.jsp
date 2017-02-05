<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

	<script>
	function loadUser(){
		var username=window.prompt("Enter the username to load. NOTE: All current progress will be lost.");
		if (username!=null&&username!=''){
			window.open("updateUser?type=load&name="+username, "_self");
		}
	}

	function createUser(){
		var username=window.prompt("Enter the username to create. All current progress will be saved to this account.");
		if (username!=null&&username!=''){
			window.open("updateUser?type=create&name="+username, "_self");
		}
	}

	function saveNewUserData(){
		if (window.XMLHttpRequest){
			var req=new XMLHttpRequest();
			req.open("POST","saveracinggame",true);
			req.send("identifier=${identifier}");
		}
	}

	function changeUsername(){
		var username=window.prompt("Enter the new username to replace ${username}.");
		if (username!=null&&username!=''){
			window.open("updateUser?type=change&name="+username, "_self");
		}
	}

	var newUser='${newUser}';
	if (newUser=='true'){
		saveNewUserData();
	}
	</script>
<div class="index-content-main" data-ng-controller="gamesCtrl as games">
	<div id="gameTop" class="row">
		<div class="col-xs-3">
			<label class="large">Logged in as: ${username}</label>
		</div>
		<div class="col-xs-6">
			<button class="btn btn-primary" onclick="loadUser()">Load User</button>
			<button class="btn btn-primary" id="btnCreate" onclick="createUser()">Save as New User</button>
			<button class="btn btn-primary" id="btnChange" onclick="changeUsername()" disabled="true">Change Username</button>
		</div>
		<div class="col-xs-4 pull-right">
			<a title="List of Games" href="gamesIndex" target="_self">All Games</a>
		</div>
		<div style="width:97%; clear:both;">
			<label style="color:red">${sError}</label>
		</div>
	</div>
	<div class="borderedDiv">
		<iframe id="leftFrame" name="leftFrame" style="width:20%; visibility:hidden; border-right: solid 2px #000000" frameborder=0 src="leftframe?identifier=${identifier}" onload="this.style.visibility='visible';"></iframe>
		<iframe id="displayFrame" name="displayFrame" style="width:78%; visibility:hidden" frameborder=0 src="displayframe?identifier=${identifier}" onload="this.style.visibility='visible';"></iframe>
	</div>
	</div>
	
	<script>
	document.onreadystatechange = function(e){
	    if (document.readyState === 'complete'){
	    	document.getElementById('leftFrame').height=(window.innerHeight-150)+'px';
	    	document.getElementById('displayFrame').height=(window.innerHeight-150)+'px';
	    }
	};
	if ('anonymous'!='${username}'){
	    document.getElementById("btnCreate").disabled = true;
	    document.getElementById("btnChange").disabled = false;
	}
	</script>