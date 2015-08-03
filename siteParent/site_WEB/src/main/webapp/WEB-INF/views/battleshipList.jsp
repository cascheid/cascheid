<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style>
table {
    width:100%;
}
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 5px;
    text-align: left;
}
table#t01 tr:nth-child(even) {
    background-color: #eee;
}
table#t01 tr:nth-child(odd) {
   background-color:#fff;
}
table#t01 th	{
    background-color: black;
    color: white;
}
</style>
</head>
<body>
<script>
	function loadGame(gameID){
		if (gameID!=null&&gameID>0){
			window.open("loadBattleship?gameID="+gameID, "_self");
		}
	}
	
	function createGame(){
		var name = document.getElementById("oppName").value;
		if (name==''){
			window.alert("Enter name of opponent before continuing.");
		} else {
			window.open("battleshipCreate?opponent="+name, "_self");
		}
	}
</script>
<div style="width:100%">
	<label style="color:red">${sError}</label>
</div>
<table id="t01">
	<tr>
    	<th colspan="2">Create New Game</th>
    </tr>
	<tr>
    	<td>Opponent: <input id="oppName"></td>
    	<td><button onclick="createGame()">Create Game</button></td>
    </tr>
</table>
<table id="t01">
  <tr>
    <th>Opponent</th>
    <th>Status</th>
    <th>Play</th>
  </tr>
  	<c:if test="${empty activeGameList}">
  		<tr>
  			<td colspan="3">No Active Matches.</td>
  		</tr>
  	</c:if>
	<c:forEach items="${activeGameList}" var="game" varStatus="rowStatus">	
  	<tr>
    	<td>${game.opponent}</td>
    	<td>${game.status}</td>
    	<td><button onclick="loadGame(${game.gameID})">Play/View</button></td>
  	</tr>
	</c:forEach>
</table>
</body>
</html>