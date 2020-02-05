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

</head>
<!-- style="overflow:hidden;" -->
<body>
<div class="total">
    <!-- 헤더부분 include -->
	<%@ include file="common/COO_header.jsp" %>
	
	<!-- 화면 좌측 고정부 include -->
	<%@ include file="common/COO_left.jsp" %>


	<div class="right">
	
		<body style="background: white;">
		<br>&nbsp;
		  <input type = "button" value = "사원생성" id = "userId" style="width: 100px; height: 40px;" onclick="showId(1)"/>
		  <input type = "button" value = "사원수정" id = "pwd"style="width: 100px; height: 40px;" onclick="showId(2)"/>
		  <input type="button" value="사원삭제" id = "deleteId" style="width: 100px; height: 40px;" onclick="showId(3)"/>
		  <input type="button" value="공지등록" id = "deleteId" style="width: 100px; height: 40px;" onclick="showId(4)"/>
		  <hr>
		      <!-- 1. 회원 가입-->
		      <table border="1" id = "change1" class="managerTable">
		          <!-- <form action="" method="POST"> -->
		              <tr>
		                  <thead><th class="cap">기본정보입력</th></thead>
		              </tr>
		              <tbody><tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" id="N11" style="width: 200px;"> <input type="button" value="중복 확인" onclick="numberCheck();"></td>
		                  <!-- 사진 -->
		                  <td rowspan="8" style="width: 270px; height: 270px;"> 
		                      <img src="" width="320px" height="320px" id="Show" alt="프로필사진"> 
		                  </td>
		
		              </tr>
		              <tr>
		                  <td> 아이디  </td>
		                  <td> 
		                      <input type="text" id="N12" maxlength="8" placeholder="8자이하 특수문자 금지" style="width: 200px;"> 
		                      <input type="button" id="inputFunction12" value=" 확 인" onclick="IdCheck();">
		                  </td>
		              </tr>
		              <tr>
		                  <td> 비밀번호 </td> <td><input type="password" id="N13" style="width: 200px;"></td></tr>
		                  <tr>
		                  <td> 비밀번호 확인  </td>
		                  <td> <input type="password" id="N13e" style="width: 200px;"> <input type="button" onclick="passwordCheck();" value=" 확 인"></td>
		              </tr>
		              <tr>
		                  <td> 이 름 </td>
		                  <td><input type="text" id="pName" maxlength="8"> &nbsp;&nbsp;<button id="clearN">입력</button></td>
		              </tr>
		              <tr>
		                  <td> 직 급 </td>
		                  <td>
		                       <select id="CompanyRank11" style="width: 150px;">
		                          <option value="사 원"> 사 원 </option>
		                          <option value="대 리"> 대 리 </option>
		                          <option value="과 장"> 과 장 </option>
		                          <option value="차 장"> 차 장 </option>
		                          <option value="팀 장"> 팀 장 </option>
		                          <option value="사 장"> 사 장 </option>
		                      </select>
		                  </td>
		              </tr>
		              <tr>
		                  <td> 성 별 </td>
		                  <td>  
		                      <input type="radio" value="남" name="gender1"> 남 &nbsp; <input type="radio" value="여" name="gender1"> 여
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
		                  <td>이메일</td>
		                  <td>
		                      <input type="text" id = "N14"> 
		                      <select id = "N15">
		                          <option value="">직접 입력</option>
		                          <option value="@Daum.com">@Daum.com</option>
		                          <option value="@hanmail.net">@hanmail.net</option>
		                          <option value="@naver.com">@naver.com</option>
		                      </select>
		
		                      <input type="button" value="중복 확인" id="inputFunction14" onclick="emailCheck();">
		                  </td>
		                  <!-- 사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다.-->
		                  <td><input type="file" id="" value="사진 전송" onchange="ShowImage(this);"></td>
		              </tr>
		              <tr>
		                  <td>주소  <input type="button" value="확 인" style="width: 70px;" id = "N15"
		                      onclick="showAddress();"> </td>
		                  <td colspan="2">
		                      <label id = "N16"> 여기에서 출력 됩니다.</label>
		                  </td>
		                  
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
		              
		          <!-- </form> -->
		      </table>
		  <!-- 2. 회원 수정  -->
		      <table id = "change2" class="managerTable" border="1">
		          <form action="" method="POST">
		              <tr>
		                  <th colspan="3" style="font-size: 1em; font-family: 고딕; text-align:left; padding-left:10px;" class="cap" >사원 수정</th>
		              </tr>
		              <tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" style="width: 200px;" id="N21" disabled> 
		                      <input type="button" value="중복 확인" id="inputFunction21" onclick="showModify(this)">
		                  </td>
		                  <!-- 사진 -->
		                  <td rowspan="8"> 
		                      <img src="" width="320px" height="320px" id="show2"> 
		                  </td>
		
		              </tr>
		              <tr>
		                  <td> 아이디 </td>
		                  <td> 
		                      <input type="text" style="width: 200px;" id="inputFunction22"> 
		                      <input type="button" id="inputFunction23" value=" 찾 기" onclick="IdModify();">
		                  </td>
		              </tr>
		              <tr>
		                  <td> 이름 </td>
		                  <td><input type="text" id="pName" maxlength="8" disabled value="홍길동"> &nbsp;&nbsp;</td>
		              </tr>
		              <tr>
		                  <td> 변경할 비밀번호  </td>
		                  <td> 
		                      <input type="password" style="width: 200px;" id="inputFunction24">
		                  </td>
		                  
		              </tr>
		              <tr>
		                  <td> 비밀번호 확인 </td>
		                  <td> 
		                      <input type="password" style="width: 200px;" id="inputFunction24">
		                       <input type="button" value="확인" id="inputFunction25" onclick="passwordCheck();;">
		                  </td>
		              </tr>
		              <tr>
		                  <td> 직 급 변 경  </td>
		                  <td>
		                      <select id="CompanyRank2" style="width: 150px;">
		                          <option value="사 원"> 사 원</option>
		                          <option value="대 리"> 대 리</option>
		                          <option value="과 장"> 과 장 </option>
		                          <option value="차 장"> 차 장 </option>
		                          <option value="팀 장"> 팀 장 </option>
		                          <option value="사 장"> 사 장 </option>
		                      </select>
		                  </td>
		              </tr>
		              <tr>
		                  <td> 성 별 </td>
		                  <td> <input type="radio" value="남" name="gender1" checked disabled> 남 &nbsp; <input type="radio" value="여" name="gender1"> 여</td>
		              </tr>
		              <tr>
		                  <td> 부서 변경 </td>
		                  <td>
		                      <select id="Department2" style="width: 150px;">
		                          <option value = "기 획">기 획</option>
		                          <option value = "영 업">영 업</option>
		                          <option value = "인 사">인 사</option>
		                          <option value = "R&D">R&D</option>
		                          <option value = "임 시">임 시</option>
		                      </select>
		                  </td>
		              </tr>
		              <tr>
		                  <td>이메일 </td>
		                  <td>
		                      <input type="text" id="modifyEmailShow">&nbsp;&nbsp;<input type="button" value="중복 확인" onclick="ModifyEmail();">
		                  </td>
		                  <!-- 사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다.-->
		                  <!-- 2. -->
		                  <td>
		                      <input type="file" id="aa" value="사진 전송" onchange="fileShow(this);">
		                  </td>
		              </tr>
		              <tr>
		                  <td>주소  <input type="button" value="확 인" style="width: 70px;" onclick="ModifyAddress();"> </td>
		                  <td colspan="2">
		                      <label id="inputFunction26"> 여기에서 출력 됩니다.</label>
		                  </td>
		                  
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
		                  <td>비고 </td>
		                  <td colspan="2" rowspan="2">
		                      <textarea style="resize: none; width: 600px; height: 60;" id="modifyShowText">
		
		                      </textarea>
		                  </td>
		              </tr>
		              <tr>
		              </tr>
		              <tr>
		                  <td align="center" colspan="3" class="managerTable">
		                      <!-- 나중에 submit 로 바꿀것-->
		                      <input type="button" value = " 확 인 " style="width: 150px; height: 50px;" id="modify"> 
		                      &nbsp; &nbsp; 
		                      <input type="reset" value = " 취 소 " style="width: 150px; height: 50px;">
		                  </td>
		              </tr>
		              
		          </form>
		      </table>
		
		<!-- 3. 회원 삭제-->
		<!-- '사 번' 으로 검색 하여 db에 저장된 값을 가져와 여기에 출력 하는 기능을 구현 해야 된다. -->
		<table id = "change3" class="managerTable" border="1">
		    <form action="" method="POST">
		        <tr>
		            <th colspan="3" style="font-size: 1em; font-family: 고딕; text-align:left;" class="cap">사원삭제</th>
		      </tr>
		      <tr>
		          <td> 사 번 : </td>
		          <td> <input type="text" style="width: 200px;" id="deleteNumber"> <input type="button" value=" 검 색 " onclick="showDeleteList();"></td>
		          <!-- 사지을 가져와서 보여 주어야 됩니다. -->
		          <td rowspan="6" style="border: 1px solid black; width: 300px; height: 300px;"> 
		              <img src="./임시/image/Dobbi.jpg" width="320px" height="320px" id = "Show" > 
		          </td>
		      </tr>
		      <tr>
		          <td> 아이디  </td>
		          <td><label style="width: 300px; height: 24px;" id = "delete1"> 여기에서 출력 됩니다.</label> </td>
		      </tr>
		      <tr>
		          <td> 비밀번호  </td>
		          <td> <label style="width: 300px; height: 24px;" id = "delete2"> 여기에서 출력 됩니다.</label></td>
		      </tr>
		      <tr>
		          <td> 직 급   </td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete3"> 여기에서 출력 됩니다.</label>
		          </td>
		      </tr>
		      <tr>
		          <td> 성 별 </td>
		          <td> <label style="width: 300px; height: 24px;" id = "delete4"> 여기에서 출력 됩니다.</label> </td>
		      </tr>
		      <tr>
		          <td> 부 서 </td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete5"> 여기에서 출력 됩니다.</label>
		          </td>
		      </tr>
		      <tr>
		          <td>이메일</td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete6"> 여기에서 출력 됩니다.</label>
		          </td>
		          <!-- 사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다.-->
		          <td></td>
		      </tr>
		      <tr>
		          <td>주소 </td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete7"> 여기에서 출력 됩니다.</label>
		          </td>
		          
		      </tr>
		      <tr>
		          <td>비 고 </td>
		          <td colspan="2" rowspan="2">
		              <label style="width: 600px; height: 60;" id = "delete8"> 여기에서 출력 됩니다.</label>
		          </td>
		      </tr>
		      <tr>
		      </tr>
		      <tr>
		          <td align="center" colspan="3" class="managerTable">
		              <!-- 나중에 submit 로 바꿀것-->
		              <input type="button" value = " 확 인 " style="width: 150px; height: 50px;" onclick="deleteExecute();"> 
		              &nbsp; &nbsp; 
		              <input type="reset" value = " 취 소 " style="width: 150px; height: 50px;">
		            </td>
		        </tr>
		        
		    </form>
		</table>
		<!-- 4. 공지 등 록-->
		<!-- '사 번' 으로 검색 하여 db에 저장된 값을 가져와 여기에 출력 하는 기능을 구현 해야 된다. -->
		<table id = "change4" class="managerTable">
		    <form action="" method="POST">
		        
		    </form>
		</table>
		
		<script src="/semi/resources/js/manager/loginPage.js"></script>
	</div><!-- div.right -->

    <!-- 풋터 부분 include -->
	<%@ include file="common/COO_footer.jsp" %>
</div>

    

</body>
</html>