<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Blitzball!</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				background:none transparent;
				padding:0;
				margin:0;
				font-weight: bold;
				overflow:hidden;
			}
			
			#techInfoDiv{
				font-size:3.5vmin;
				line-height:4vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				left:40%;
				width:50%;
				background:none transparent;
				z-index:1000;
			}
			
			#techSelector{
				position:absolute;
				left:0vmin;
				top:0vmin;
				width:5vmin;
				height:4vmin;
			}
			
			#displayedTechsContainer{
				position:absolute;
				color: #ffffff;
				font-size:3.5vmin;
				line-height:4vmin;
				top:40%;
				width:81%;
				height:55%;
				left:10%;
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
				z-index:1001;
			}
		</style>
	</head>

	<body>
		<div id="techInfoDiv">
			<label id="techInfoName" style="color: #FFFF66"></label><br/>
			<label id="techInfoStats"></label>
			<p id="techInfoDescription"></p>
		</div>
		<div id="displayedTechsContainer" style="display:none"> 
			<img id="techSelector" src="img/blitzball/arrow.png" />
					<div id='techPage1' style="display:table; width:100%;">
			<c:forEach var="tech" items='${techList}' varStatus="status">
				<%-- beginning tags, if its the first in a row, start the row. If its the last in the row, width must be smaller for 
				styling purposes. Since Next Page and Prev Page take up a spot in the grid, there must be a shift at #33 (Next Page) --%>
  				<c:choose>
  					<c:when test="${(status.count<33&&status.count%3==1)||(status.count>=33&&status.count%3==0)}">
  						<div style="display:table-row">
  						<div style="display:table-cell; padding-left:5vmin; width:30vw">
  					</c:when>
  					<c:when test="${(status.count<33&&status.count%3==0)||(status.count>=33&&status.count%3==2)}">
  						<div style="display:table-cell; padding-left:5vmin; width:20vw">
  					</c:when>
  					<c:otherwise>
  						<div style="display:table-cell; padding-left:5vmin; width:30vw">
  					</c:otherwise>
  				</c:choose>
  				<%-- In between tags, add actual content of whether they can see info or not --%>
  				<c:choose>
  					<c:when test="${currPlayer.learnedTechs.contains(techList[status.index].techID)}">
  						<label id="tech${status.count}">${techList[status.index].techName}</label>
  					</c:when>
  					<c:when test="${currPlayer.learnableTechs.contains(techList[status.index].techID)}">
  						<label id="tech${status.count}">- - - - - - - -</label>
  					</c:when>
  					<c:otherwise>
  						<label id="tech${status.count}">&nbsp</label>
  					</c:otherwise>
  				</c:choose>
  				<%-- Ending tags, if next element is Next Page or Prev Page, add it, otherwise just close div --%>
  				<c:choose>
  					<c:when test="${status.count==32}">
  						</div>
  						<div style="display:table-cell; padding-left:5vmin; width:20vw">
  						<label>Next Page</label>
						</div><%-- close cell --%>
						</div><%-- close row --%>
						</div><%-- close table --%>
						<div id='techPage2' style="display:table; width:100%;">
  					</c:when>
  					<c:when test="${status.count==64}">
  						</div>
  						<div style="display:table-cell; padding-left:5vmin; width:20vw">
  						<label>Prev Page</label>
						</div><%-- close cell --%>
						</div><%-- close row --%>
						</div><%-- close table --%>
  					</c:when>
  					<c:when test="${(status.count<33&&status.count%3==0)||(status.count>=33&&status.count%3==2)}">
						</div><%-- close cell --%>
						</div><%-- close row --%>
  					</c:when>
  					<c:otherwise>
						</div><%-- close cell --%>
  					</c:otherwise>
  				</c:choose>			
  			</c:forEach>
			<div style="display:table; width:100%">
				<div style="display:table-row">
					<div style="display:table-cell; color:#00BFFF; width:50vw; padding-left:5vmin">Key Techniques:</div>
					<div style="color: #FFFF66; display:table-cell; width:30vw">Current HP:</div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; width:50vw; padding-left:5vmin"><label id="keyTechs">${techList[currPlayer.keyTech1.techID-1].techName} &nbsp&nbsp&nbsp&nbsp&nbsp ${techList[currPlayer.keyTech2.techID-1].techName} &nbsp&nbsp&nbsp&nbsp&nbsp ${techList[currPlayer.keyTech3.techID-1].techName}</label></div>
					<div style="display:table-cell; width:30vw"><label id="currHP">${currPlayer.hp}</label></div>
				</div>
			</div>
		</div>
		
		<script>
		var pageShowing=0;
		var techRow=1;
		var techCol=1;
		var MAXCOLS=3;
		var MAXROWS=11;
		var techList=${techListJSON};
		
		
		document.body.onkeydown = function(e){
		    parent.onKeyDown(e);
		};

		function upButtonPressed(){
			if (pageShowing>0){
				if (techRow<=1){
					techRow=MAXROWS;
				} else {
					techRow--;
				}
				document.getElementById('techSelector').style.top=(techRow-1)*4+'vmin';

				var techID=(techRow-1)*MAXCOLS+techCol;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			}
		}

		function downButtonPressed(){
			if (pageShowing>0){
				if (techRow>=MAXROWS){
					techRow=1;
				} else {
					techRow++;
				}
				document.getElementById('techSelector').style.top=(techRow-1)*4+'vmin';

				var techID=(techRow-1)*MAXCOLS+techCol;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			}
		}

		function leftButtonPressed(){
			if (pageShowing>0){
				if (techCol<=1){
					techCol=MAXCOLS;
				} else {
					techCol--;
				}
				document.getElementById('techSelector').style.left=(techCol-1)*30+'vw';

				var techID=(techRow-1)*MAXCOLS+techCol;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			}
		}

		function rightButtonPressed(){
			if (pageShowing>0){
				if (techCol>=MAXCOLS){
					techCol=1;
				} else {
					techCol++;
				}
				document.getElementById('techSelector').style.left=(techCol-1)*30+'vw';

				var techID=(techRow-1)*MAXCOLS+techCol;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			}
		}

		function hideTechInfo(){
			document.getElementById('techInfoName').innerHTML='';
			document.getElementById('techInfoStats').innerHTML='';
			document.getElementById('techInfoDescription').innerHTML='';
		}
		
		function showTechInfo(techNum){
			if (techNum>0){
				var tech = techList[techNum-1];

				if (document.getElementById('tech'+techNum).innerHTML==tech.techName){
					document.getElementById('techInfoName').innerHTML=tech.techName;
					var statsString='HP Cost: '+tech.hpCost+' ';
					if (tech.techType=='SHOT'){
						statsString+=' SH + '+tech.statMod;
					} else if (tech.techType=='ATTACK'){
						statsString+=' ATK + '+tech.statMod;
					} else if (tech.techType=='PASS'){
						statsString+=' PAS + '+tech.statMod;
					}
					document.getElementById('techInfoStats').innerHTML=statsString;
					document.getElementById('techInfoDescription').innerHTML=tech.techDescription;
				} else {
					hideTechInfo();
				}
			} else {
				hideTechInfo();
			}
		}

		function selectButtonPressed(){
			if (pageShowing==0){
				showTechPageCurrPlayer(1);
			} else if (pageShowing>0){
				if (techCol==MAXCOLS&&techRow==MAXROWS){
					if (pageShowing==1){
						showTechPageCurrPlayer(2);
					} else if (pageShowing==2){
						showTechPageCurrPlayer(1);
					}
				}
			}
		}

		function cancelButtonPressed(){
			if (pageShowing>0){
				pageShowing=0;
				document.getElementById('displayedTechsContainer').style.display='none';
				techCol=1;
				techRow=1;
				parent.cancelButtonPressed();
			}
		}

		function onKeyDown(event){
			if (event.keyCode==40){
				event.preventDefault();
				downButtonPressed();
			} else if (event.keyCode==38){
				event.preventDefault();
				upButtonPressed();
			} else if (event.keyCode==37){
				event.preventDefault();
				leftButtonPressed();
			} else if (event.keyCode==39){
				event.preventDefault();
				rightButtonPressed();
			} else if (event.keyCode==90){
				event.preventDefault();
				selectButtonPressed();
			} else if (event.keyCode==88){
				event.preventDefault();
				cancelButtonPressed();
			}
		}
		
		function showTechPageCurrPlayer(pageNum){
			pageShowing=pageNum;
			document.getElementById('displayedTechsContainer').style.display='';
			if (pageNum==1){
				document.getElementById('techPage1').style.display='table';
				document.getElementById('techPage2').style.display='none';
				showTechInfo(1);
			} else if (pageNum==2){
				document.getElementById('techPage2').style.display='table';
				document.getElementById('techPage1').style.display='none';
				showTechInfo(MAXROWS*MAXCOLS);
			}
		}

		</script>

	</body>
</html>
