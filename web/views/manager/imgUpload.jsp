<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"%>
<% Member m = (Member)request.getAttribute("searchResult"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 파일 업로드</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<h1>10MB 이하의 사진 업로드</h1>
	<form action="<%= request.getContextPath() %>/mUploadPic.me" 
			      method="post" enctype="multipart/form-data" onsubmit="return chk();">
	<input type="file" name="file" id="file" />
	<br><br>
	<img id="image_section" src="#" alt="your image"/>
	<br><br>
	<input type="hidden" value="<%=m.getEmpId() %>" name="userId">
	<input type="hidden" value="<%=m.getEmpCode() %>" name="empCode">
	<input type="submit" value="업로드">&nbsp;&nbsp;<input type="button" value="취소" id="goback">
	</form>
	<script>
	function readURL(input) {
		 if (input.files && input.files[0]) {
		  var reader = new FileReader();
		  
		  reader.onload = function (e) {
		   $('#image_section').attr('src', e.target.result);  
		  }
		  
		  reader.readAsDataURL(input.files[0]);
		  }
		}
		  
		$("#file").change(function(){
		   readURL(this);
		});
	$('#goback').click(function(){
		window.close();
	});
	function chk(){
		var d = $('#file').val();		
		if(!d){
			alert("사진을 선택해주세요"); 
			return false; 
		}else{
			return true;
		}
	}
	</script>
</body>
</html>