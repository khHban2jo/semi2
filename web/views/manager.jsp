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
    
    
    
    <style>
        .div{
            border-radius: 10px;
        }
    </style>
<script>
   $('#emp').click(function(){
		console.log("으앙");
    });
	function showId(value){
		
		switch(value){
		 case "1":$('#start').load("<%=request.getContextPath() %>/views/manager/join.jsp"); break;
		 case "2":$('#start').load("<%=request.getContextPath() %>/views/manager/modifyEMP.jsp"); break;
		 case "3":$('#start').load("<%=request.getContextPath() %>/views/manager/deleteEMP.jsp"); break;
		}
	}
</script>
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
		  <button value="1" id="userId" style="width: 100px; height: 40px;" onclick="showId(this.value);">사원ID생성</button>
		  <button value="2" id="pwd"style="width: 100px; height: 40px;" onclick="showId(this.value);">사원정보수정</button>
		  <button value="3" id="deleteId" style="width: 100px; height: 40px;" onclick="showId(this.value);">사원삭제</button>
		 <%}else{ 
		 	 
		   }
			%>
		  <hr id="start">
		   
		<!-- <script src="/semi/resources/js/manager/loginPage.js"></script> -->
	
	</div>
    <!-- 풋터 부분 include -->
	<%@ include file="common/COO_footer.jsp" %>
</div>


</body>
</html>