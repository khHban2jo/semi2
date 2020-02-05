<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 결재 게시판</title>

    <link rel="stylesheet" href="../resources/css/common/basic.css">
    <link rel="stylesheet" href="../resources/css/notice/button.css">
    <link rel="stylesheet" href="../resources/css/notice/margin.css">
    <link rel="stylesheet" href="../resources/css/notice/table.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- home 이미지 -->
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>

    <!-- 달력 -->
    <!-- // jQuery UI CSS파일  -->
    <link rel="stylesheet" href="../resources/css/common/jquery-ui.css" />
    <link rel="stylesheet" href="../resources/css/common/jquery-ui2.css" />
    
    
    <!-- // jQuery 기본 js파일 -->
    <script src="../resources/js/common/calendar.js"></script>  
    <!-- // jQuery UI 라이브러리 js파일 -->
    <script src="../resources/js/common/calendar2.js"></script>
    <!-- 왼쪽 메뉴 쿼리 -->
    <script src="../resources/js/common/leftmenu.js?v=<%=System.currentTimeMillis() %>"></script>
    
    <!-- 임시 게시판 스크립트 -->
    <script src="../resources/js/notice/list.js"></script>
    <!-- 더미데이터 스크립트 -->
    <script src="../resources/js/notice/dummy.js"></script>

</head>
<body>
    <div class="total">
        <!-- 헤더부분 include -->
    	<%@ include file="common/COO_header.jsp" %>
    	
    	<!-- 화면 좌측 고정부 include -->
    	<%@ include file="common/COO_left.jsp" %>

        <div class="right">
            <!-- 게시판 시작 -->
            <div class="margin-list-head">
                <h1 align="left">결재 게시판</h1>
                <hr color="lightgray">
                <button type="button" class="btn btn-light">전체</button>
                <button type="button" class="btn btn-primary">제안</button>
                <button type="button" class="btn btn-wait ">결재대기</button>
                <button type="button" class="btn btn-info">진행중</button>
                <button type="button" class="btn btn-success">결재완료</button>
                <button type="button" class="btn btn-warning">반려</button>
                <br><br><br>
                <!-- 홍석코드 -->
                &nbsp; 

                <!-- 부서, 관리자의 전체 공지등 알아야 하는 필요한 만 띄운다.  -->
                <!--<input type="checkbox" name="name1">  -->
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
                                <th>제목</th>
                                <th>기안자</th>
                                <th>기안부서</th>
                                <th>상태</th>
                                <th>날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr align="center" class='table-line'>
                                <td><input type="checkbox" name="list"></td>
                                <td>1</td> 
                                <td>휴가제안서</td>
                                <td>홍길동</td>
                                <td>기획부</td>
                                <td>진행중</td>
                                <td>2020-01-16</td>
                            </tr>
                        </tbody>
                    </table>
                    <button id="write" class="btn btn-light" style="margin-left:30px;" onclick="window.open('writedoc.html','' ,'target:_blank;');">글쓰기</button> 
                    <br>
                    <div>
                   <select id="search" name="search" style="height: 30px; margin-left: 220px;"> 
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
                        <li><button class="listbtn">이전</button></li>
                        <li><button class="listbtn">1</button></li>
                        <li><button class="listbtn">2</button></li>
                        <li><button class="listbtn">3</button></li>
                        <li><button class="listbtn">다음</button></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 풋터 부분 include -->
    <%@ include file="common/COO_footer.jsp" %>
</div>

    
    
</body>
</html>