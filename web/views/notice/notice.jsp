<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.coo.notice.model.vo.*"%>
<!-- 들어 가면 리스트 구현을 해야 된다. -->
<% 
	ArrayList<Notice> noticeList = (ArrayList<Notice>)request.getAttribute("noticeList"); 
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
	String search = request.getParameter("search");
	String keyword = "";
	
	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");
	
	
	if(search.equals("all")){
		request.setAttribute("keyword", "");
	}else{
		keyword = request.getParameter("keyword");
	}
	
	System.out.println("search : "+search + ", keyword : "+ keyword);
	System.out.println("date1 : "+date1 + ", date2 : "+ date2);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>COO - 공지사항</title>

<link rel="stylesheet" href="/semi/resources/css/common/basic.css">
<link rel="stylesheet" href="/semi/resources/css/notice/button.css">
<link rel="stylesheet" href="/semi/resources/css/notice/margin.css">
<link rel="stylesheet" href="/semi/resources/css/notice/table.css">

</head>
<body>
	<div class="total">
		<!-- 헤더부분 include -->
		<%@ include file="../common/COO_header.jsp"%>

		<!-- 화면 좌측 고정부 include -->
		<%@ include file="../common/COO_left.jsp"%>

		<div class="right">
			<!-- 게시판 시작 -->
			<div class="margin-list-head">
				<h1 align="left">공지사항</h1>
				<!-- 파라미터 값 저장  -->
				<input type="hidden" id = "searchParameterValue" value = <%= search%> >
				<input type="hidden" id = "keywordParameterValue" value = <%= keyword%> >
				<input type="hidden" id = "date1Value" value = <%= date1%> >
				<input type="hidden" id = "date2Value" value = <%= date2%> >
				
				<hr color="lightgray" class="table-line">
				<br>
				<br>
				<!-- 홍석코드 -->
<!-- 				&nbsp; <label>분류</label> <select id="searchType" name="searchType">
					로그인한 사용자에 대한 권한과 부서등에 따라서 alert등으로 접근 금지를 설정 한다. -
					<option>전체</option>
					<option>공지사항</option>
					<option>인사명령</option>
				</select> &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; -->
				
				<!-- 안 될것 같으면 변경 및 삭제 -->
				<label>기 간 설 정</label> <input type="date" id="time1"> ~ <input type="date" id="time2">&nbsp;
				<!-- <select id="showNumber" style="float: right;">
                    <option></option>
                </select> -->
				<hr class="table-line" style="margin-left: -0px;">
				<div class="table-line">
					<table style="width: 100%; border-collapse: collapse;" id="list">
						<tr class='table-line'>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
						</tr>
						<% for(Notice n : noticeList){ %>
						<tr align="center" class='table-line'>
							<td><%= n.getNno() %></td>
							<td><%= n.getNtitle() %></td>
							<td><%= n.getNwriter() %></td>
							<td><%= n.getNdate() %></td>
							<td><%= n.getNcount() %></td>
						</tr>
						<% } %>
					</table>
					<%
                    	if(m.getEmpId().equals("admin")){
                    %>
					<button
						onclick="location.href='<%= request.getContextPath() %>/views/notice/noticeInsert.jsp' "
						id="write" class="btn btn-light" style="margin-left: -10px;">
						글쓰기</button>
					<%
                    	}
                    %>

					<br>
					<div>
						<select id="search" name="search" style="height: 30px; margin-left: 300px;">
							<option value="all">전체 보기</option>
							<option value="title">제목</option>
							<option value="content">내용</option>							
						</select>&nbsp; 
						<input class="form-control" type="text" id="keyword"
							name="keywords" placeholder="검색어를 입력하세요" style="width: 200px;" value=<%=keyword%> >

						<button type="button" onclick="search();">검색하기</button>
						
						<%-- 페이지 처리 --%>
						<div class="pagingArea" align="center">
							<button onclick="location.href='/semi/noticeListServlet?currentPage=1'+show(); "> << </button>
							<%  if(currentPage <= 1){  %>
							<button disabled> < </button>
							<%  }else{ %>
							<button onclick="location.href='/semi/noticeListServlet?currentPage=<%=currentPage - 1 %>'+show(); "> < </button>
								<%  } %>

								<% for(int p = startPage; p <= endPage; p++){
									if(p == currentPage){	
								%>
								<button disabled><%= p %></button>
								<%      }else{ %>
								<button onclick=
								"location.href='/semi/noticeListServlet?currentPage=<%= p %>'+show(); ">
									<%= p %>
								</button>
								<%      } %>
								<% } %>

								<%  if(currentPage >= maxPage){  %>
								<button disabled>></button>
								<%  }else{ %>
								<button onclick="location.href='/semi/noticeListServlet?currentPage=<%=currentPage + 1 %>'+show(); "> > </button>
								<%  } %>
								<button onclick="location.href='/semi/noticeListServlet?currentPage=<%= maxPage %>'+show(); "> >> </button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 풋터 부분 include -->
		<%@ include file="../common/COO_footer.jsp"%>
	</div>

	<!-- 시간이 된다면 자바스크립드로 바꿀것 -->
<script>

$(function(){
	
	$("#list tr").mouseenter(function(){
		if($(this).children().eq(1).text() != '번호'){
			$(this).css({"background":"snow", "cursor":"pointer"});
		}
	}).mouseout(function(){
		$(this).css({"background":"white"});
	}).click(function(){
		var nno = $(this).children().eq(1).text()
		console.log($(this).children().eq(1).text());
		if(!nno == '번호'){			
			location.href="<%=request.getContextPath()%>/noticeSelectOn?nno=" + nno;
		}	
	});

});

	function show(){
		console.log(document.getElementById('search').value+'&keyword='+document.getElementById('keyword').value);
		return '&search='+document.getElementById('searchParameterValue').value
				+'&keyword='+document.getElementById('keywordParameterValue').value
				+"&date1="+document.getElementById('date1Value').value
				+"&date2="+document.getElementById('date2Value').value;
	}
	
	function search(){
		
		var date1 = document.getElementById('time1').value;
		var date2 = document.getElementById('time2').value;
		
		if(date1 > date2){
			alert("날짜가 잘못 입력 되었습니다. 다시 입력 해주세요.");
			return false;	
		}else if( (date1.length <= 0 && date2.length > 0) ||  (date1.length > 0 && date2.length <= 0) ){
			alert("날짜가 잘못 입력 되었습니다. 다시 입력 해주세요.");
			return false;	
		}
		
		location.href="<%=request.getContextPath()%>/noticeListServlet?"
													+"search="+document.getElementById('search').value
													+"&keyword="+document.getElementById('keyword').value
													+"&date1="+date1+"&date2="+date2;
	} 

</script>


</body>
</html>