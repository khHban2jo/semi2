<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>COO - 홈</title>

<link rel="stylesheet" href="/semi/resources/css/common/basic.css">

<style>
	
	
	 th, td {
    border: 1px solid black;
  }
  
  	th{
  		background-color : #A9D0F5;
  		
  	}
  	
  	table{
  		border:"0";
  	}
  	
  	





  	
  	
</style>
</head>
<body>
	<div class="total">
		<!-- 헤더부분 include -->
		<%@ include file="../common/COO_header.jsp"%>

		<!-- 화면 좌측 고정부 include -->
		<%@ include file="../common/COO_left.jsp"%>

		<%-- <div class="right">
			<div id="notice" align="center;">
				<table class="managerTable">
					<form action="<%= request.getContextPath()%>/noticeServletInsert" method="POST">
						<tr>
						<thead>
							<th>공지 사항 작성</th>
						</thead>
						</tr>
						<tr>
							<td style="font-size: 18px;">제목 작성 : <input type="text"
								name="title" style="width: 800px; height: 30px">
							</td>
						</tr>
						<tr>
							<td style="font-size: 18px;">작성자 ID : <input type="hidden"
								name="nwriter" value="admin"> admin
							</td>
							<!-- 로그인 시에 구현 해야 된다. -->
						</tr>
						<tr>
							<!-- 자바스크립트의 변수를 JSP에 넘겨주지는 못합니다. 방법은 있지만 코드가 길어지고 복잡해 진다.-->
							<td style="font-size: 18px;">작성일 : <input type="hidden"
								id="nowDate" name="nowDate" value=""><label id="now"></label>
							</td>
						</tr>
						<tr>
							<td style="font-size: 18px;">내용 폰트 크기 선택<select
								id="font_size">
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
									<option value="25">25</option>
							</select> <br> <textarea id="ncontent" name="ncontent"
									style="height: 580px; width: 880px; resize: none; font-size: 20px"></textarea>
							</td>
						</tr>
						<tfoot>
							<tr align="center">
								<td id="foot"> 
								<% if(m.getEtc().equals("관리자")){%>
									<input type="submit" id="regist" value=" 확 인 " style="width: 100px; height: 30px;">
								<% } %>
									&nbsp; &nbsp;
							</form>
								<!-- <input type="reset" value=" 취 소 "style="width: 100px; height: 30px;"> --> 
								<button id="goNoticeList" style="width: 100px; height: 30px;"> 취 소 </button>
								</td>
							</tr>
					</tfoot>
				</table>
			</div>

		</div> --%>
		
		<div class="right">
			<div id="notice" align="center">
				<h1>공지 사항 작성</h1>
				
				<form action="<%= request.getContextPath()%>/noticeServletInsert" 
						method="POST">
				
				<table class="managerTable">
						<thead>
							<tr>
								<th style="font-size: 18px; width:100px; height:20px;">제목 작성</th> 
								<td colspan=2>&nbsp; <input type="text" name="title" style="border:0; outline: none; width: 802px; height: 30px"> </td>
							</tr>
							
							<tr>
								<th style="font-size: 18px;">작성자 </th>
								<td colspan=2>&nbsp; <input type="hidden" name="nwriter" value="admin"><%= m.getEmpId() %></td>
								<!-- 로그인 시에 구현 해야 된다. -->
							</tr>
							
							<tr>
							<!-- 자바스크립트의 변수를 JSP에 넘겨주지는 못합니다. 방법은 있지만 코드가 길어지고 복잡해 진다.-->
								<th style="font-size: 18px;">작성일  
								<td width="600px">&nbsp; <input type="hidden" 
								id="nowDate" name="nowDate" value="" style=""><label id="now"></label>
								</td>
								<td  align="right">내용 폰트 크기 선택
								<select id="font_size" height="40px">
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
									<option value="25">25</option></td>
							</tr>
						</thead>
						
						
						
						<tbody>
							<tr>
								<th>내용</th>
							
								<td colspan=2 >
									<textarea id="ncontent" name="ncontent" style="outline: none; border:0; height: 500px; width: 800px; resize: none; font-size: 20px"></textarea>
								</td>
							</tr>
							
						</tbody>
													
				</table>
						
							<input type="submit" id="regist" value="확 인 " style="width: 100px; height: 30px;">
							<input type="button" id="goNoticeList"  style="width: 100px; height: 30px;" value="취소">
						</form>
					
					
				
				<br>
				
			</div>

		</div>
		<!-- 풋터 부분 include -->
		<%@ include file="../common/COO_footer.jsp"%>
	</div>
	<script>
    document.getElementById('font_size').onclick = function(){
 		var fontSize = document.getElementById('font_size').value;
 		document.getElementById('ncontent').style.fontSize = fontSize+"px";
    };
    
    (function() { 
    	var day = new Date();
    	var nday = document.getElementById("nowDate").value = day.getFullYear()+"-" + (day.getMonth() + 1) +"-"+day.getDate();
    	
    	document.getElementById("now").innerHTML = nday;
    })();

 	document.getElementById("goNoticeList").onsubmit = function(){
		//return false;
 		history.back(-1);
	}
    
	document.getElementById("goNoticeList").onclick = function(){
		 location.href = "/semi/noticeListServlet?search=all&date1=all&date2=all";
	}
	
    </script>
</body>
</html>