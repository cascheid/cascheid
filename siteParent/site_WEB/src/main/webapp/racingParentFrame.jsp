<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="textStyle.css"/>
</head>
<body>
	<jsp:useBean id="identity" class="site.identity.Identity" scope="session"/>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<jsp:setProperty name="racingGame" property="*"/> 
	<%
		racingGame = RacingGameUtils.getRacingGameObject(identity.getRacingGameIdentifier());
	%>
	<script>
		window.open("leftRacingFrame.jsp", "leftFrame");
	</script>
	<div class="inline">
		Money<input width="50px" value="<%=RacingGameUtils.formatMoney(racingGame.getAvailableCash())%>" readonly>
		Class<input width="25px" value="<%=racingGame.getRacingClass()%>" readonly>
	</div>
	<iframe name="mainRacingFrame" width="100%" height="100%" src="openRacingStore.html"></iframe>
</body>
</html>