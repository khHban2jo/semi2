<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String exception = (String)request.getAttribute("msg"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error!</title>
</head>
<body>
	<hr>
	<h1><%=exception %>관리자에게 문의하세요</h1>
	<hr>
</body>
</html>