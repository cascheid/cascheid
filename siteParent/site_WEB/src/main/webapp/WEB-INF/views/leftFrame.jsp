<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Left Frame</title>
</head>
<body>
	<h1>Game List</h1>
	<div>
		<a title="Racing Game" href="racingparent?identifier=${identifier}" target="displayFrame">Racing Game</a>
	</div>
	<div>
		<a title="Snake Game" href="snakeFrame" target="displayFrame">Snake Game</a>
	</div>
	<div>
		<a title="Battleship Game" href="battleship" target="displayFrame">Battleship</a>
	</div>
</body>
</html>