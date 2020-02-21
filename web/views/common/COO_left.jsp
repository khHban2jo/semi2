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
		<img src="/semi/resources/empProfiles/<%=m.getProfileA() %>" class="user_icon">
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
			이달의 업무 내용
		</h3>
	</div>
	<!-- <div id="todo_date"></div> -->
	
	<div id="todo_list">
	
	<div id="todo_list_range"></div> <!-- 일정이 쓰이는 범위 -->	
	
	</div>
</div>
<script>
	/* $('#cla').load("../views/Calendar.jsp #todolistArea"); */
</script>



<script>
/* <body onresize="parent.resizeTo(480,580)" onload="parent.resizeTo(480,580)"> */
	//mypageBtn
	function popup(obj){
		/* console.dir(obj); */
		window.open("/semi/selectOne.do?cno="+obj.value,"","width=480,height=580,left=600");
	}
	
	$(function(){
		//$('#notice').load('./notice/notice.jsp','#notice');
	
		$.ajax({
			url:"/semi/selectCalendar.do", // 비동기처리(ajax) --> 기능이 구현되어있는 Servlet을 호출,또는 특정 페이지 선택
			type:"get",// 데이터 전송 방식(get/post)
			//,data:{userId : $('#userid').val()}, // 보내는 페이지에 전달값이 있으면 data속성에 넣어서 위의 url주소로 같이 전달
			success:function(data){ // 요청한 페이지에서 기능을 실행하고 성공했을 때 
				console.log(data); // data[0]--> list 1개
				$.each(data,function(index,value){
					var $cUl = $('<ul>');
					var $ctitle = $("<li class='detailTodo' value='"+value.cno+"' onclick='popup(this);'>").text(value.title);
					
					$cUl.append($ctitle);
					$('#todo_list_range').append($cUl);
				});
			
				
			},error:function(){
				console.log("에러");
			}
			
		});
	});
</script>