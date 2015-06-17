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
	<iframe name="topFrame" width="100%" height="50px" src="topframe?identifier=${identifier}"></iframe>
	<iframe name="leftFrame" width="20%" height="750px" src="leftframe?identifier=${identifier}"></iframe>
	<iframe name="displayFrame" width="78%" height="750px" src="displayframe?identifier=${identifier}"></iframe>
</body>
</html>