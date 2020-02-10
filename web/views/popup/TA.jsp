<%@page import="java.util.ArrayList"%>
<%@page import="com.coo.ta.model.vo.HolidayAPI"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.coo.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Calendar cal = Calendar.getInstance();
	int solYear = cal.get(Calendar.YEAR);
	int solMonth = cal.get(Calendar.MONTH)+1;
	String solMonthstr = "" + solMonth;
	solMonthstr = solMonth>=10? solMonthstr : '0'+solMonthstr;
	
	ArrayList<String> hList = new HolidayAPI().getHoliday(solYear, solMonthstr);
	
	Member m = (Member)session.getAttribute("member");
	HashMap wtMap = (HashMap) request.getAttribute("wtMap");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 근태관리</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <!-- css Link -->
    <link rel="stylesheet" href="/semi/resources/css/TA/TAcss.css">
    
    <script>
    	var holiday = <%= hList %>;
    	
    </script>
    
    <script src="/semi/resources/js/TA/TAscript.js"></script>
</head>
<body>
    <div id="area">
        <div id="area1">
            <div id="day"></div>
            <span id="time"></span>
            <span id="userName"><%= m.getEmpName() %></span>
            <br><br><br>
            <hr>
            <span class="start">출근시간</span>
            <span id="startTime"><%=wtMap.get(0) %></span> <br>    <!--로직짜야됨--> 
            <span class="start">퇴근시간</span>
            <span id="endTime"><%=wtMap.get(1) %></span> <br>    <!--로직짜야됨--> 

			<% if(wtMap.get(0).equals("출근전")){ %>
            	<button id="startBtn" class="btn">출근 등록</button>
           	<%} else { %>
           		<button id="startBtn" class="btn" disabled>출근 등록</button>
       		<%} %>
            <% if(!wtMap.get(0).equals("출근전")){ %>
            	<button id="endBtn" class="btn">퇴근 등록</button>
            <%}else { %>
            	<button id="endBtn" class="btn" disabled>퇴근 등록</button>
            <%} %>
            <button id="vacationBtn" class="btn">휴무 신청</button>
            <button id="checkId" class="btn">결재 확인</button>
        </div>

        <div id="blankArea" class="changeArea"></div>

    </div>



</body>
</html>