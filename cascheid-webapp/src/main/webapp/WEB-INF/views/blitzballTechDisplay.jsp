<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href="css/blitzball.css?version=1.00"/>
		<script src="js/BBNavMenu.js?version=0.1"></script>
		<style>
			.techSelectorWrapper{
				position:absolute;
				top:0;
				left:-5vmin;
			}
		</style>
	</head>

	<body>
		<div id="techInfoDiv" class="absoluteCentered" style="position:absolute; top:5vmin; max-width:80vmin; word-wrap:break-word; white-space:normal">
			<div id="techInfoName" style="color: #FFFF66"></div>
			<div id="techInfoStats"></div>
			<div id="techInfoDescription"></div>
		</div>
		<div id="displayedTechsContainer" class="menu absoluteCentered" style="display:none; width:100vmin; height:61vmin; top:35vmin"> 
			<div id='techPage1' class="innerMenu">
				<div style="position:absolute; top:2.5vmin; left:5vmin;">
					<div class="techSelectorWrapper">
						<img id="techSelector1_1" class="selector" src="img/blitzball/arrow.png" />
					</div>
			<c:forEach var="tech" items='${techList}' varStatus="status">
					<div>
				<c:choose>
  					<c:when test="${currPlayer.learnedTechs.contains(techList[status.index].techID)}">
  						<label id="tech${status.count}">${techList[status.index].techName}</label>
  					</c:when>
  					<c:when test="${currPlayer.learnableTechs.contains(techList[status.index].techID)}">
  						<label id="tech${status.count}">- - - - - - - -</label>
  					</c:when>
  					<c:otherwise>
  						<label id="tech${status.count}">&nbsp;</label>
  					</c:otherwise>
  				</c:choose>
  					</div>
  				<c:if test="${status.count==11}">
  				</div>
				<div style="position:absolute; top:2.5vmin; left:40vmin;">
					<div class="techSelectorWrapper">
						<img id="techSelector1_2" class="selector" style="display:none" src="img/blitzball/arrow.png" />
					</div>
  				</c:if>
  				<c:if test="${status.count==22}">
  				</div>
				<div style="position:absolute; top:2.5vmin; left:70vmin;">
					<div class="techSelectorWrapper">
						<img id="techSelector1_3" class="selector" style="display:none" src="img/blitzball/arrow.png" />
					</div>
  				</c:if>
  				<c:if test="${status.count==32}">
  					<div>Next Page</div>
  				</div>
  			</div>
			<div id='techPage2' class="innerMenu" style="display:none">
				<div style="position:absolute; top:2.5vmin; left:5vmin;">
					<div class="techSelectorWrapper">
						<img id="techSelector2_1" class="selector" style="display:none" src="img/blitzball/arrow.png" />
					</div>
  				</c:if>
  				<c:if test="${status.count==43}">
  				</div>
				<div style="position:absolute; top:2.5vmin; left:40vmin;">
					<div class="techSelectorWrapper">
						<img id="techSelector2_2" class="selector" style="display:none" src="img/blitzball/arrow.png" />
					</div>
  				</c:if>
  				<c:if test="${status.count==54}">
  				</div>
				<div style="position:absolute; top:2.5vmin; left:70vmin;">
					<div class="techSelectorWrapper">
						<img id="techSelector2_3" class="selector" style="display:none" src="img/blitzball/arrow.png" />
					</div>
  				</c:if>
  				<c:if test="${status.count==64}">
  				<div>Prev Page</div>
  				</div>
  			</div>
  				</c:if>
  			</c:forEach>
			<div class="absoluteCentered" style="position:absolute; top:50.5vmin">
				<div style="display:inline-block;" align="center">
					<div style="color:yellow">Key Techniques:</div>
					<div><label id="keyTechs">${techList[currPlayer.keyTech1.techID-1].techName} &nbsp&nbsp&nbsp ${techList[currPlayer.keyTech2.techID-1].techName} &nbsp&nbsp&nbsp ${techList[currPlayer.keyTech3.techID-1].techName}</label></div>
				</div>
				<div  style="display:inline-block; padding-left:5vmin" align="center">
					<div style="color:yellow">Current HP:</div>
					<div><label id="currHP">${currPlayer.hp}</label></div>
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
		var techNavMenu = new BBNavMenu('techSelector1_1', MAXROWS, 1);
		
		
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function upButtonPressed(){
			if (pageShowing>0){
				techNavMenu.moveUp();
				showTechInfo();
			}
		}

		function downButtonPressed(){
			if (pageShowing>0){
				techNavMenu.moveDown();
				showTechInfo();
			}
		}

		function leftButtonPressed(){
			if (pageShowing>0){
				if (techCol<=1){
					techCol=MAXCOLS;
				} else {
					techCol--;
				}
				techNavMenu.updateActiveSelector('techSelector'+pageShowing+'_'+techCol, MAXROWS, techNavMenu.getRow());
				showTechInfo();
			}
		}

		function rightButtonPressed(){
			if (pageShowing>0){
				if (techCol>=MAXCOLS){
					techCol=1;
				} else {
					techCol++;
				}
				techNavMenu.updateActiveSelector('techSelector'+pageShowing+'_'+techCol, MAXROWS, techNavMenu.getRow());
				showTechInfo();
			}
		}

		function hideTechInfo(){
			document.getElementById('techInfoName').innerHTML='';
			document.getElementById('techInfoStats').innerHTML='';
			document.getElementById('techInfoDescription').innerHTML='';
		}
		
		function showTechInfo(){
			var techNum=techNavMenu.getRow()+(techCol-1)*MAXROWS;
			if (techNum!=MAXCOLS*MAXROWS){
				if (pageShowing==2){
					techNum=techNum+MAXROWS*MAXCOLS-1;
				}
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
				if (techCol==MAXCOLS&&techNavMenu.getRow()==MAXROWS){
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
				hideTechInfo();
			} else {
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
			techCol=1;
			document.getElementById('displayedTechsContainer').style.display='';
			techNavMenu.updateActiveSelector('techSelector'+pageShowing+'_1', MAXROWS, 1);
			if (pageNum==1){
				document.getElementById('techPage1').style.display='table';
				document.getElementById('techPage2').style.display='none';
			} else if (pageNum==2){
				document.getElementById('techPage2').style.display='table';
				document.getElementById('techPage1').style.display='none';
			}
			showTechInfo();
		}

		</script>

	</body>
</html>
