<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="textStyle.css"/>
<title>Left Frame</title>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<script type="text/javascript">
		function selectOption(selectedValue){
			document.getElementById("raceLink").href="raceFrame.jsp?selected="+selectedValue;
		}
	</script>
	<h1>Racing</h1>
	<div class="inline">
	<label>Racing Class</label>
	<select onchange="selectOption(this.value)">
  		<%
  		if (racingGame.getRacingClass()=='E'){
  			out.println("<option selected=\"selected\" value=\"E\">E</option>");
  		} else {
  			out.println("<option value=\"E\">E</option>");
  		}
  		if (racingGame.getRacingClass()=='S'||racingGame.getRacingClass()<='D'){
  			if (racingGame.getSelectedClass()=='D'){
  	  			out.println("<option selected=\"selected\" value=\"D\">D</option>");
  			} else {
  				out.println("<option value=\"D\">D</option>");
  			}
  		}
  		if (racingGame.getRacingClass()=='S'||racingGame.getRacingClass()<='C'){
  			if (racingGame.getSelectedClass()=='C'){
  	  			out.println("<option selected=\"selected\" value=\"C\">C</option>");
  			} else {
  				out.println("<option value=\"C\">C</option>");
  			}
  		}
  		if (racingGame.getRacingClass()=='S'||racingGame.getRacingClass()<='B'){
  			if (racingGame.getSelectedClass()=='B'){
  	  			out.println("<option selected=\"selected\" value=\"B\">B</option>");
  			} else {
  				out.println("<option value=\"B\">B</option>");
  			}
  		}
  		if (racingGame.getRacingClass()=='S'||racingGame.getRacingClass()=='A'){
  			if (racingGame.getSelectedClass()=='A'){
  	  			out.println("<option selected=\"selected\" value=\"A\">A</option>");
  			} else {
  				out.println("<option value=\"A\">A</option>");
  			}
  		}
  		if (racingGame.getRacingClass()=='S'){
  			if (racingGame.getSelectedClass()=='S'){
  	  	  		out.println("<option selected=\"selected\" value=\"S\">S</option>");
  			} else {
  				out.println("<option value=\"S\">S</option>");
  			}
  		}
  		%>
	</select> 
	</div>
	<hr/>
	<div>
	<a title="Buy New Cars" href="openRacingStore.html?test=2" target="mainRacingFrame">Buy New Cars</a>
	</div>
	<div>
	<a title="Upgrade Car" href="openUpgradeStore.html" target="mainRacingFrame">Upgrade Car</a>
	</div>
	<div>
	<a title="Garage" href="garageFrame.jsp" target="mainRacingFrame">Garage</a>
	</div>
	<div>
	<a id="raceLink" title="Ready to Race" href="raceFrame.jsp?selected=<%=racingGame.getSelectedClass()%>" target="mainRacingFrame">Ready to Race</a>
	</div>
</body>
</html>