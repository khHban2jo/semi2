<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>조직도</title>
    <script src="/semi/resources/JS/jquery-3.4.1.min.js"></script>
    
    <link rel="stylesheet" href="/semi/resources/css/dept_chart/dept_chart_css.css" />
    <script src="/semi/resources/js/dept_chart/dept_chart_js.js"></script>
</head>
<body>
    <h2>조직도</h2>

    <hr>
    <div id ="team">

        <input type="button" id="all" value="전체조회" style="position: absolute; top : 10px; left: 320px; background : black; color:white;" onclick="viewT(this)">
        
        <input type="button" id="top1" value="사장" style="position: absolute; top : 30px; left: 170px; background : lightblue">
       
        <input type="button" value="부사장" style="position: absolute; top : 70px; left: 170px; background : lightcyan">

        <input type="button" value="총무부" style="position: absolute; top : 110px; left: 10px; background : lightslategray">
    
        <input type="button"  value="영업부" style="position: absolute; top : 110px; left: 170px; background : lightslategray">

        <input type="button"  value="인사부" style="position: absolute; top : 110px; left: 320px; background : lightslategray">

        <input type="button"  value="영업 1팀" style="position: absolute; top : 160px; left: 120px; background : lightslategray">

        <input type="button"  value="영업 2팀" style="position: absolute; top : 160px; left: 220px; background : lightslategray">
	</div>

    <div id= "tableview" align ="center">
		<table class="table" style="width:100%;" >
        	<thead><tr>
		        
		        <th>no.1</th>
		        <th>직급</th>
		        <th>사번</th>
		        <th>이름</th>
		        <th>연락처</th>
		     </tr></thead>
		     <tbody>
		         <tr>
		            <td>1</td>
		            <td>사장</td> 
		            <td>사장</td>
		            <td>유순재</td>
		            <td>010-1111-3333</td>
		         </tr>
		
		         <tr>
		            <td>2</td>
		            <td>영업1팀</td> 
		            <td>부장</td>
		            <td>이늘야</td>
		            <td>010-1242-3313</td>
		         </tr>
		
		         <tr>
		            <td>3</td>
		            <td>총무부</td> 
		            <td>사원</td>
		            <td>백진여</td>
		            <td>010-4211-6321</td>
		         </tr>
		
		         <tr>
		            <td>4</td>
		            <td>인사부</td> 
		            <td>팀장</td>
		            <td>송선혜</td>
		            <td>010-4131-3748</td>
		         </tr>
		
		         <tr>
		            <td>5</td>
		            <td>영업2팀</td> 
		            <td>부장</td>
		            <td>마종현</td>
		            <td>010-8462-0486</td>
		         </tr>
		     </tbody>
	    </table> 
	    <hr style="width:370px;">
	
	    <select style="width:50px; height:30px;">
	        <option value="부서코드">부서코드</option>
	        <option value="이름">이름</option>
	    </select>
	    <input class="form-control" type="text" id="keyword" name="keyword"  placeholder="검색어를 입력하세요">
	    <button id="btn">검색</button>
    </div>
    
</body>
</html>