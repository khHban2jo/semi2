<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.board.model.vo.*, java.util.ArrayList"%>
<% ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list"); 
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
    <title>COO - 게시판</title>
   
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
            <!-- 게시판 시작 -->
            <div class="margin-list-head">
                <h1 align="left" id="board-Title">게시판</h1>
                <hr class="table-line" color="lightgray">
                 <button type="button" class="btn btn-light" id="allb">전체</button>
                <button type="button" class="btn btn-primary" id="deptb">부서별</button>
                <button type="button" class="btn btn-info" id="normalb">일반</button>
                <button type="button" class="btn btn-success" id="bizb">업무</button>
                <br><br><br>
                <!-- 홍석코드 -->
                &nbsp; 
                <label>분류</label> 
                <select id="searchType" name="searchType"> 
                    <!-- 로그인한 사용자에 대한 권한과 부서등에 따라서 alert등으로 접근 금지를 설정 한다. --->
                <option value="1">전체</option>
                <option value="2">일반</option>
                <option value="3">업무</option>
                <option value="4">부서별</option>
                </select> &nbsp;
                <!-- 부서, 관리자의 전체 공지등 알아야 하는 필요한 만 띄운다.  -->
                <!--<input type="checkbox" name="name1">  -->
                 공 지 <input type="checkbox" name="name1">
                 &nbsp;&nbsp;&nbsp;
                 <!-- 안 될것 같으면 변경 및 삭제 -->
                 <label>기 간 설 정</label>
                 <input type="date" id="time1"> ~ <input type="date" id="time2">&nbsp;
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
                        	<% for(Board b : list){ %>
                        	<%if(m.getDeptCode().equals(b.getBdeptCode())){ %>
                            <tr align="center" class='table-line'>
                                <input type="hidden" value="<%= b.getBno() %>">
                                <td><input type="checkbox" name="list"></td>
                                <td><%=b.getBno() %></td> 
                                <td><%=b.getCategory() %></td>
                                <td><%=b.getBtitle() %></td>
                                <td><%=b.getBwriter() %></td>
                                <td><%=b.getBdate() %></td>
                                <td><%=b.getBcount() %></td>
                            </tr>
                            <%} %>
                           <%} %>
                        </tbody>
                    </table>
                    <%if(m != null){ %>
                    <button id="write" class="btn btn-light" style="margin-left:-10px;">글쓰기</button> 
                    <%} %>
                    <br>
                    <div>
                        
                   <select id="searchCondition" name="searchCondition" style="height: 30px; margin-left:300px;"> 
                         <option value="">검색조건</option>
                         <option value="title">제목</option> 
                         <option value="content">내용</option>
                         <option value="dept">직급</option>
         <!-- 분류에 따른 게시판을 직급별로 쓴 것을 보는 것 단 권한이 없으면 접근 불가 -->
         <!--                 <option value="titlencontent">제목+내용</option> -->
                         <option value="all">전체조건</option>
                     </select>&nbsp;
                     <input class="form-control" type="text" id="keyword" 
                         name="keyword"  placeholder="검색어를 입력하세요"
                         style="width:200px;"/>
 
                     <button id="btn">검색</button>
                    <ul id="pagenation" align="center" style="margin-left:-90px;">
                    
                        <li><button class="listbtn" onclick="location.href='<%=request.getContextPath() %>/selectList.bo?currentPage=1'">&lt;&lt;</button></li>
                        <% if(currentPage <= 1){ %>
                        <li><button disabled>&lt;</button></li>
                        <% }else{ %>
                        <li><button class="listbtn" onclick="location.href='<%=request.getContextPath() %>/selectList.bo?currentPage=<%=currentPage -1 %>'">&lt;</button></li>
                        <% } %>
                       
                        <% for(int p = startPage; p <= endPage; p++){
                        	if(p == currentPage){
                       	%>
							<li><button disabled><%= p %></button></li>
							<% }else{ %>
							<li><button class="listbtn" onclick="location.href='<%=request.getContextPath() %>/selectList.bo?currentPage=<%=p %>'"><%=p %></button></li>
							<%} %>        
						  <%} %>	            
						  
						  <%  if(currentPage >= maxPage){  %>
							<li><button disabled>&gt;</button></li>
							<%  }else{ %>
							<li><button class="listbtn" onclick="location.href='<%= request.getContextPath() %>/selectList.bo?currentPage=<%=currentPage + 1 %>'">&gt;</button></li>
							<%  } %>
							<li><button class="listbtn" onclick="location.href='<%= request.getContextPath() %>/selectList.bo?currentPage=<%= maxPage %>'">&gt;&gt;</button></li> 
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <!-- 풋터 부분 include -->
    <%@ include file="/views/common/COO_footer.jsp" %>
</div>
  <script>
  	 $('#write').click(function(){
  		 var url = "/semi/views/se2/write.jsp";
  		 var name = "글쓰기";
  		 var option = "top=200px,left=500px,width=850px,height=550px,location=no,resizable=no,toolbars=no";
  		window.open(url,name,option);
  	 });
  	 
  	 $('#list td').click(function(){
  		 var bno = $(this).parent().find("input").val();
  		 location.href="<%=request.getContextPath() %>/selectOne.bo?bno="+bno;
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
	
// 검색 이벤트 등록
<%-- 	document.getElementById('btn').setAttribute("method", "Post");
	document.getElementById('btn').setAttribute("click", "location.href='<%=request.getContextPath() %>'/searchBoard.bo?search=true"); --%>
		
	$('#btn').click(function(){
		var title = document.getElementById('searchCondition').value;
		var keyword = document.getElementById('keyword').value;
		// searchType
		var date1 = document.getElementById('time1').value;
		var date2 = document.getElementById('time2').value;
		var searchType = document.getElementById('searchType').value;
		
		console.log(typeof(date1));
		
		if(date1 > date2){
			alert("날짜가 잘못 입력 되었습니다. 다시 입력 해주세요.");
			return false;	
		}else if( (date1.length <= 0 && date2.length > 0) ||  (date1.length > 0 && date2.length <= 0) ){
			alert("날짜가 잘못 입력 되었습니다. 다시 입력 해주세요.");
			return false;	
		}
		
		location.href="<%=request.getContextPath() %>/searchBoard.bo?search=true&title="+title
																			+"&keyword="+keyword
																			+"&date1="+date1
																			+"&date2="+date2
																			+"&searchType="+searchType;
	});
	
  </script>	
</body>
</html>