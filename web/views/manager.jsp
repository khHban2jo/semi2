<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 관리자</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
    <link rel="stylesheet" href="/semi/resources/css/manager/manageView.css">
</head>
<!-- style="overflow:hidden;" -->
<body style="background: white;">
<div class="total">
    <!-- 헤더부분 include -->
	<%@ include file="common/COO_header.jsp" %>
	
	<!-- 화면 좌측 고정부 include -->
	<%@ include file="common/COO_left.jsp" %>


	<div class="right" id="area">
	
		<br>&nbsp;
		<%if(m.getEmpId().equals("admin")){ %>
		  <button id="iEmp" style="width:100px; height:40px;">사원ID생성</button>
		  <button id="uEmp" style="width:100px; height:40px;">사원정보수정</button>
		  <button id="dEmp" style="width:100px; height:40px;">사원삭제</button>
		 <%}else{ 
		 	 
		   }
			%>
		  <hr id="start">
		   
		<!-- <script src="/semi/resources/js/manager/loginPage.js"></script> -->
	
	</div>
    <!-- 풋터 부분 include -->
	<%@ include file="common/COO_footer.jsp" %>
</div>
   
<script>
	var option ="top=80px,left=300px,width=1200px,height=800px,location=no,resizable=no,toolbars=no";
	var name = $(this).text();

	$('#iEmp').click(function(name){
		var url = "<%=request.getContextPath() %>/views/manager/join.jsp";
		window.open(url,name,option);
	});
	
	$('#uEmp').click(function(name){
		var url = "<%=request.getContextPath() %>/views/manager/modifyEmp.jsp";
		window.open(url,name,option);
	});
	$('#dEmp').click(function(name){
		var url = "<%=request.getContextPath() %>/views/manager/deleteEmp.jsp";
		window.open(url,name,option); 
	});
</script>

</body>
</html>