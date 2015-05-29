<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<a target="rightUpgradeFrame" href="upgradeDisplayFrame.jsp?option=1"><h4>Upgrade 1</h4></a>
	<a target="rightUpgradeFrame" href="upgradeDisplayFrame.jsp?option=2"><h4>Upgrade 2</h4></a>
	<a target="rightUpgradeFrame" href="upgradeDisplayFrame.jsp?option=3"><h4>Upgrade 3</h4></a>
	<a target="rightUpgradeFrame" href="upgradeDisplayFrame.jsp?option=4"><h4>Upgrade 4</h4></a>
	<a target="rightUpgradeFrame" href="upgradeDisplayFrame.jsp?option=5"><h4>Upgrade 5</h4></a>
</body>
</html>