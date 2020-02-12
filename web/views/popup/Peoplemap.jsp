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
</head>
<body>
	<!-- 조직도 테이블  -->
	<div>
		<table class="table" style="width: 100%;" align="center" id="listmap">

			<tr>

				<th>사원번호</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
				<th>이메일</th>
			</tr>


			<%
				for (Member m : list) {
			%>

			<tr>
				<th><%=m.getEmpCode()%></th>
				<th><%=m.getDeptCode()%></th>
				<th><%=m.getJobCode()%></th>
				<th><%=m.getEmpName()%></th>
				<th><%=m.getEmail()%></th>
			</tr>
			<%
				}
			%>


		</table>

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

			<hr style="width: 370px;">
			<div class="searchmap" align="center">
				<select id="searchCondition" name="searchCondition" style="width: 70px; height: 23px;">
					<option value="">----</option>
					<option value="jobName">직급</option>
					<option value="empName">이름</option>
					<option value="deptTitle">부서</option>
				</select> 
				<input type="search" id="keyword" placeholder="검색어를 입력하세요">
				<button type="button" onclick="search();" >검색</button>
			</div>
		</div>

		<!--  검색 키워드 찾아오는 펑션 	 -->
		<script>
			function search(){
				location.href="<%=request.getContextPath()%>/PSearch.ps?con="+$('#searchCondition').val()+"&keyword="+$('#keyword').val();
			}
		</script>
</body>
</html>