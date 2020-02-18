<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.coo.member.model.vo.*,com.coo.ccalendar.model.vo.*,java.util.ArrayList"%>

<% CCalendar c = (CCalendar)request.getAttribute("CCalendar"); %>

<% Member m = (Member)session.getAttribute("member"); %>
<%
	/* ArrayList<CCalendar> list = (ArrayList<CCalendar>) request.getAttribute("list"); */

%>




<!-- 달력 -->
<!-- // jQuery UI CSS파일  -->
<link rel="stylesheet" href="/semi/resources/css/common/jquery-ui.css" />
<link rel="stylesheet" href="/semi/resources/css/common/jquery-ui2.css" />
<!-- // jQuery 기본 js파일 -->
<script src="/semi/resources/js/common/calendar.js"></script>
<!-- // jQuery UI 라이브러리 js파일 -->
<script src="/semi/resources/js/common/calendar2.js"></script>
<!-- 왼쪽 메뉴 쿼리 -->
<script
	src="/semi/resources/js/common/leftmenu.js?v=<%=System.currentTimeMillis() %>"></script>

<div class="left">

	<div class="user">
		<img src="/semi/resources/image/user_icon.png" class="user_icon">
		<span id="user_name"><b><%=m.getEmpName() %></b></span> <br> <b
			id="user_dept"><%=m.getDeptTitle() %></b> <b id="user_job"><%=m.getJobName() %></b>
		<br> <br> <br> <br>
		<button id="btn1" class="btn">전자결재</button>
		<button id="btn2" class="btn">근태관리</button>
		<button id="btn3" class="btn">로그아웃</button>
	</div>
	<div class="nav">
		<button id="documentsBtn" class="btn_nav">
			<img src="/semi/resources/image/documents.svg"><br>결재목록
		</button>
		<button id="noticeBtn" class="btn_nav">
			<img src="/semi/resources/image/info-fill.svg"><br>공지사항
		</button>
		<button id="listBtn" class="btn_nav">
			<img src="/semi/resources/image/list-ul.svg"><br> <br>게시판
		</button>
		<button id="calendarAddBtn" class="btn_nav">
			<img src="/semi/resources/image/date.svg"><br>일정추가
		</button>
		<button id="jojicBtn" class="btn_nav">
			<img src="/semi/resources/image/people-fill.svg"><br>조직도
		</button>
		<button id="managerBtn" class="btn_nav">
			<img src="/semi/resources/image/envelope-fill.svg"><br>메일
		</button>
	</div>







	<div class="calendarArea" id="cla">
		<h3 align="center">
			<%-- <%=c.getStartDate()%> --%>
			일의 업무
		</h3>
	</div>
	<!-- <div id="todo_date"></div> -->
	<div id="todo_list">
		<!-- <button id="cal_edit">수정</button> -->
		
	</div>




	<!-- <div class="calendarArea" id="cla">
		<div id="todo_date">
			<h3 align="center">YYYY년 MM DD일의 업무 내용</h3>
				<div id="todo_list">
	
				</div>
				<div id="todolistArea"></div>
		</div>
	
	</div>-->
</div>
<script>
	/* $('#cla').load("../views/Calendar.jsp #todolistArea"); */
	
	function name() {
		
	}
</script>



<script>
	$(function(){
		//$('#notice').load('./notice/notice.jsp','#notice');
		$.ajax({
			url:"/semi/selectCalendar.do",
			type:"get",
			success:function(data){
				console.log(data);
				$.each(data,function(index,value){
					var $cUl = $('<ul>');
					var $ctitle = $('<li>').text(value.title);
					
					$cUl.append($ctitle);
					$('#todo_list').append($cUl);
				});
			},error:function(){
				console.log("에러");
			}
		});
	});
</script>