<%@page import="com.coo.ta.model.vo.TaData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.coo.ta.model.vo.HolidayAPI"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.coo.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//	공휴일 정보
	Calendar cal = Calendar.getInstance();
	int solYear = cal.get(Calendar.YEAR);
	int solMonth = cal.get(Calendar.MONTH)+1;
	String solMonthstr = "" + solMonth;
	solMonthstr = solMonth>=10? solMonthstr : '0'+solMonthstr;
	
	ArrayList<String> hList = new HolidayAPI().getHoliday(solYear, solMonthstr);
	
	Member m = (Member)session.getAttribute("member");
	
	//	출/퇴근 시간
	HashMap<Integer, String> wtMap = (HashMap<Integer, String>) request.getAttribute("wtMap");
	HashMap<Integer, String> wtMap2 = new HashMap<Integer, String>();

	String time="";
	for(int i=0; i<wtMap.size(); i++){
		if(wtMap.get(i).length() == 3){
			time = wtMap.get(i);
			String[] timeStr = time.split("");
			time = "0" + timeStr[0] + ":" + timeStr[1] + timeStr[2];
		}else if(wtMap.get(i).length() == 4){
			time = wtMap.get(i);
			String[] timeStr = time.split("");
			time = timeStr[0]+timeStr[1]+":"+timeStr[2]+timeStr[3];
		}else{
			time = "등록전";
		}
		wtMap2.put(i, time);
	}
	
	String temp="";
	if(wtMap2.get(1).length() != 3){
		if(wtMap2.get(0).compareTo(wtMap2.get(1)) > 0 ){
			temp = wtMap2.get(0);
			wtMap2.put(0, wtMap2.get(1));
			wtMap2.put(1, temp);
		}
	}
	
	//	근무현황
	TaData td = (TaData)request.getAttribute("td");
	String workdayCount = 
			td.getWorkdayCount()>10? ""+td.getWorkdayCount():"0"+td.getWorkdayCount();
	String lateCount = 
			td.getLateCount()>10? ""+td.getLateCount():"0"+td.getLateCount();
	String absentCount =
			td.getAbsentCount()>10? ""+td.getAbsentCount():"0"+td.getAbsentCount();
	
	//	총 추가 근무 시간
	String ot = (String) request.getAttribute("allOT"); 
	if(ot.length() == 3){
		ot = "0"+ot;
	}else if (ot.length() == 2){
		ot = "00"+ot;
	}else if (ot.length() == 1){
		ot = "000"+ot;
	}
	String[] otArr = ot.split("");
	String otH = otArr[0]+otArr[1];
	String otM = otArr[2]+otArr[3];
	
	
	//	총 추가 근무 시간 (퍼센트)
	double hour12 = 12 * 60;
	
	int otHour = Integer.parseInt(otH);
	int otMin = Integer.parseInt(otM);
	int otHM = otHour * 60 + otMin;
	
	double per = Math.round((otHM/hour12) * 10000)/100.0;
	
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
    	var per = <%=per%>;
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
            <span class="La">출근시간</span>
            <span id="startTime"><%=wtMap2.get(0) %></span> <br>    <!--로직짜야됨--> 
            <span class="La">퇴근시간</span>
            <span id="endTime"><%=wtMap2.get(1) %></span> <br>    <!--로직짜야됨--> 

			<% if(wtMap2.get(0).equals("등록전")){ %>
            	<button id="startBtn" class="btn">출근 등록</button>
           	<%} else { %>
           		<button id="startBtn" class="btn" disabled>출근 등록</button>
       		<%} %>
            <% if(!wtMap2.get(0).equals("등록전")){ %>
            	<button id="endBtn" class="btn">퇴근 등록</button>
            <%}else { %>
            	<button id="endBtn" class="btn" disabled>퇴근 등록</button>
            <%} %>
            <button id="vacationBtn" class="btn">휴무 신청</button>
            <button id="checkId" class="btn">결재 확인</button>
        </div>

        <div id="area2" class="area2">
        	<fieldset id="area2Field">
        		<legend>&nbsp;&nbsp;이번달 근무 현황&nbsp;&nbsp;</legend>
        		<span class="La2">총 근무일</span>	<span id="" class="La2Value"><%= workdayCount %> 일</span> <br><br>
        		<span class="La2">지각 횟수</span>	<span id="" class="La2Value"><%= lateCount %> 회</span> <br><br>
        		<span class="La2">결근 횟수</span>	<span id="" class="La2Value"><%= absentCount %> 회</span> <br><br><br>
        		
        		<span class="La2b">휴무 예정일</span> <span id="" class="La2Valueb">XX일/XX일/XX일</span> <br><br>
        	</fieldset>
        	<fieldset id="area2Field2">
        		<br>
        		<legend>&nbsp;&nbsp;이번주 추가 근무 현황&nbsp;&nbsp;</legend>
        		<span class="La3">총 추가 근무 시간</span>	<span id="" class="La3Value"><%=otH %>시간 <%=otM %>분</span> <br><br><br>
				<div class="progress"><div class="progressBar"></div><%=per%>%</div>
				<span class="La4Value">12시간 中  <%=per %>%</span>
        	</fieldset>
        </div>

    </div>



</body>
</html>