<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"%>
<% Member md = (Member)request.getAttribute("searchResult"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연봉 수정</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<h1>사원정보</h1>
	<table border="1" style="width:100%; height:100px; text-align:center;">
		<thead><tr>
		<th>사원ID</th>
		<th>사번</th>
		<th>이름</th>
		<th>직급</th>
		<th>부서</th>
		<th>etc</th>
		<th>이전의 연봉</th>
		</tr></thead>
		<tbody>
		<tr>
		<td><%=md.getEmpId() %></td>
		<td><%=md.getEmpCode() %></td>
		<td><%=md.getEmpName() %></td>
		<td><%=md.getJobName() %></td>
		<td><%=md.getDeptTitle() %></td>
		<td><%=md.getEtc() %></td>
		<td><%=md.getSalary() %></td>
		</tr>
		</tbody>
	</table>
	<form action="<%=request.getContextPath() %>/updateSalary.me" method="post">
		<input type="hidden" value="<%=md.getEmpId() %>" name="userId">
		연봉 변경 : <input id="sel" type="number" name="salary" value="<%=md.getSalary() %>" step="1000000"><br><br>
		<input type="submit" value="작성">&nbsp;&nbsp;<input type="button" value="돌아가기" id="goback">
	</form>
	<script>
		$('#goback').click(function(){
			window.close();
		});
		onsubmit=function(){
			var sel = $('#sel').val();
			
			var chk = window.confirm("연봉 : " + $('#sel').val()+"맞습니까?");
			
			if(chk.toUpperCase()=='Y'){
				return true;
			}else{
				return false;
			}
			
		}
	</script>
</body>
</html>