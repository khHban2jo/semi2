<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>COO - 일정관리</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
    <script src="/semi/resources/js/ccalendar/jquery.datetimepicker.full.min.js"></script>
    <script src="/semi/resources/js/ccalendar/jquery.datetimepicker.js"></script>


    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <link href="/semi/resources/css/ccalendar/main2.css" rel="stylesheet" />
    <link href="/semi/resources/css/ccalendar/main.css" rel="stylesheet" />
    <script src="/semi/resources/js/ccalendar/main3.js"></script>
    <script src="/semi/resources/js/ccalendar/main2.js"></script>
    <script src="/semi/resources/js/ccalendar/main.js"></script>
    <script src="/semi/resources/js/ccalendar/editEvent.js"></script>
    <script src="/semi/resources/js/ccalendar/addEvent.js"></script>
    <script src="/semi/resources/js/ccalendar/etcSetting.js"></script>
    
    
    <!-- 추가 js / css -->
    <script src="/semi/resources/js/ccalendar/js1.js"></script>
	<link href="/semi/resources/css/ccalendar/css1.css" rel="stylesheet" />

</head>

<body>
    <div class="total">
        <!-- 헤더부분 include -->
    	<%@ include file="common/COO_header.jsp" %>
    	
    	<!-- 화면 좌측 고정부 include -->
    	<%@ include file="common/COO_left.jsp" %>


        <div class="right">

            <div id="calendar"></div>

            <div id="todolistArea">
                <h3 id="todo_date">2020년 01월 21일 </h3>
                <div id="todo_list">
                    <ul>
                        <li>January 01 All Day Event </li>
                        <li>January 07 ~ 09 Long Event</li>
                        <li>January 11 ~ 12 Conference </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 풋터 부분 include -->
        <%@ include file="common/COO_footer.jsp" %>
</div>
</body>

</html>