<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.coo.pmap.model.vo.*"%>
	
<%-- <% ArrayList<Pmap> list = (ArrayList<Pmap>)request.getAttribute("list"); %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>조직도</title>
<!--  <script src="/semi/resources/JS/jquery-3.4.1.min.js"></script> -->

<link rel="stylesheet"
	href="/semi/resources/css/dept_chart/dept_chart_css.css" />
<script src="/semi/resources/js/dept_chart/dept_chart_js.js"></script>
</head>
<body>

	<h2>조직도</h2>

	<hr>
	<div id="team" align="center">

		<input type="button" id="all" value="전체조회"
			style="position: absolute; top: 10px; left: 320px; background: black; color: white;"
			onclick="location.href='/semi/views/popup/Peoplemap.jsp'">
		
	   <input type="button" id="top1" value="사장"
			style="position: absolute; top: 30px; left: 170px; background: lightblue">

		<input type="button" value="부사장"
			style="position: absolute; top: 70px; left: 170px; background: lightcyan">

		<input type="button" value="총무부"
			style="position: absolute; top: 110px; left: 10px; background: lightslategray">

		<input type="button" value="영업부"
			style="position: absolute; top: 110px; left: 170px; background: lightslategray">

		<input type="button" value="인사부"
			style="position: absolute; top: 110px; left: 320px; background: lightslategray">

		<input type="button" value="영업 1팀"
			style="position: absolute; top: 160px; left: 120px; background: lightslategray">

		<input type="button" value="영업 2팀"
			style="position: absolute; top: 160px; left: 220px; background: lightslategray">
	</div>

	<%--  <div id="tableview" align="center">
		<table class="table" style="width: 100%;">
			<tr>

				<th>사원번호</th>
				<th>부서</th>
				<th>직급</th>
				<th>이름</th>
				<th>이메일</th>
			</tr>
			
			<% for(Pmap p : list){ %>

			<tr>
				<th><%=p.getEmp_code() %></th>
				<th><%=p.getJob() %></th>
				<th><%=p.getDept() %></th>
				<th><%=p.getEmp_name() %></th>
				<th><%=p.getEmail() %></th>
			</tr>
			<% } %>


		</table>
		<hr style="width: 370px;">

		<select style="width: 50px; height: 30px;">
			<option value="부서코드">부서코드</option>
			<option value="이름">이름</option>
		</select> <input class="form-control" type="text" id="keyword" name="keyword"
			placeholder="검색어를 입력하세요">
		<button id="btn">검색</button>
	</div> --%>

</body>
</html>