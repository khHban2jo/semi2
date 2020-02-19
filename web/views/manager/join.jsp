<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"
    errorPage="/views/common/errorPage.jsp" %>
<% Member mem = (Member)session.getAttribute("member"); %>    
<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="UTF-8">
  <link rel="stylesheet" href="/semi/resources/css/manager/manageView.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  </head>
  <body>  
  <% if(mem.getEmpId().equals("admin")){ %>
 <form action="<%=request.getContextPath() %>/mInsert.me" method="POST" onsubmit="return check()">
		      <table class="managerTable">
		       
		       <thead><tr><th class="cap">기본정보입력</th></tr></thead>
		            
		              <tbody><tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" id="mEmpCode" name="empCode" readonly>&nbsp; <input type="button" value="확인" id="checkemp">	   
		                  <!-- 사진 -->
		                  <td rowspan="8" id="pic"> 
		                      <img src="" width="320px" height="320px" id="Show" alt="프로필사진"> 
		                  </td>
		              </tr>
		              <tr>
		                  <td> 아이디  </td>
		                  <td> 
		                      <input type="text" id="uid" name="userId" maxlength="20" readonly placeholder="영어이름 먼저입력"> 
		                      <input type="button" id="checkId" value="중복확인" disabled>
		                  </td>
		              </tr>
		              <tr>
		                  <td> 비밀번호 </td> <td><input type="password" name="userPwd" id="pwd1" maxlength="16"></td></tr>
		                  <tr>
		                  <td> 비밀번호 확인  </td>
		                  <td> <input type="password" id="pwd2" maxlength="16">&nbsp;
		                  <input type="button" id="pwdCheck" value="확 인"></td>
		              </tr>
		              <tr>
		                  <td> 이 름 </td>
		                  <td><input type="text" id="pName" name="empName" maxlength="8">&nbsp;&nbsp;
		              </tr>
		              <tr>
		              	  <td>영문이름</td>
		              	  <td><input type="text" id="eName1" maxlength="8" placeholder="성" name="eName">&nbsp;&nbsp;
		              	  <input type="text" id="eName2" maxlength="8" placeholder="이름">
		              	  <input type="button" id="eNameCheck" value="입력"></td>
		              </tr>
		              <tr>
		              	  <td>주민등록번호</td>
		              	  <td><input type="text" id="psid" maxlength="13" placeholder="-없이 입력" name="personalId">&nbsp;
		              	  <input type="button" id="pschk" value="확인">
		              	  </tr>
		              <tr>
		                  <td>이메일</td>
		                  <td>
		                      <input type="text" id="mail" name="email"> 
		                      <select id="maillist">
		                          <option value="">직접 입력</option>
		                          <option value="@daum.net">@daum.net</option>
		                          <option value="@naver.com">@naver.com</option>
		                      </select>
		                  </td>
		                 </tr>
		              <tr>
		                  <td> 성 별 </td>
		                  <td>  	
		                      <input type="radio" value="M" name="gender" id="male" readonly> 남 &nbsp; <input type="radio" value="F" id="female" name="gender" readonly> 여
		                  </td>
		              </tr>
		                 <tr>
		                 <td>나이</td>
		                 <td><input type="text" id="age1" name="age" readonly></td>
		                 </tr>
		              <tr>
		                  <td>연락처(자택)</td>
		                  <td colspan="2">
		                  <input type="text" list="t1" name="tel1" id="tt1">
		                  <datalist id="t1"> 
		                  <option value="02">서울 </option>
                          <option value="031">경기 </option>
                          <option value="032">인천</option>
                          <option value="033">강원 </option>
                          <option value="041">충남 </option>
                          <option value="042">대전 </option>
                          <option value="043">충북 </option>
                          <option value="051">부산 </option>
                          <option value="052">울산 </option>
                          <option value="053">대구 </option>
                          <option value="054">경북 </option>
                          <option value="054">경북 </option>
                          <option value="055">경남 </option>
                          <option value="061">전남 </option>
                          <option value="062">광주 </option>
                          <option value="063">전북 </option>
                          <option value="064">제주 </option></datalist>
		                  ― <input type="text" maxlength="4" id="t2" name="tel2"> ― <input type="text" id="t3" maxlength="4" name="tel3"></td>
		              </tr>
		              <tr>
		                  <td>연락처(PHONE)</td>
		                  <td colspan="2"><select name="phone1">
		                      <option value="010">010</option>
		                      <option value="011">011</option>
		                      <option value="016">016</option>
		                      <option value="017">017</option>
		                      <option value="019">019</option>
		                  </select>
		                  ― <input type="text" maxlength="4" id="p2" name="phone2"> ― <input type="text" maxlength="4" id="p3" name="phone3">
		              </td>
		              </tr>
		        <tr>
		        <tr>
					<td>우편번호&nbsp;&nbsp;&nbsp;<input type="button" id="ckZip" value="검색" onclick="addrSearch();"></td>
					<td><input type="text" id="zipCode" name="zipCode"></td>			
					
				</tr>
				<tr>
					<td>주소</td>  
					<td><input type="text" id="address1" name="address1"></td>
					<td></td>
				</tr>
				<tr>
					<td>상세주소</td>  
					<td><input type="text" id="address2" name="address2"></td>
					<td></td>
				</tr>		                     		                  
		        </tr>
		               <tr>
		                  <td> 직 급 </td>
		                  <td>
		                       <select name="jobCode" style="width: 150px;">
  		                      	  <option value="">--</option>
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
		                      <select name="deptCode" style="width: 150px;" id="ds">
		                      	  <option>--</option>
		                      	  <option value="D0">임원</option>
		                          <option value="D1">인사부서</option>
		                          <option value="D2">영업부서</option>
		                          <option value="D3">기획부서</option>
		                          <option value="D4">연구부서</option>
		                          <option value="D5">미발령</option>
		                      </select>
		                  </td>
		              </tr>
		              <tr>
		              <td>겸직</td>
		                  <td><select name="cr" id="crv">
		                  		<option value="">--</option>
								<option value="1">정</option>		                  
		                  		<option value="2">부</option>
		                  	</select>
		                      <select name="cr2" style="width: 150px;" id="crv2" disabled>
		                      	  <option value="">--</option>
		                      	  <option value="D0">임원</option>
		                          <option value="D1">인사부서</option>
		                          <option value="D2">영업부서</option>
		                          <option value="D3">기획부서</option>
		                          <option value="D4">연구부서</option>
		                          <option value="D5">미발령</option>
		                      </select>
		                       <input type="hidden" value="사번검색" id="crv3">&nbsp;&nbsp;<input type="hidden" name="cr3" id="crv4" value="사번">
		                  </td>
		                  <td>연차 보유 수량 : <input type="number" name="l1Value" value="0" min="0" max="30"></td>
		             </tr>		             
		             <tr>
		                  <!-- 사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다.-->
		                  <td><input type="file" id="" value="사진 전송" onchange="ShowImage(this);"></td>
		              </tr>
		              <tr>
		                  <td>비고 </td>
		                  <td colspan="2" rowspan="2">
		                      <textarea style="resize:none; width: 600px; height:60px;" name="etc">
		
		                      </textarea>
		                  </td>
		              </tr>
		              <tr>
		              </tr></tbody>
		              <tfoot><tr>
		                  <td align="center" colspan="3">
		                      <input type="submit" value ="확인 " style="width: 100px; height: 30px; text-align:center;"> 
		                      &nbsp; &nbsp; 
		                      <input type="reset" value ="삭제 " style="width: 100px; height: 30px; text-align:center;">
		                  </td>
		              </tr>
		              </tfoot>
		              
		      </table>
		          </form>
		        
	 <script src="resources/js/manager/join.js"></script>
	 <script>
	 $('#checkemp').click(function(){
		    $.ajax({
		        url:"<%=request.getContextPath() %>/mCheckEmp.me",
		        type:"post",
		        success:function(data){
		            $('#mEmpCode').val(data);
		        },error:function(){
		            alert("에러발생");
		        }
		    });
		 });
	  
	 $('#crv').change(function(){
		   var sd = document.getElementById('crv').selectedIndex;
		   if(sd>0){
			   $('#crv2').removeAttr('disabled');
		   if(sd==1){
			   $('#crv3').attr('type','button').val("검색(부)");
		   }else if(sd==2){
			   $('#crv3').attr('type','button').val("검색(정)");
		   }
		   $('#crv4').attr('type','text').attr('readonly','true');
		   
		   $('#crv3').click(function(){
			   var pop = window.open("about:black","검색","width=500,height=400");
			    $.ajax({
			    	url:pop.location.href="<%=request.getContextPath() %>/pAll.do",
			    	type:"post",
			    	});
			    });
		   }
	  });
	 </script>
	  <script>
		             
		  				function addrSearch() {
		  			        new daum.Postcode({
		  			            oncomplete: function(data) {
		  			               
		  			                var fullAddr = '';
		  			                var extraAddr = ''; 

		  			                
		  			                if (data.userSelectedType === 'R') { 
		  			                    fullAddr = data.roadAddress;

		  			                } else { 
		  			                    fullAddr = data.jibunAddress;
		  			                }

		  			               
		  			                if(data.userSelectedType === 'R'){
		  			                    
		  			                    if(data.bname !== ''){
		  			                        extraAddr += data.bname;
		  			                    }
		  			                    
		  			                    if(data.buildingName !== ''){
		  			                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		  			                    }
		  			                    
		  			                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		  			                }

		  			                
		  			                $('#zipCode').val(data.zonecode); //5자리 새우편번호 사용
		  			                
		  			                $('#address1').val(fullAddr);

		  			                
		  			                $('#address2').focus();
		  			            }
		  			        }).open();
		  			    };
		  				
        </script>
	 <%}%>
  
</body>		     
</html>		       