<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.coo.pmap.model.vo.*"%>
    
<% ArrayList<Pmap> list = (ArrayList<Pmap>)request.getAttribute("list"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 조직도</title>
<script src="/semi/resources/JS/jquery-3.4.1.min.js"></script>

<!--  <link rel="stylesheet"
	href="/semi/resources/css/dept_chart/dept_chart_css.css" />  -->
<script src="/semi/resources/js/dept_chart/dept_chart_js.js"></script>
</head>
<body>
	
		<table class="table" style="width: 100%;" align="center">
			
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
				<th><%=p.getEmp_name() %></th>
				<th><%=p.getEmail() %></th>
				<th><%=p.getJob_code() %></th>
				<th><%=p.getDept_code() %></th>
			</tr>
			<% } %> 
			

		</table>
		<hr style="width: 370px;">
		<div align="center">
		<select style="width: 70px; height: 30px;">
			<option value="부서이름">부서</option>
			<option value="이름">이름</option>
			<option value="직급">직급</option>
		</select> <input class="form-control" type="text" id="keyword" name="keyword"
			placeholder="검색어를 입력하세요" >
		<button id="btn">검색</button>
		</div>

</body>
</html>