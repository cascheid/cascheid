<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<link rel="stylesheet" type="text/css" href="css/racing.css?version=1.00"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<h1>Select Race Options</h1>
	<div class="fullCenter">
		<div style="width: 49%; float: left; height:150px">
			<form:form id="raceForm" action="startRace" commandName="raceInfo">
				<div class="inline">
					<label class="large">Racing Class: </label>
					<form:select id="selectedRacingClass" path="racingClass">
						<c:forEach items="${availableClasses}" var="currClass" varStatus="status">
							<c:choose>
								<c:when test="${currClass==racingGame.selectedClass}">
									<option value="${currClass}" selected="true">${currClass}</option>
								</c:when>
								<c:otherwise>
									<option value="${currClass}">${currClass}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</form:select>
				</div>
				<div class="inline">
					<label class="large">Racing Type: </label>
					<form:select id="selectedRaceType" path="raceType">
						<c:forEach items="${availableTypes}" var="currType" varStatus="status">
							<c:choose>
								<c:when test="${currType==racingGame.selectedMode}">
									<option value="${currType}" selected="true">${currType}</option>
								</c:when>
								<c:otherwise>
									<option value="${currType}">${currType}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</form:select>
				</div>
				<div class="inline">
					<label class="large">Selected Car: </label>
					<form:select id="selectedCar" path="carID">
						<c:forEach items="${racingGame.carList}" var="car" varStatus="status">
							<c:choose>
								<c:when test="${car.carID==racingGame.selectedCar.carID}">
									<option value="${car.carID}" selected="true">${car.name}</option>
								</c:when>
								<c:otherwise>
									<option value="${car.carID}">${car.name}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</form:select>
				</div>
			</form:form>
		</div>
		<div style="width: 49%; float: left; height:150px">
			<c:forEach items="${feeMap}" var="fee" varStatus="status">
				<div style="text-align:left;">
					<label style="float: left; padding-left: 30%">Class	${fee.key} Fee: </label>
					<label style="padding-left:10px" id="fee${fee.key}">${fee.value}</label>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="fullCenter">
		<button onClick="submitRace()">Ready to Race!</button>
	</div>
	<script>
		function submitRace(){
			var selectedRacingClass=document.getElementById('selectedRacingClass').value;
			var feeElem=document.getElementById("fee"+selectedRacingClass);
			var fee=feeElem.textContent;
			if (fee>${racingGame.availableCash}){
				window.alert("Cannot afford entry fee!");
			} else {
				raceForm.submit();
			}
		}
	</script>
</body>
</html>