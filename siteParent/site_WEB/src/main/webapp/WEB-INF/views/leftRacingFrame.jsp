<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/textStyle.css"/>
<style>
	body{overflow:hidden;}
</style>
<title>Left Frame</title>
</head>
<body>
	<h1>Racing</h1>
	
	<div>
	<a title="Buy New Cars" href="openRacingStore" target="mainRacingFrame">Buy New Cars</a>
	</div>
	<div>
	<a title="Upgrade Car" href="openUpgradeStore" target="mainRacingFrame">Upgrade Car</a>
	</div>
	<div>
	<a title="Garage" href="garageFrame" target="mainRacingFrame">Garage</a>
	</div>
	<div>
	<a id="raceLink" title="Ready to Race" href="raceFrame" target="mainRacingFrame">Ready to Race</a>
	</div>
</body>
</html>