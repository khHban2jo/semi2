<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.coo.notice.model.vo.*"%>
<!-- 들어 가면 리스트 구현을 해야 된다. -->
<% 
	ArrayList<Notice> noticeList = (ArrayList<Notice>)request.getAttribute("noticeList"); 
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 공지사항</title>

    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/button.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/margin.css">
    <link rel="stylesheet" href="/semi/resources/css/notice/table.css">
    
    <!-- 임시 게시판 스크립트 -->
    <script src="/semi/resources/js/notice/list.js"></script>
    
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
                <h1 align="left">공지사항</h1>
                
                <hr color="lightgray" class="table-line">
<!--                 <button type="button" class="btn btn-light">전체</button>
                <button type="button" class="btn btn-primary">부서별</button>
                <button type="button" class="btn btn-info">강아지</button>
                <button type="button" class="btn btn-success">고양이</button>
                <button type="button" class="btn btn-warning">주의</button> -->
                <br><br><br>
                <!-- 홍석코드 -->
                &nbsp; 
                <label>분류</label> 
                <select id="searchType" name="searchType"> 
                    <!-- 로그인한 사용자에 대한 권한과 부서등에 따라서 alert등으로 접근 금지를 설정 한다. --->
                <option>전체</option>
                <option>공지사항</option> 
                <option>인사명령</option>
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
                           <tr class='table-line'>
                               <th><input type="checkbox" id="checkAll"></th>
                               <th>번호</th>
                               <th>제목</th>
                               <th>작성자</th>
                               <th>날짜</th>
                               <th>조회수</th>
                           </tr>
                      <% for(Notice n : noticeList){ %>
                           <tr align="center" class='table-line'>
                           		<td></td>
 								<td><%= n.getNno() %></td>
								<td><%= n.getNtitle() %></td>
								<td><%= n.getNwriter() %></td>
								<td><%= n.getNdate() %></td> 
								<td><%= n.getNcount() %></td>
						   </tr>
                          <% } %> 
                    </table>
                    <button onclick = "location.href='<%= request.getContextPath() %>/views/notice/noticeInsert.jsp' " id="write" class="btn btn-light" style="margin-left:-10px;"> 글쓰기</button> 
                    <br>
                    <div>
                        <select id="search" name="search" style="height: 30px; margin-left:300px;"> 
                         <option>검색조건</option>
                         <option>제목</option> 
                         <option>내용</option>
                         <option>직급</option>
         <!-- 분류에 따른 게시판을 직급별로 쓴 것을 보는 것 단 권한이 없으면 접근 불가 -->
                         <option>제목+내용</option>
                         <option>전체조건</option>
                     </select>&nbsp;
                     <input class="form-control" type="text" id="keyword" 
                         name="keyword"  placeholder="검색어를 입력하세요"
                         style="width:200px;"/>
 
                     <input type="submit" value = "검색">
            <%-- 페이지 처리 --%>
			<div class="pagingArea" align="center">
				<button onclick="location.href='<%= request.getContextPath() %>/noticeListServlet?currentPage=1'"><<</button>
				<%  if(currentPage <= 1){  %>
					<button disabled><</button>
				<%  }else{ %>
				<button onclick="location.href='<%= request.getContextPath() %>/noticeListServlet?currentPage=<%=currentPage - 1 %>'"><</button>
				<%  } %>
			
				<% for(int p = startPage; p <= endPage; p++){
						if(p == currentPage){	
				%>
					<button disabled><%= p %></button>
				<%      }else{ %>
					<button onclick="location.href='<%= request.getContextPath() %>/noticeListServlet?currentPage=<%= p %>'"><%= p %></button>
				<%      } %>
				<% } %>
				
				<%  if(currentPage >= maxPage){  %>
				<button disabled>></button>
				<%  }else{ %>
				<button onclick="location.href='<%= request.getContextPath() %>/noticeListServlet?currentPage=<%=currentPage + 1 %>'">></button>
				<%  } %>
				<button onclick="location.href='<%= request.getContextPath() %>/noticeListServlet?currentPage=<%= maxPage %>'">>></button>
			</div><!-- 페이징 처리 부분 -->
<!--                     <ul id="pagenation" align="center" style="margin-left:-90px;">
                        <li><button class="listbtn">이전</button></li>
                        <li><button class="listbtn">1</button></li>
                        <li><button class="listbtn">2</button></li>
                        <li><button class="listbtn">3</button></li>
                        <li><button class="listbtn">다음</button></li>
                    </ul> -->
                </div>
            </div>
        </div>
    </div>

    <!-- 풋터 부분 include -->
    <%@ include file="../common/COO_footer.jsp" %>
</div>

<!-- 시간이 된다면 자바스크립드로 바꿀것 -->
<script>
$(function(){
	
	$("#list tr").mouseenter(function(){
		$(this).css({"background":"snow", "cursor":"pointer"});
	}).mouseout(function(){
		$(this).css({"background":"white"});
	}).click(function(){
		var nno = $(this).children().eq(1).text()
		console.log(nno);
		location.href="<%=request.getContextPath()%>/noticeSelectOn?nno=" + nno;
	});
});
</script>


</body>
</html>