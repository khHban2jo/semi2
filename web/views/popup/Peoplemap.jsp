<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.coo.member.model.vo.*,com.coo.pmap.model.vo.*"%>

<%
	ArrayList<Member> list = (ArrayList<Member>) request.getAttribute("list");
	
	PmapInfo pa = (PmapInfo)request.getAttribute("pa");
	int listCount = pa.getListCount();
	int currentPage = pa.getCurrentPage();
	int maxPage = pa.getMaxPage();
	int startPage = pa.getStartPage();
	int endPage = pa.getEndPage();
	Member mem = (Member)session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 조직도</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>

<!--  <link rel="stylesheet"
	href="/semi/resources/css/dept_chart/dept_chart_css.css" />  -->
<script src="/semi/resources/js/dept_chart/dept_chart_js.js"></script>
<style>
	
	
	 th, td {
    border-bottom: 1px solid black;
    padding: 10px;
  		}
  
  thead tr {
  	background-color : #A9D0F5;
  }
  
   tbody tr:nth-child(2n) {
    background-color: #F3F3F2;
  }
 
</style>
</head>
<!-- 창 크기 조절  -->
<body onresize="parent.resizeTo(650,800)" onload="parent.resizeTo(600,800)"> 

	
	
	<h4 color="#A9D0F5">사원 검색</h4>

	<hr color="#A9D0F5">
	<div class="searchmap" align="center" border="1px soild lightblue">
				<select id="searchCondition" name="searchCondition" style="width: 70px; height: 23px;">
					<option value="">선택</option>
					<option value="jobName">직급</option>
					<option value="empName">이름</option>
					<option value="deptTitle">부서</option>
				</select> 
				<input type="search" id="keyword" placeholder="검색어를 입력하세요">
				<button type="button" onclick="search();" >검색</button>
	</div>

	<br><Br>



	<!-- 조직도 테이블  -->
	<div>
		<table class="table" style="width: 100%;" align="center" id="listmap">
		<thead>
			<tr>

				<th>사원번호</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
				<th>이메일</th>
			</tr>
			
		</thead>
		
		<tbody>
			<%
				for (Member m : list) {
			%>

			<tr id="po">
			<input type="hidden" name="eSearch" value="<%=m.getEmpId() %>">
				<th><%=m.getEmpCode()%></th>
				<th><%=m.getDeptCode()%></th>
				<th><%=m.getJobCode()%></th>
				<th><%=m.getEmpName()%></th>
				<th><%=m.getEmail()%></th>
			</tr>
			
			<%
				}
			%>
		</tbody>

		</table>
		<br>
		
		<!-- 페이지 처리  -->
		
		<div>
			<div class="pagingArea" align="center">
				<button
					onclick="location.href='<%=request.getContextPath()%>/pAll.do?currentPage=1'"><<</button>
				<%
					if (currentPage <= 1) {
				%>
				<button disabled><</button>
				<%
					} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/pAll.do?currentPage=<%=currentPage - 1%>'"><</button>
				<%
					}
				%>

				<%
					for (int p = startPage; p <= endPage; p++) {
						if (p == currentPage) {
				%>
				<button disabled><%=p%></button>
				<%
					} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/pAll.do?currentPage=<%=p%>'"><%=p%></button>
				<%
					}
				%>
				<%
					}
				%>

				<%
					if (currentPage >= maxPage) {
				%>
				<button disabled>></button>
				<%
					} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/pAll.do?currentPage=<%=currentPage + 1%>'">></button>
				<%
					}
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/pAll.do?currentPage=<%=maxPage%>'">>></button>
			</div>

			<!-- 검색  -->

			
			
		</div>
		
		<!--  검색 키워드 찾아오는 펑션 	 -->
		<script>
			function search(){
				location.href="<%=request.getContextPath()%>/PSearch.ps?con="+$('#searchCondition').val()+"&keyword="+$('#keyword').val();
			}
			$('#po th').mouseenter(function(){
					$(this).parent().css({"cursor":"pointer"});
			}).click(function(){
					var eSearch = $(this).parent().find('input').val();
					if(document.referrer=="http://localhost:9999/semi/checkAdmin.me?btnDen=1"){
					   $.ajax({
						   
					   });
					}else{
					location.href="<%=request.getContextPath() %>/empSearch.me?eSearch="+eSearch;
					}
			});
		</script>
</body>
</html>