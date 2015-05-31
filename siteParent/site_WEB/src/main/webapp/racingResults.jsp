<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
h1{text-align: center;}
h2{text-align: center;}
h3{text-align: center;}
img{
	display: block;
	margin-left: auto;
	margin-right: auto;
}
</style>
<title>Race Results</title>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<jsp:useBean id="raceResult" class="site.racinggame.RacingGameResult" scope="session"/>
	<jsp:setProperty name="raceResult" property="*"/> 

	<%
	if (raceResult!=null&&raceResult.getRacingClass()!=' '){
		if ("car1".equals(raceResult.getFirstPlace())){
			out.println("<h1>You win!</h1>");
			out.println("<img src=\"img/misc/firstplace.gif\" width=\"150px\" height=\"200px\" />");
			if (raceResult.getRacingClass()==racingGame.getRacingClass()&&racingGame.getRacingClass()!='S'){
				if (racingGame.getRacingClass()=='E'){
					racingGame.setRacingClass('D');
					racingGame.setSelectedClass('D');
				} else if (racingGame.getRacingClass()=='D'){
					racingGame.setRacingClass('C');
					racingGame.setSelectedClass('C');
				} else if (racingGame.getRacingClass()=='C'){
					racingGame.setRacingClass('B');
					racingGame.setSelectedClass('B');
				}  else if (racingGame.getRacingClass()=='B'){
					racingGame.setRacingClass('A');
					racingGame.setSelectedClass('A');
				}  else if (racingGame.getRacingClass()=='A'){
					racingGame.setRacingClass('S');
					racingGame.setSelectedClass('S');
				}  
				out.println("<h3>You now qualify to race in class "+racingGame.getRacingClass()+" races</h3>");
			}
			racingGame.setAvailableCash(racingGame.getAvailableCash()+RacingGameUtils.getPurseByClass(raceResult.getRacingClass(), 1));
		} else if ("car1".equals(raceResult.getSecondPlace())){
			out.println("<h1>Second Place!</h1>");
			out.println("<img src=\"img/misc/secondplace.gif\" width=\"150px\" height=\"200px\" />");
			racingGame.setAvailableCash(racingGame.getAvailableCash()+RacingGameUtils.getPurseByClass(raceResult.getRacingClass(), 2));
		} else if ("car1".equals(raceResult.getThirdPlace())){
			out.println("<h1>Third Place!</h1>");
			out.println("<img src=\"img/misc/thirdplace.gif\" width=\"150px\" height=\"200px\" />");
			racingGame.setAvailableCash(racingGame.getAvailableCash()+RacingGameUtils.getPurseByClass(raceResult.getRacingClass(), 3));
		}
		out.println("<h2>Class: " + raceResult.getRacingClass() + "</h2>");
		out.println("<h3>First Place: " + raceResult.getFirstPlace() + "  Time: " + raceResult.getFirstPlaceTime() + "</h3>");
		out.println("<h3>Second Place: " + raceResult.getSecondPlace() + "  Time: " + raceResult.getSecondPlaceTime() + "</h3>");
		out.println("<h3>Third Place: " + raceResult.getThirdPlace() + "  Time: " + raceResult.getThirdPlaceTime() + "</h3>");
		raceResult.reset();
		out.println("<script>window.open('raceMoneyFrame.jsp', 'moneyFrame');</script>");
	} else {
		out.println("<h1>No Race Result Found</h1>");
	}
	%>
</body>
</html>