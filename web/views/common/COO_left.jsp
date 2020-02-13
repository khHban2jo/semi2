<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"%>
    
<% Member m = (Member)session.getAttribute("member"); %>
    <!-- 달력 -->
    <!-- // jQuery UI CSS파일  -->
    <link rel="stylesheet" href="/semi/resources/css/common/jquery-ui.css" />  
    <link rel="stylesheet" href="/semi/resources/css/common/jquery-ui2.css" />  
    <!-- // jQuery 기본 js파일 -->
    <script src="/semi/resources/js/common/calendar.js"></script>  
    <!-- // jQuery UI 라이브러리 js파일 -->
    <script src="/semi/resources/js/common/calendar2.js"></script>
    <!-- 왼쪽 메뉴 쿼리 -->
    <script src="/semi/resources/js/common/leftmenu.js?v=<%=System.currentTimeMillis() %>"></script>
	
	<div class="left">
    
    <div class="user">
        <img src="/semi/resources/image/user_icon.png" class="user_icon">
        <span id="user_name"><b><%=m.getEmpName() %></b></span> 
        <br>
        <b id="user_dept"><%=m.getDeptTitle() %></b> <b id="user_job"><%=m.getJobName() %></b> 
        <br><br><br><br>
        <button id="btn1" class="btn">전자결재</button>
        <button id="btn2" class="btn">근태관리</button>
        <button id="btn3" class="btn">로그아웃</button>
    </div>
    <div class="nav">
        <button id="documentsBtn" class="btn_nav"><img src="/semi/resources/image/documents.svg"><br>결재목록</button>
        <button id="noticeBtn" class="btn_nav"><img src="/semi/resources/image/info-fill.svg"><br>공지사항</button>
        <button id="listBtn" class="btn_nav"><img src="/semi/resources/image/list-ul.svg"><br><br>게시판</button>
        <button id="mypageBtn" class="btn_nav"><img src="/semi/resources/image/date.svg"><br>일정관리</button>
        <button id="jojicBtn" class="btn_nav"><img src="/semi/resources/image/people-fill.svg"><br>조직도</button>
        <button id="managerBtn" class="btn_nav"><img src="/semi/resources/image/envelope-fill.svg"><br>메일</button>
    </div>
    
    <div class="calendarArea">
        <div id="datepicker">
        </div>
    </div>
</div>