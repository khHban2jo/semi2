<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 근태관리</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <!-- css Link -->
    <link rel="stylesheet" href="/semi/resources/css/TA/TAcss.css">
    
    <script src="/semi/resources/js/TA/TAscript.js"></script>
</head>
<body>
    <div id="area">
        <div id="area1">
            <div id="day"></div>
            <div id="time"></div>
            <hr>
            <span class="start">출근시간</span>
            <span id="start">08 : 50</span> <br>    <!--로직짜야됨--> 
            <span class="start">퇴근시간</span>
            <span id="end">18 : 10</span> <br>    <!--로직짜야됨--> 

            <button id="startBtn" class="btn">출근</button>
            <button id="endBtn" class="btn">퇴근</button>
            <button id="vacationBtn" class="btn">휴무신청</button>
            <button id="checkId" class="btn">결재확인</button>
        </div>

        <div id="blankArea" class="changeArea"></div>

    </div>



</body>
</html>