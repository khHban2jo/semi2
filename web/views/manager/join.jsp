<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <form action="<%=request.getContextPath() %>/mInsert.me" method="POST">
		      <table border="1" id = "change1" class="managerTable">
		       
		       <thead><tr><th class="cap">기본정보입력</th></tr></thead>
		            
		              <tbody><tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" style="width: 200px;" readonly>
		                  	   <input type="button" value="확인하기" id="checkemp">
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
		              
		      </table>
		          </form>