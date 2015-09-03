<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css?version=1.00" rel="stylesheet">
<title>CAScheid Games</title>
<style>
body{
	background-image: url(img/misc/timon.jpg);
	-moz-background-size: cover;
	-webkit-background-size: cover;
	background-size: cover;
	background-position: top center;
	background-repeat: no-repeat;
	background-attachment: fixed;
}
#gameTop{
	height:50px;
}
#userLabel{
    color: #34282C;
    padding-right:  15px;
}
</style>
</head>
<body>
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
	<nav id="nav01">
		<ul id='menu'>
			<li><a href='index'>Home</a></li>
			<li><a href='gamesIndex'>Games</a></li>
			<li><a href='about'>About</a></li>
		</ul>
	</nav>
	<div id="main">
	<div id="gameTop">
		<div style="width:85%; float:left">
			<label class="large">Logged in as: ${username}</label>
			<button onclick="loadUser()">Load User</button>
			<button id="btnCreate" onclick="createUser()">Save as New User</button>
			<button id="btnChange" onclick="changeUsername()" disabled="true">Change Username</button>
		</div>
		<div style="width:15%; float:right">
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
</body>
</html>