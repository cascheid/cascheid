<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css" rel="stylesheet">
<title>CScheid Games</title>
<style>
#top {
    padding: 5px;
    padding-left:  15px;
    padding-right: 15px;
    background-color: #ffffff;
    width:97%;
}
label {
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
	<div id="top">
		<div style="width:85%; float:left">
			<label>Username: ${username}</label>
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
	<script>
	if ('anonymous'!='${username}'){
	    document.getElementById("btnCreate").disabled = true;
	    document.getElementById("btnChange").disabled = false;
	}
	</script>
	
	<iframe name="leftFrame" width="20%" height="750px" src="leftframe?identifier=${identifier}"></iframe>
	<iframe name="displayFrame" width="78%" height="750px" src="displayframe?identifier=${identifier}"></iframe>
	
</body>
</html>