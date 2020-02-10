<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.board.model.vo.*"%>
<% Board b = (Board)request.getAttribute("board"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세조회</title>
   
    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/button.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/margin.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/table.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   
</head>
<body>
    <div class="total">
        <!-- 헤더부분 include -->
    	<%@ include file="/views/common/COO_header.jsp" %>
    	
    	<!-- 화면 좌측 고정부 include -->
    	<%@ include file="/views/common/COO_left.jsp" %>

        <div class="right">
         <div class="margin-list-head">
                <h1 align="left">부서별 게시판</h1>
                <hr class="table-line" color="lightgray">
                <button type="button" class="btn btn-light">전체</button>
                <button type="button" class="btn btn-primary">부서별</button>
                <button type="button" class="btn btn-info">일반</button>
                <button type="button" class="btn btn-success">업무</button>
                <br><br><br>
         <table border="1">
         	<thead><tr>
         		<th>제목</th>
         		<th colspan="3"><%=b.getBtitle() %></th>
         		<th>분류</th>
         		<th><%=b.getBtype() %></th>
        	</tr></thead>
        	<tbody>
        		<tr>
        		<td>작성자</td>
        		<td><%=b.getBwriter() %></td>
        		<td>작성일</td>
        		<td><%=b.getBdate() %></td>
        		<td>조회수</td>
        		<td><%=b.getBcount() %></td>
        		</tr>
        		<tr>
        		<td colspan="6">내용</td>
        		</tr>
        		<tr>
        		<td colspan="6">
        			<p id="content"><%=b.getBcontent() %></p>
        		</td>
        	</tbody>
         </table>
         <button>뒤로가기</button>
    </div>
    </div>
    <%@include file="/views/common/COO_footer.jsp" %>   
</body>
</html>