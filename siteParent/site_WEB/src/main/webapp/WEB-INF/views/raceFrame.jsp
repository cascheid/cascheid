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
	div.inline{display:inline-block; width: 100%; padding-bottom:10px; text-align:center;}
	label.large {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
	div.panel{float:left; width:30% height:100%}
	div.master{width:100%}
	button{
		width: 150px;
		padding: 10px;
		box-shadow: -8px 8px 10px 3px rgba(0,0,0,0.2);
		font-weight: bold;
		text-decoration: none;
		vertical-align:middle;
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
					<c:when test="${currClass eq 'E'}">
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
			<label class="large">Course Type: </label>
		<form:select id="selectedCourse" path="courseType">
			<form:options items="${availableCourses}" />
		</form:select>
		</div>
		
	</form:form>
	</div>
	<div class="panel">
	<c:forEach items="${feeMap}" var="fee" varStatus="status">
		<div>
			<label id="fee${fee.key}">Class ${fee.key} Fee: ${fee.value}</label>
		</div>
	</c:forEach>
	</div>
	</div>
	<button onClick="submitRace()">Ready to Race!</button>
	<script>
		function submitRace(){
			var selectedRacingClass=document.getElementById('selectedRacingClass').value;
			var fee=document.getElementById("fee"+selectedRacingClass).value;
			if (fee>'${racingGame.availableCash}'){
				window.alert("Cannot afford entry fee!");
			} else {
				raceForm.submit();
			}
		}
	</script>
</body>
</html>