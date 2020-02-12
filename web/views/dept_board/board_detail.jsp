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
   	
   	<style>
   		.btn2{
   			float:right;
   			margin-right:70px;
   		}
   		.btn3{
   			float:right;
   			margin-right:20px;
   		}	
   	</style>
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
                 <button type="button" class="btn btn-light" id="allb">전체</button>
                <button type="button" class="btn btn-primary" id="deptb">부서별</button>
                <button type="button" class="btn btn-info" id="normalb">일반</button>
                <button type="button" class="btn btn-success" id="bizb">업무</button>
                <br><br><br>
        <table style="width:95%; height:300px;" border="1" class="table-line">
         	<thead><tr>
         		<th>제목</th>
         		<th colspan="3"><%=b.getBtitle() %></th>
         		<th>분류</th>
         		<th><%=b.getCategory() %></th>
        	</tr></thead>
        	<tbody>
        		<tr>
        		<td colspan="6" rowspan="1"></td>
        		</tr>
        		<tr class="tra">
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
        		<tr>
        		<td class="tra">댓글</td>
        		<td class="tra">작성자</td>
        		<td colspan="4"></td>
        		</tr>
        	</tbody>
         </table>
         <button id="back" class="btn btn-light">뒤로가기</button>
         <%if(b.getBwriter().equals(m.getEmpId())){ %>
          <button class="btn2 btn btn-light" id="modify">수정</button>
           <button class="btn3 btn btn-light" id="delB">삭제하기</button>
         <%} %>
    </div>
    </div>
   </div>
    <%@include file="/views/common/COO_footer.jsp" %>
    
    <script>
    	$('#back').click(function(){
    		location.href="/semi/selectList.bo";
    	});
    	
    	$('#allb').click(function(){
 		   location.href="<%=request.getContextPath() %>/selectBoardAll.bo";
	 	});
	   	
	 	$('#deptb').click(function(){
	 	  location.href="<%=request.getContextPath() %>/selectBoardDept.bo";
	 	});
	 	
	 	$('#normalb').click(function(){
	 	  location.href="<%=request.getContextPath() %>/selectBoardNormal.bo";
	 	});
	 	
	 	$('#bizb').click(function(){
	 	  location.href="<%=request.getContextPath() %>/selectBoardBiz.bo";
	 	});
	 	
	   	$('#modify').click(function(){
	   	  location.href="<%=request.getContextPath() %>/bUpView.bo?bno="+<%=b.getBno() %>;	
	   	});
	   	
	   	$('#delB').click(function(){
	   		var chk = window.prompt("삭제하시겠습니까?(Y / N)");
	   		
	   		if(chk.toUpperCase()==="Y"){
				location.href="<%=request.getContextPath() %>/deleteBoard.bo?bno="+<%=b.getBno()%>;
				alert("삭제완료");
	   		}
		});
	   	
    </script>   
</body>
</html>