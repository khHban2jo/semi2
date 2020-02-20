<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"%>
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
		  <button id="iEmp" value="1" style="width:100px; height:40px;">사원ID생성</button>
		  <button id="uEmp" value="2" style="width:100px; height:40px;">사원정보수정</button>
		  <button id="dEmp" value="3" style="width:100px; height:40px;">사원삭제</button>
		  <button id="sEmp" value="4" style="width:100px; height:40px;">연봉수정</button>
		  <button id="upEmp" value="5" style="width:100px; height:40px;">사진업로드</button>
		

   
<script>
    
	var option ="top=20px,left=700px,width=1280px,height=1000px,location=no,resizable=no,toolbars=no,scrollbars=yes";
	$('#iEmp,#uEmp,#dEmp,#sEmp,#upEmp').click(function(){
	var btnDen = $(this).val();
	var name = $(this).text();
    var url ="<%=request.getContextPath() %>/checkAdmin.me?btnDen="+btnDen;
    window.open(url,name,option);
    
	});
</script>
 <%} %> 
    <hr id="start">
		   
	
	</div>
    <!-- 풋터 부분 include -->
	<%@ include file="common/COO_footer.jsp" %>
</div>

</body>
</html>