<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
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
	<div class="statsinline">
		<div class="statssplit">
			<h2 style="text-align:right">Select Another Car:</h2>
		</div>
		<div class="statssplit">
			<form:form action="garageFrame" commandName="racingGame">
				<form:select id="selectedRow" path="selectedCar" onChange="selectGarage()">
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
			</form:form>
		</div>
	</div>
	<iframe id="garageDisplay" name="garageDisplay" src="garageDisplay?selectedCarID=${selectedCarID}" width="100%" frameBorder="0" style="margin-top:-30px; visibility:hidden" onload="this.style.visibility='visible';"></iframe>
	<script>
		document.onreadystatechange = function(e){
	    	if (document.readyState === 'complete'){
	    		document.getElementById('garageDisplay').height=(window.innerHeight-50)+'px';
	    	}
		};
		function selectGarage(){
			var selectedRow=document.getElementById("selectedRow");
			var newSelectedCarID = selectedRow.options[selectedRow.selectedIndex].value;
			window.open("garageDisplay?selectedCarID="+newSelectedCarID, "garageDisplay");
		}
	</script>
</body>
</html>