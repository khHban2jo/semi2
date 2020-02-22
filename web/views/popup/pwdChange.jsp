<%@page import="com.coo.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Member m = (Member) session.getAttribute("member");
%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>COO - 비밀번호 변경</title>

<link rel="stylesheet"
	href="/semi/resources/css/pwdChange/pwdChangeCss.css">
<script src="/semi/resources/js/pwdChange/pwdChange.js"></script>
<style>

/* header{
    		background-color : #A9D0F5;    		    		
    	} */
/* table{
    		border : 1px solid black;
    	} */
th, td {
	border: 0px solid black;
	padding: 10px;
}
//
onsubmit






="
return



 



submit2






();"
</style>
</head>
<body>
	<div class="totalArea">
		<form method="post" action="/semi/changePwd.me" id='formf'>
			<fieldset class="field1">
				<legend>회원 정보</legend>
				<ul>
					<li>아이디 : <br> <input type="text" id="userId"
						name="userId" class="text">
					</li>
					<br>
					<li>비밀번호 : <br> <input type="password" id="userPwd"
						name="userPwd" class="text">
					</li>
				</ul>

			</fieldset>
			<br>
			<fieldset class="filed2">
				<legend>비밀번호 수정</legend>
				<ul>
					<li>비밀번호 : <br> <input type="password" id="changePwd1"
						name="changePwd1" class="text" minlength="8" maxlength="12">
					</li>
					<br>
					<li>비밀번호 확인 : <br> <input type="password" id="changePwd2"
						class="text" minlength="8" maxlength="12">
					</li>
				</ul>
			</fieldset>
		</form>
	</div>

	<input type="button" value="변경" id="submitBtn" style="background-color: #A9D0F5; color: white;">
	<!-- <button id="submitBtn" style="background-color: #A9D0F5; color: white;">변경</button> -->
	<button id="cancelBtn" onclick="cancel();" style="color: black;">취소</button>
	<br>
	<br>
	<br>

	<script>
     $("#submitBtn").click(function(){
          		console.log("ddd");     
          			
          		var Id = document.getElementById('userId').value;
          		var userPwd = document.getElementById('userPwd').value;
          		var changePwd1 = document.getElementById('changePwd1').value;
          		var changePwd2 = document.getElementById('changePwd2').value;
          		
     		if(changePwd1 == changePwd2){
          		$.ajax({
          			url:"/semi/changePwd.me",
          			type :"get",			
          			data:{ 
          				userId : Id,
          				userPwd : userPwd,
          				changePwd1 : changePwd1
          			},success:function(data){
          				alert("비밀번호가 변경되었습니다.");
          			},error:function(){
          				}
          			});
     		}else{
     			alert("비밀번호가 일치하지 않습니다.");
     		}     
     		
  });	
          		      		
  </script>
</body>
</html>