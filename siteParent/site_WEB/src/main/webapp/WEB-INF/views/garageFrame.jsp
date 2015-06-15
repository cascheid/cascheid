<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	select {font-weight: bold; font-size: 22px; float:left}
	div.inline{float:left; width: 100%; padding-bottom:10px;}
	label.large {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
</style>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<div class="inline">
	<label class="large">Select Another Car:</label>
	<form:form action="garageFrame" commandName="racingGame">
	<form:select id="selectedRow" path="selectedCar" onChange="selectGarage()">
		<c:forEach items="${racingGame.carList}" var="car" varStatus="status">
			<c:choose>
			<c:when test="${car.carID eq selectedGarage}">
				<option value="${car.carID}" selected="true">Garage ${status.count}</option>
			</c:when>
			<c:otherwise>
				<option value="${car.carID}">Garage ${status.count}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		</form:select>
		</form:form>
	</div>
	<script>
		function selectGarage(){
			var selectedRow=document.getElementById("selectedRow");
			var newSelectedCarID = selectedRow.options[selectedRow.selectedIndex].value;
			window.open("garageDisplay?selectedCarID="+newSelectedCarID, "garageDisplay");
		}
	</script>
	<iframe name="garageDisplay" src="garageDisplay?selectedCarID=${selectedCarID}" width="100%" height="750px"></iframe>
</body>
</html>