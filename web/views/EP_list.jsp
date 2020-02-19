
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import="com.coo.check.model.vo.*,java.util.ArrayList"%>
  <% 
	ArrayList<CheckDoc> list = (ArrayList<CheckDoc>)request.getAttribute("list"); 
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int listCount = pi.getCheckListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPaging();
	int startPage = pi.getStartPaging();
	int endPage = pi.getEndPaging();
	int limitpage = pi.getLimitPage();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 결재 게시판</title>

    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/button.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/margin.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/table.css">

 

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
                <button type="button" class="btn btn-light" id="all">전체</button>
                <button type="button" class="btn btn-primary">제안</button>
                <button type="button" class="btn btn-wait " id="wait">결재대기</button>
                <button type="button" class="btn btn-info"  id="flow">진행중</button>
                <button type="button" class="btn btn-success" id="end" >결재완료</button>
                <button type="button" class="btn btn-warning" id="return">반려</button>
                <input type ="hidden" id="status">
                <br><br><br>
                <!-- 홍석코드 -->
                &nbsp; 
                
                <script >
                	$("#all").click(function(){
                		 
                		location.href='/semi/clist.ch?status=1' ;
                	})
                	$("#flow").click(function(){
                		
                		location.href='/semi/clist.ch?status=2';
                	})
                	$("#end").click(function(){
                		
                		location.href='/semi/clist.ch?status=3';
                	})
                	$("#return").click(function(){
                	
                		location.href='/semi/clist.ch?status=4';
                	})
                	$("#wait").click(function(){
                		 location.href='/semi/clist.ch?status=5';
                	});
                	
                </script>

           
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
                        <tbody style="text-align:cente;">
                        	<%int i = listCount -((currentPage-1)*limitpage); %>
                           <% for(CheckDoc b : list){  %>
                           <tr>
                           <td><input type="checkbox">  <input type="hidden" class="docno"value="<%=b.getDocNumber() %>"></td>
                           <td><%=i%></td>
                           <td><%=b.getaTitle() %></td>
                           <td><%=b.getAwriterName() %></td>
                           <td><%=b.getDeptName() %></td>
                           <%if(b.getaStatus() ==0 ||b.getaStatus()==1||b.getaStatus()==2 ){%> <td>결재중</td><%}else if(b.getaStatus()==3){%><td>결재완료</td><%}else{ %><td>반려</td> <% }%>
                           
                           <td><%=b.getDocDate() %></td>
                           <tr>
                           <%i--; } %>
                        </tbody>
                    </table>
                    <button id="write" class="btn btn-light" style="margin-left:30px;" onclick="window.open('views/checkdoc/writedoc.jsp','' ,'target:_blank;');">글쓰기</button> 
                    <br>
                    <div>
                   <select id="search" name="search" style="height: 30px; margin-left: 220px;"> 
                         <option value="0">-----</option>
                         <option value="1">제목</option> 
                         <option value="2">기안자</option>
                     </select>&nbsp;
                     <input class="form-control" type="text" id="keyword" 
                         name="keyword"  placeholder="검색어를 입력하세요"
                         style="width:200px;"/>
 
                     <button id="btn">검색</button>
                    <div class="pagingArea" align="center">
			<button onclick="location.href='<%= request.getContextPath() %>/clist.ch?currentPage=1&status=<%=pi.getStatus()%>'"><<</button>
			<%  if(currentPage <= 1){  %>
			<button disabled><</button>
			<%  }else{ %>
			<button onclick="location.href='<%= request.getContextPath() %>/clist.ch?currentPage=<%=currentPage - 1 %>&status=<%=pi.getStatus()%>'"><</button>
			<%  } %>
			
			<% for(int p = startPage; p <= endPage; p++){
					if(p == currentPage){	
			%>
				<button disabled><%= p %></button>
			<%      }else{ %>
				<button onclick="location.href='<%= request.getContextPath() %>/clist.ch?currentPage=<%= p %>&status=<%=pi.getStatus()%>'"><%= p %></button>
			<%      } %>
			<% } %>
				
			<%  if(currentPage >= maxPage){  %>
			<button disabled>></button>
			<%  }else{ %>
			<button onclick="location.href='<%= request.getContextPath() %>/clist.ch?currentPage=<%=currentPage + 1 %>&status=<%=pi.getStatus()%>'">></button>
			<%  } %>
			<button onclick="location.href='<%= request.getContextPath() %>/clist.ch?currentPage=<%= maxPage %>&status=<%=pi.getStatus()%>'">>></button>
			
		</div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 풋터 부분 include -->
    <%@ include file="common/COO_footer.jsp" %>
</div>
<script>

$(function(){
	
	$("#list td").mouseenter(function(){
		
		$(this).parent().css({"background":"darkgray", "cursor":"pointer"});
	}).mouseout(function(){
		$(this).parent().css({"background":"white"});
	}).click(function(){
		//console.log($(this).parent().find("input[type=hidden]").val());
		var docNumber = $(this).parent().find("input[type=hidden]").val();
		//location.href="<%=request.getContextPath()%>/cread.ch?docNumber=" + docNumber;
		window.open("<%=request.getContextPath()%>/cread.ch?docNumber=" + docNumber,'','target=_blank');
		//window.open('www.naver.com','','target:_blank;');
		//'<%=request.getContextPath()%>/cread.ch?docNumber=' + docNumber;'
		
	


	});
});
</script>
    
    
</body>
</html>