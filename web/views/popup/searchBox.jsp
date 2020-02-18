<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사번 검색</title>
<style>
	div{
		display:inline-block;
	}
</style>
</head>
<body>
<h1>사번검색(숫자입력)</h1>
<div>
<input type="text" placeholder="사번입력" name="searchEmpCode" id="secr">&nbsp;&nbsp;<input type="button" id="sec" value="검색">
</div>
<script>
	window.resizeTo(500,300);
	
	$('#sec').click(function(){
		location.href="<%=request.getContextPath() %>/searchEmpCode.me";
	});
</script>
</body>
</html>