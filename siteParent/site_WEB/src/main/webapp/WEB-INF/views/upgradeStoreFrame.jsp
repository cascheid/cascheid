<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?test=3"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<c:forEach items="${upgradeOptions}" var="upgrade" varStatus="status">
		<a target="rightUpgradeFrame" href="upgradeDisplayFrame?upgradeID=${upgrade.upgradeID}"><h4>Upgrade ${status.count}</h4></a>
	</c:forEach>
</body>
</html>