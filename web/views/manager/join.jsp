<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="UTF-8">
  <link rel="stylesheet" href="/semi/resources/css/manager/manageView.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  </head>
  <body>  
 <form action="<%=request.getContextPath() %>/mInsert.me" method="POST">
		      <table border="1" id ="change1" class="managerTable">
		       
		       <thead><tr><th class="cap">기본정보입력</th></tr></thead>
		            
		              <tbody><tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" id="mEmpCode" style="width: 200px;" disabled>&nbsp; <input type="button" value="확인" id="checkemp">	   
		                  <!-- 사진 -->
		                  <td rowspan="8" style="width: 270px; height: 270px;"> 
		                      <img src="" width="320px" height="320px" id="Show" alt="프로필사진"> 
		                  </td>
		              </tr>
		              <tr>
		                  <td> 아이디  </td>
		                  <td> 
		                      <input type="text" id="userId" maxlength="20" style="width: 200px;" readonly placeholder="영어이름 먼저입력"> 
		                      <input type="button" id="checkId" value="중복확인">
		                  </td>
		              </tr>
		              <tr>
		                  <td> 비밀번호 </td> <td><input type="password" id="userPwd" style="width: 200px;" maxlength="16"></td></tr>
		                  <tr>
		                  <td> 비밀번호 확인  </td>
		                  <td> <input type="password" id="userPwd2" style="width: 200px;" maxlength="16"> <input type="button" id="pwdCheck" value=" 확 인"></td>
		              </tr>
		              <tr>
		                  <td> 이 름 </td>
		                  <td><input type="text" id="pName" maxlength="8"> &nbsp;&nbsp;
		              </tr>
		              <tr>
		              	  <td>영문이름</td>
		              	  <td><input type="text" id="eName1" maxlength="8" placeholder="성"><input type="text" id="eName2" maxlength="8" placeholder="이름">
		              	  <input type="button" id="eNameCheck" value="입력"></td>
		              </tr>
		              <tr>
		              	  <td>주민등록번호</td>
		              	  <td><input type="text" id="psid1" maxlength="6">-<input type="password" id="psid2" size="7"> <input type="button" id="pschk" value="확인"> 
		              </tr>
		              <tr>
		                  <td>비상이메일</td>
		                  <td>
		                      <input type="text" id="maillist" name="email"> 
		                      <select id = "mailst">
		                          <option value="">직접 입력</option>
		                          <option value="@Daum.com">@Daum.com</option>
		                          <option value="@hanmail.net">@hanmail.net</option>
		                          <option value="@naver.com">@naver.com</option>
		                      </select>
						
		                      <input type="button" value="중복 확인" id="inputFunction14" onclick="emailCheck();">
		                  </td>
		              <tr>
		                  <td> 성 별 </td>
		                  <td>  
		                      <input type="radio" value="남" name="gender1"> 남 &nbsp; <input type="radio" value="여" name="gender1"> 여
		                  </td>
		              </tr>
		                 <tr>
		                 <td>나이</td>
		                 <td><input type="text"></td>
		                 </tr>
		              <tr>
		                  <td>연락처(자택)</td>
		                  <td class="numberInput" colspan="2"> &nbsp;<input type="text" maxlength="3">-<input type="text" maxlength="4">-<input type="text" maxlength="4"></td>
		              </tr>
		              <tr>
		                  <td>연락처(PHONE)</td>
		                  <td colspan="2"><select name="" id="">
		                      <option value="">010</option>
		                      <option value="">011</option>
		                      <option value="">016</option>
		                      <option value="">017</option>
		                      <option value="">019</option>
		                  </select>
		                  - <input type="text" maxlength="4" class="numberInput"> - <input type="text" maxlength="4" class="numberInput">
		              </td>
		              </tr>
		              <tr>
		                  <td>주소  <input type="button" value="확 인" style="width: 70px;" id = "N15"
		                      onclick="showAddress();"> </td>
		                  <td colspan="2">
		                      <label id = "N16"> 여기에서 출력 됩니다.</label>
		                  </td>
		                  
		              </tr>
		                  <tr>
		                  <td> 직 급 </td>
		                  <td>
		                       <select id="CompanyRank11" style="width: 150px;">
		                          <option value="J8"> 사 원 </option>
		                          <option value="J7"> 대 리 </option>
		                          <option value="J6"> 과 장 </option>
		                          <option value="J5"> 차 장 </option>
		                          <option value="J4"> 부 장 </option>
		                          <option value="J3"> 상 무 </option>
		                          <option value="J2"> 부사장 </option>
		                          <option value="J1"> 사장 </option>
		                      </select>
		                  </td>
		              </tr>
		              <tr>
		                  <td> 부 서  </td>
		                  <td>
		                      <select id="Department11" style="width: 150px;">
		                          <option value = "기 획">기 획</option>
		                          <option value = "영 업">영 업</option>
		                          <option value = "인 사">인 사</option>
		                          <option value = "R&D">R&D</option>
		                          <option value = "임 시">임 시</option>
		                      </select>
		                  </td>
		              </tr>
		              <tr>
		                  <!-- 사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다.-->
		                  <td><input type="file" id="" value="사진 전송" onchange="ShowImage(this);"></td>
		              </tr>
		              <tr>
		                  <td>비고 </td>
		                  <td colspan="2" rowspan="2">
		                      <textarea style="resize: none; width: 600px; height: 60;" id="N17">
		
		                      </textarea>
		                  </td>
		              </tr>
		              <tr>
		              </tr></tbody>
		              <tfoot><tr>
		                  <td align="center" colspan="3" id="foot">
		                      <!-- 나중에 submit 로 바꿀것-->
		                      <input type="button" id="regist" value = " 확 인 " style="width: 150px; height: 50px;"> 
		                      &nbsp; &nbsp; 
		                      <input type="reset" value = " 취 소 " style="width: 150px; height: 50px;">
		                  </td>
		              </tr></tfoot>
		              
		      </table>
		          </form>
		     <script>
		     	$('#checkemp').click(function(){
		     	   $.ajax({
		     		   url:"<%=request.getContextPath() %>/mCheckEmp.me",
		     		   type:"post",
		     		   success:function(data){
		     			   $('#mEmpCode').val(data);
		     		   },error:function(){
		     			   
		     		   }
		     	   });
		     	});
		     	  $('#eNameCheck').click(function(){
		     	        var regExp = /[a-z]/;
		     	        var eName1 = $('#eName1').val();
		     	        var eName2 = $('#eName2').val();

		     	        if(!regExp.test(eName1)){
		     	           alert("영문만 입력해주세요");
		     	           return false;
		     	        }

		     	        if(!regExp.test(eName2)){
		     	           alert("영문만 입력해주세요");
		     	           return false;
		     	        }
		     	        $('#userId').val(eName1+"."+eName2);
		     	     });
		     	  $('#checkId').click(function(){
		     	        $.ajax({
		     	          url:"<%= request.getContextPath() %>/idDup.me",
		     	          type:"get",
		     	          data:{
		     	        	    userId:$('#userId').val()
		     	          },success:function(data){
		     	        	 
		     	        	  if(data=='y'){
		     	        		 alert("아이디 사용가능");
		     	        	  }else{
		     	        		 alert("아이디 사용불가");
		     	        	  }
		     	          },error:function(){
		     	        	  alert("조회 실패");
		     	          }
		     	        })
		     	     });
		     	  $('#pwdCheck').click(function(){
		     		 var pwd = $('#userPwd').val();
		     		 var pwd2 = $('#userPwd2');
		     		 var regExp = /[0-9|a-z]/;
		     		 
		     		 if(!regExp.test(pwd)){
		     			alert("숫자와 영문으로만 작성해주시기 바랍니다."); 
		     			return false;
		     		 }
		     		 
		     		 if(pwd==pwd2.val()){
		     			alert("비밀번호가 일치합니다.");		     			 
		     		 }else{
		     			alert("비밀번호가 틀립니다.");
		     			pwd2.select();
		     			return false;
		     		 }
		     	  });
		     	 $('#pschk').click(function(){
		     		 
		     	 }); 
		    </script>
</body>		     
</html>		       