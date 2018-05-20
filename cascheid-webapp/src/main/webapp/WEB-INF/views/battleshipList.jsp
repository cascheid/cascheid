<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<title>CAScheid Battleship</title>
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
<table width="100%" id="t01">
	<tr>
    	<th colspan="2">Create New Game</th>
    </tr>
	<tr>
    	<td>Opponent: <input id="oppName"></td>
    	<td><button onclick="createGame()">Create Game</button></td>
    </tr>
</table>
<table id="t01" width="100%">
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
<script>

	var iframes = parent.document.getElementsByName('leftFrame');
	for (var i = 0; i < iframes.length; i++) {
		iframes[i].parentNode.removeChild(iframes[i]);
	}

	iframes = parent.document.getElementsByName('displayFrame');
	for (var i = 0; i < iframes.length; i++) {
		iframes[i].style.width='100%';
	}
</script>
</body>
</html>