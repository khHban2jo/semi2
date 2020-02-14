<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.Member"%>
<%-- <% Member m = (Member)request.getAttribute("member"); %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원수정</title>
    <link rel="stylesheet" href="/semi/resources/css/manager/manageView.css">
</head>
<body>

<form action="<%=request.getContextPath() %>/mUpdate.me" method="POST" onsubmit="return check();">
			<table class="managerTable">
		              <tr>
		                  <th colspan="3" style="font-size: 1em; font-family: 고딕; text-align:left; padding-left:10px;" class="cap" >사원 수정</th>
		              </tr>
		              <tr>
		                  <td> 사 번  </td>
		                  <td> <input type="text" value="<%-- <%=m.getEmpCode() %> --%>" name="empCode" disabled> 
		                  </td>
		                  <td rowspan="8"> 
		                  	<img src="" width="320px" height="320px" id="pic"> 
		                  </td>
		              </tr>
		              <tr>
		                  <td> 아이디 </td>
		                  <td> 
		                      <input type="text" id="uid" name="userId" maxlength="14"> 
		                  </td>
		              </tr>
		              <tr>
		                  <td> 이름 </td>
		                  <td><input type="text" id="pName" name="userName" maxlength="8" value="<%-- <%=m.getEmpName() %> --%>"> &nbsp;&nbsp;</td>
		              </tr>
		              <tr>
		                  <td> 변경할 비밀번호  </td>
		                  <td> 
		                      <input type="password" id="pwd1" name="userPwd">
		                  </td>
		              </tr>
		              <tr>
		                  <td> 비밀번호 확인 </td>
		                  <td> 
		                      <input type="password" id="pwd2">
		                       <input type="button" value="확인" id="checkPwd">
		                  </td>
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
		                <td>연락처(자택)</td>
		                  <td colspan="2">
		                  <input type="text" list="t1" name="tel1">
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
		                  <td>주소  </td>
		                  <td colspan="2">
		                      <input type="text" name="address" value="서울시">
		                  </td>
		                  
		              </tr>
		              <tr>
		                  <td> 직 급 </td>
		                  <td>
		                       <select name="jobCode" style="width: 150px;">
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
		                      <select name="deptCode" style="width: 150px;">
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
		                  <td>비고 </td>
		                  <td colspan="2" rowspan="2">
		                      <textarea style="resize: none; width: 600px; height: 60;" id="modifyShowText">
		
		                      </textarea>
		                  </td>
		              </tr>
		              <tr>
		              </tr>
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
</body>
</html>