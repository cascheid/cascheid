<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<h2>Top Speed: ${raceCar.topSpeed} mph</h2>
	<h2>Acceleration: ${raceCar.acceleration} mph/s</h2>
	<h2>Reliability: ${raceCar.reliability*100}%</h2>
	<h2>Lap Efficiency: ${raceCar.lapEfficiency*100}%</h2>
	<img src="img/cars/${raceCar.model}" width="400px" height="200px">
	<!--<form method="POST" id="buyForm" action="purchaseCar.jsp">
		<input id="carID" type="hidden" name="carID"/>
		<input id="acceleration" type="hidden" name="acceleration"/>
		<input id="topSpeed" type="hidden" name="topSpeed"/>
		<input id="reliability" type="hidden" name="reliability"/>
		<input id="lapEfficiency" type="hidden" name="lapEfficiency"/>
		<input id="racingClass" type="hidden" name="racingClass"/>
		<input id="price" type="hidden" name="price"/>
		<input id="model" type="hidden" name="model"/>
		</form>-->
	<h1>Price: $${raceCar.price}</h><button onclick='purchaseCar()'>Buy it now</button>
	
	<script>
		function purchaseCar(){
			if (${raceCar.price}<=${availableCash}){
				
				//document.getElementById("carID").value=${raceCar.carID};
				//document.getElementById("acceleration").value=${raceCar.acceleration};
				//document.getElementById("topSpeed").value=${raceCar.topSpeed};
				//document.getElementById("reliability").value=${raceCar.reliability};
				//document.getElementById("lapEfficiency").value=${raceCar.lapEfficiency};
				//document.getElementById("racingClass").value='${raceCar.racingClass}';
				//document.getElementById("price").value=${raceCar.price};
				//document.getElementById("model").value="${raceCar.model}";
				//buyForm.submit();
				window.open("purchaseCar?carID=${raceCar.carID}","_self");
			} else {
				window.alert("You cannot afford this car!");
			}
		}
	</script>


</body>
</html>