<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CAScheid Game List</title>
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<style>
</style>
</head>
<body>
	<h1 class="underline">Game List</h1>
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