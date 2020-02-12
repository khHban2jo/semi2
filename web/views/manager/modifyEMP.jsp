<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		          <form action="" method="POST">
<table id = "change2" class="managerTable" border="1">
		              <tr>
		                  <th colspan="3" style="font-size: 1em; font-family: 고딕; text-align:left; padding-left:10px;" class="cap" >사원 수정</th>
		              </tr>
		              <tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" style="width: 200px;" id="N21" disabled> 
		                      <input type="button" value="중복 확인" id="inputFunction21" onclick="showModify(this)">
		                  </td>
		                  <td rowspan="8"> 
		                  	사진<img src="" width="320px" height="320px" id="show2"> 
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
		                  <!-- 사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다. -->
		                  
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
		                      <input type="button" value = " 확 인 " style="width: 150px; height: 50px;" id="modify"> 
		                      &nbsp; &nbsp; 
		                      <input type="reset" value = " 취 소 " style="width: 150px; height: 50px;">
		                  </td>
		              </tr>
		              
		      </table>
		          </form>