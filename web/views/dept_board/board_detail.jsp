<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.board.model.vo.*,com.coo.boardComment.model.vo.*"%>
<% Board b = (Board)request.getAttribute("board");
   Object countC = (request.getAttribute("count")); 
   ArrayList<BoardComment> clist = (ArrayList<BoardComment>)request.getAttribute("clist");
   %>

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
   		
   		
   		th, td {
  			  border: 1px solid black;
 		 }
  
 	 	th{
  			background-color : #A9D0F5;
  			border: 1px solid black; 
  			height:50px; 
  			width:150px;
  			}
  	
  		table{
  			border:"0";
  		}
  		
  		.outer{
		width:800px;
		height:500px;
		background:black;
		color:white;
		margin-left:auto;
		margin-right:auto;
		margin-top:50px;
	}

	.tableArea {
		border:1px solid black;
		background : white;
		color: black;
		width:800px;
		height:350px;
		margin-left:auto;
		margin-right:auto;
	}
	#content {
		height:230px;
	}
	.replyArea {
		width:800px;
		color:white;
		background:black;
		margin-left:auto;
		margin-right:auto;
		padding-bottom : 5px;
	}
	.replyArea textArea {
		border-radius: 10px;
		resize: none;
	}
	a:link {
    	color: yellow;
	}
	a:active {
		color: aqua;
	}
	table[class*="replyList"] * {
		color: black;
		
	}
	.replyList1 td{	background : lavenderblush; }
	.replyList2 td{	background : honeydew; }
	.replyList3 td{ background : aliceblue; }
		

   	</style>
</head>
<body>
    <div class="total">
        <!-- 헤더부분 include -->
    	<%@ include file="/views/common/COO_header.jsp" %>
    	
    	<!-- 화면 좌측 고정부 include -->
    	<%@ include file="/views/common/COO_left.jsp" %>
		<%
			String memberDeptCode = m.getDeptCode();
			String boardDeptCode = b.getBdeptCode();
			
			boolean check1 = false;
			boolean check2 = false;
			
			for(int i = 0 ; i < boardDeptCode.length() ; i++){
		        if(boardDeptCode.charAt(i) == ' '){
		        	check1 = true;
		        }
		    }

			for(int i = 0 ; i < memberDeptCode.length() ; i++){
		        if(memberDeptCode.charAt(i) == ' ')
		        	check2 = true;
		    }
			
			// 공백 제거
			memberDeptCode = memberDeptCode.trim();
			boardDeptCode = boardDeptCode.trim();
			
			check1 = false;
			check2 = false;
			for(int i = 0 ; i < boardDeptCode.length() ; i++){
		        if(boardDeptCode.charAt(i) == ' '){
		        	check1 = true;
		        }
		    }

			for(int i = 0 ; i < memberDeptCode.length() ; i++){
		        if(memberDeptCode.charAt(i) == ' ')
		        	check2 = true;
		    }
						
			System.out.println("check1 : "+ check1);
			System.out.println("check2 : "+ check2);
		
			System.out.println("사용자 부서와 게시판 부서 가 맞는지 확인 : "+memberDeptCode.equals(boardDeptCode));
		%>
		
        <div class="right">
         <div class="margin-list-head">
                <h1 align="left">게시판</h1>
             
        	<%if(memberDeptCode.equals(boardDeptCode) || m.getEmpId().equals("admin")){ %> <!-- 관리자는 모두 부서와 상관 없이 모두 볼수 있어야 한다. =>|| m.getEtc().equals("관리자")-->
        
         <table>
         	<tr>
         		<th>제목</th>
         		<td colspan="3">&nbsp;&nbsp;&nbsp;<%=b.getBtitle() %></td>
         		
         	</tr>
         	
         	<tr>
         		<th>작성자</th>
         		<td align="center" ><%=b.getBwriter() %></td>
         		<th>분류</th>
         		<td align="center"><%=b.getCategory() %></td>
         	</tr>
         	
         	<tr>
         		<th>작성일</th>
         		<td align="center"><%=b.getBdate() %></td>
         		<th>조회수</th>
         		<td align="center"><%=b.getBcount() %></td>
         	
         	</tr>
         	
         	<tr>
         		<th style="height:300px;">내용</th>
         		<td colspan="3" style="width:900px;"><p id="content"><%=b.getBcontent() %></p></td>
         	
         	</tr>
         	
         	<tr>
         		<td class="tra" style="height:20px;">댓글</td>
         		<td colspan="2">&nbsp;<input type="text" id="bco" value="<%= countC %>"style="width:400px; border: 0; outline: none;" readonly ></td>
         		<td class="tra" id="cd">댓글의 수</td>
         		
         	</tr>
         
         </table>
        	<%} %>
         <button id="back" class="btn btn-light">뒤로가기</button>
         <%if(b.getBwriter().equals(m.getEmpId())){ %>
          <button class="btn2 btn btn-light" id="modify">수정</button>
           <button class="btn3 btn btn-light" id="delB">삭제하기</button>
         <%} %>
    </div>
    <div id="replySelectArea">
			<!-- 게시글의 댓글들을 보여주는 부분  -->
			<% if (clist != null) { %>
				<% for(BoardComment bco : clist) { %>
				
				<table id="replySelectTable"
	      	 style="margin-left : <%= (bco.getClevel()-1) * 15 %>px;
	      	 		width : <%= 800 - ((bco.getClevel()-1) * 15)%>px;"
	      	 class="replyList<%=bco.getClevel()%>">
		  		<tr>
		  			<td rowspan="2"> </td>
		  			<td><b><%= bco.getCwriter() %></b></td>
					<td><%= bco.getCdate() %></td>
					<td align="center">
 					<%if(m.getEmpId().equals(bco.getCwriterId())) { %>
						<input type="hidden" name="cno" value="<%=bco.getCno()%>"/>
							  
						<button type="button" class="updateBtn" 
							onclick="updateReply(this);">수정하기</button>
							
						<button type="button" class="updateConfirm"
							onclick="updateConfirm(this);"
							style="display:none;" >수정완료</button> &nbsp;&nbsp;
							
						<button type="button" class="deleteBtn"
							onclick="deleteReply(this);">삭제하기</button>
							
					<% } else if( bco.getClevel() < 3) { %>
						<input type="hidden" name="writer" value="<%=m.getEmpId()%>"/>
						<input type="hidden" name="refcno" value="<%= bco.getCno() %>" />
						<input type="hidden" name="clevel" value="<%=bco.getClevel() %>" />
						<button type="button" class="insertBtn" 
							 onclick="reComment(this);">댓글 달기</button>&nbsp;&nbsp;
							 
						<button type="button" class="insertConfirm"
							onclick="reConfirm(this);"
							style="display:none;" >댓글 추가 완료</button> 
							
					<% } else {%>
						<span> 마지막 레벨입니다.</span>
					<% } %>
					</td>
				</tr>
				<tr class="comment replyList<%=bco.getClevel()%>">
					<td colspan="3" style="background : transparent;">
					<textarea class="reply-content" cols="105" rows="3"
					 readonly="readonly"><%= bco.getCcontent() %></textarea>
					</td>
				</tr>
			</table>
			
			<% } } else { %>
			<p>현재 등록된 댓글이 없습니다.<br>
			   첫 댓글의 주인공이 되어 보세요!</p>
			<% } %>
			</div>
			</div>
			<%@ include file="/views/common/COO_footer.jsp"%>
	</div>
	<script>
	function updateReply(obj) {
		// 현재 위치와 가장 근접한 textarea 접근하기
		$(obj).parent().parent().next().find('textarea')
		.removeAttr('readonly');
		
		// 수정 완료 버튼을 화면 보이게 하기
		$(obj).siblings('.updateConfirm').css('display','inline');
		
		// 수정하기 버튼 숨기기
		$(obj).css('display', 'none');
	}
	
	function updateConfirm(obj) {
		// 댓글의 내용 가져오기
		var content
		  = $(obj).parent().parent().next().find('textarea').val();
		
		// 댓글의 번호 가져오기
		var cno = $(obj).siblings('input').val();
		
		// 게시글 번호 가져오기
		var bno = '<%=b.getBno()%>';
		
		location.href="/semi/updateComment.bo?"
				 +"cno="+cno+"&bno="+bno+"&content="+content;
	}
	
	function deleteReply(obj) {
		// 댓글의 번호 가져오기
		var cno = $(obj).siblings('input').val();
		
		// 게시글 번호 가져오기
		var bno = '<%=b.getBno()%>';
		
		location.href="/semi/deleteComment.bo"
		+"?cno="+cno+"&bno="+bno;
	}
	
	function reComment(obj){
		// 추가 완료 버튼을 화면 보이게 하기
		$(obj).siblings('.insertConfirm').css('display','inline');
		
		// 클릭한 버튼 숨기기
		$(obj).css('display', 'none');
		
		// 내용 입력 공간 만들기
		var htmlForm = 
			'<tr class="comment"><td></td>'
				+'<td colspan="3" style="background : transparent;">'
					+ '<textarea class="reply-content" style="background : ivory;" cols="105" rows="3"></textarea>'
				+ '</td>'
			+ '</tr>';
		
		$(obj).parents('table').append(htmlForm);
		
	}
	
	function reConfirm(obj) {
		// 댓글의 내용 가져오기
		
		// 참조할 댓글의 번호 가져오기
		var refcno = $(obj).siblings('input[name="refcno"]').val();
		var level = Number($(obj).siblings('input[name="clevel"]').val()) + 1;
		
		// console.log(refcno + " : " + level);
		
		// 게시글 번호 가져오기
		var bno = '<%=b.getBno()%>';
		
		var parent = $(obj).parent();
		var grandparent = parent.parent();
		var siblingsTR = grandparent.siblings().last();
		
		var content = siblingsTR.find('textarea').val();
		
		// console.log(parent.html());
		// console.log(grandparent.html());
		// console.log(siblingsTR.html());
		
		// console.log(content);

		// writer, replyContent
		// bno, refcno, clevel
		
		location.href='/semi/insertComment.bo'
		           + '?writer=<%=m.getEmpId()%>' 
		           + '&replyContent=' + content
		           + '&bno=' + bno
		           + '&refcno=' + refcno
		           + '&clevel=' + level;
	}
    
    	$('#back').click(function(){
    		// location.href="/semi/searchBoard.bo?title=all";
    		history.back(-1);
    		window.location = document.referrer;
    	});
	 	
	   	$('#modify').click(function(){
	   	  location.href="<%=request.getContextPath() %>/bUpView.bo?bno="+<%=b.getBno() %>;	
	   	});
	   	
	   	$('#delB').click(function(){
	   		var chk = window.confirm();
	   		
	   		if(chk){
				location.href="<%=request.getContextPath() %>/deleteBoard.bo?bno="+<%=b.getBno()%>;
				alert("삭제완료");
	   		}
		});
	   
	   	
    </script>   
</body>
</html>