<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css" rel="stylesheet">
<title>CScheid Games</title>
</head>
<body>
	<nav id="nav01">
		<ul id='menu'>
			<li><a href='index'>Home</a></li>
			<li><a href='gamesIndex'>Games</a></li>
			<li><a href='about'>About</a></li>
		</ul>
	</nav>
	<div id="main" style="width:97%">
	<a title="Racing Game" href="racingparent?identifier=${identifier}" target="displayFrame">Racing Game</a>
	<a title="Snake Game" href="snakeFrame" target="displayFrame">Snake Game</a>
	</div>
	
	<iframe name="leftFrame" width="20%" height="750px" src="leftframe?identifier=${identifier}"></iframe>
	<iframe name="displayFrame" width="78%" height="750px" src="displayframe?identifier=${identifier}"></iframe>
	
</body>
</html>