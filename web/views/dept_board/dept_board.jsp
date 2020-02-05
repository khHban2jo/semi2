<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 부서게시판</title>
   
    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/button.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/margin.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/table.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   
    <!-- 임시 게시판 스크립트 -->
    <script src="../resources/js/notice/list.js"></script>
 
  
</head>
<body>
    <div class="total">
        <!-- 헤더부분 include -->
    	<%@ include file="../common/COO_header.jsp" %>
    	
    	<!-- 화면 좌측 고정부 include -->
    	<%@ include file="../common/COO_left.jsp" %>

        <div class="right">
            <!-- 게시판 시작 -->
            <div class="margin-list-head">
                <h1 align="left">부서별 게시판</h1>
                <hr class="table-line" color="lightgray">
                <button type="button" class="btn btn-light">전체</button>
                <button type="button" class="btn btn-primary">부서별</button>
                <button type="button" class="btn btn-info">일반</button>
                <button type="button" class="btn btn-success">업무</button>
                <br><br><br>
                <!-- 홍석코드 -->
                &nbsp; 
                <label>분류</label> 
                <select id="searchType" name="searchType"> 
                    <!-- 로그인한 사용자에 대한 권한과 부서등에 따라서 alert등으로 접근 금지를 설정 한다. --->
                <option>전체</option>
                <option>일반</option>
                <option>업무</option>
                <option>부서별</option>
                </select> &nbsp;
                <!-- 부서, 관리자의 전체 공지등 알아야 하는 필요한 만 띄운다.  -->
                <!--<input type="checkbox" name="name1">  -->
                 공 지 <input type="checkbox" name="name1">
                 &nbsp;&nbsp;&nbsp;
                 <!-- 안 될것 같으면 변경 및 삭제 -->
                 <label>기 간 설 정</label>
                 <input type="month" id="time1"> ~ <input type="month" id="time2">&nbsp;
                 <!-- <select id="showNumber" style="float: right;">
                     <option></option>
                 </select> -->
                 <hr class="table-line" style="margin-left:-0px;">
                <div class="table-line">
                    <table style="width:100%; border-collapse:collapse;" id="list">
                        <thead>
                            <tr class='table-line'>
                                <th><input type="checkbox" id="checkAll"></th>
                                <th>번호</th>
                                <th>분류</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>날짜</th>
                                <th>조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr align="center" class='table-line'>
                                <td><input type="checkbox" name="list"></td>
                                <td>1</td> 
                                <td>일반</td>
                                <td>으앙</td>
                                <td>읭읭이</td>
                                <td>날짜</td>
                                <td>0</td>
                            </tr>
                            <tr align="center" class='table-line'>
                                <td><input type="checkbox" name="list"></td>
                                <td>2</td> 
                                <td>부서별</td>
                                <td>으앙</td>
                                <td>읭읭이</td>
                                <td>날짜</td>
                                <td>0</td>
                            </tr>
                            <tr align="center" class='table-line'>
                                <td><input type="checkbox" name="list"></td>
                                <td>3</td> 
                                <td>업무</td>
                                <td>으앙</td>
                                <td>읭읭이</td>
                                <td>날짜</td>
                                <td>0</td>
                            </tr>
                        </tbody>
                    </table>
                    <button id="write" class="btn btn-light" style="margin-left:-10px;">글쓰기</button> 
                    <br>
                    <div>
                        
                   <select id="search" name="search" style="height: 30px; margin-left:300px;"> 
                         <option value="">검색조건</option>
                         <option value="">제목</option> 
                         <option value="">내용</option>
                         <option value="">직급</option>
         <!-- 분류에 따른 게시판을 직급별로 쓴 것을 보는 것 단 권한이 없으면 접근 불가 -->
                         <option value="">제목+내용</option>
                         <option value="">전체조건</option>
                     </select>&nbsp;
                     <input class="form-control" type="text" id="keyword" 
                         name="keyword"  placeholder="검색어를 입력하세요"
                         style="width:200px;"/>
 
                     <button id="btn">검색</button>
                    <ul id="pagenation" align="center" style="margin-left:-90px;">
                        <li><button class="listbtn" value="-1">&lt;</button></li>
                        <li><button class="listbtn" value="1">1</button></li>
                        <li><button class="listbtn" value="2">2</button></li>
                        <li><button class="listbtn" value="3">3</button></li>
                        <li><button class="listbtn" value="+1">&gt;</button></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <!-- 풋터 부분 include -->
    <%@ include file="../common/COO_footer.jsp" %>

</div>

</body>
</html>