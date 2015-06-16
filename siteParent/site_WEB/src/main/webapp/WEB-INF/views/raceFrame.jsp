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
	h1{text-align: center;}
	select {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
	div.inline{display:inline-block; width: 100%; padding-bottom:10px; text-align:left;}
	label.large {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
	label.small {float:left; padding-left:30%;}
	div.panel{float:left; width:49%; height:100%; text-align:left;}
	div.master{width:100%;float:left; width: 100%; padding-bottom:10px; text-align:center;}
	button{
		width: 150px;
		padding: 10px;
		box-shadow: -8px 8px 10px 3px rgba(0,0,0,0.2);
		font-weight: bold;
		text-decoration: none;
		vertical-align:middle;
		margin:auto;
	}
</style>
</head>
<body>
	<h1>Select Race Options</h1>
	<div class="master">
	<div class="panel">
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
			<form:options items="${availableTypes}" />
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
		<!-- <div class="inline">
			<label class="large">Course Type: </label>
		<form:select id="selectedCourse" path="courseType">
			<form:options items="${availableCourses}" />
		</form:select>
		</div> -->
		
	</form:form>
	</div>
	<div class="panel">
	<c:forEach items="${feeMap}" var="fee" varStatus="status">
		<div class="inline">
			<label class="small">Class ${fee.key} Fee: </label>
			<label id="fee${fee.key}">${fee.value}</label>
		</div>
	</c:forEach>
	</div>
	</div>
	<div class="master">
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