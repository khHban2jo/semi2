<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.coo.notice.model.vo.*"%>
<%
	Notice n = (Notice) request.getAttribute("notice");
%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>COO - 홈</title>

<link rel="stylesheet" href="/semi/resources/css/common/basic.css">

<style>
th, td {
	border: 1px solid black;
}

th {
	background-color: #A9D0F5;
	border: 1px solid black;
}

table {
	border: "0";
}
</style>
</head>
<body>
	<div class="total">
		<!-- 헤더부분 include -->
		<%@ include file="../common/COO_header.jsp"%>

		<!-- 화면 좌측 고정부 include -->
		<%@ include file="../common/COO_left.jsp"%>

		<%--  <div class="right">
            <div id="notice" align="center;">
            	<table class="managerTable">
		          <form action="<%= request.getContextPath()%>/noticeUpdate" method="POST">
		              <tr>
		                  <thead><th style="font:28pt '궁서체'">공지 사항</th></thead>
		                  <input type="hidden" name="nno" id="nno" value=<%= n.getNno() %> >
		              </tr>
		              <tr>
		              	<% if(m.getEmpId().equals("admin")){%>
		              		<td style="font-size: 18px;">제목 작성 : <input type="text" name="title" style="width: 800px; height: 30px" value=' <%= n.getNtitle() %>'> </td>
		              	<% }else{ %>
		              		<td style="font-size: 18px;">제목 작성 : <%= n.getNtitle() %> </td>
		              	<% } %>
		              </tr>
		              <tr>
		              	<% if(m.getEmpId().equals("admin")){%>
		              		<td style="font-size: 18px;">작성자 ID : <%= n.getNwriter() %> <input type="hidden" name="nwriter" value="<%= n.getNwriter() %>"></td>
		              	<% }else{ %>
		              		<td style="font-size: 18px;">작성자 ID : <%= n.getNwriter() %> </td>
		              	<% } %>
		              </tr>
		              <tr>
<!-- 자바스크립트의 변수를 JSP에 넘겨주지는 못합니다. 방법은 있지만 코드가 길어지고 복잡해 진다.-->
						<td style="font-size: 18px;">작성일  : <%= n.getNdate() %> <input type="hidden" id="nowDate" name="nowDate" value=""> </td>
		              </tr>
<!-- 		              <tr>
		              	<td style="font-size: 18px;">내용 
		              	폰트 크기 선택<select id="font_size">
		              		<option value="10">10</option>
		              		<option value="15">15</option>
		              		<option value="20">20</option>
		              		<option value="25">25</option>
		              	</select> &nbsp;
		              	폰트 종류 선택<select id="font_face">
		              		<option value="궁서체">궁서체</option>
		              		<option value="굴림">굴림</option>
		              		<option value="굴림체">굴림체</option>
		              		<option value="궁서">궁서</option>
		              		<option value="굴림">궁서체</option>
		              		</select>
		              	</td>
		              </tr> -->
		              <tr>
		              	<% if(m.getEmpId().equals("admin")){%>
							<td style="font-size: 18px;">
							<textarea id="ncontent" name="ncontent" style=" height:580px; width:880px; resize:none; text-align:left; font-size: 25px"><%= n.getNcontent() %></textarea>
							</td>
						<% }else{ %>
							<td style="font-size: 18px;">
								<textarea style=" height:580px; width:880px; resize:none; text-align:left; font-size: 25px"  readonly><%= n.getNcontent() %></textarea>
							</td>
						<% } %>
		              </tr>
		      		</table>
		      		<% if(m.getEmpId().equals("admin")){%>
		      			<input type="submit" id="updateNotice" value = " 수 정  " style="width: 100px; height: 30px; margin-left: 300px"> 
		             	&nbsp; &nbsp; 
		             <% } %>
		        	</form>
		        	<button style="width: 100px; height: 30px;" onclick="history.back(-1);"> 취 소 </button>
		        	 &nbsp; &nbsp; 
		        	<% if(m.getEmpId().equals("admin")){%>
		            	<button id="deleteNotice" style="width: 100px; height: 30px; margin-bottom: 50px"> 삭 제 </button>
		            <% } %>
            </div>
                    
        </div> --%>

		<!-- ======================내용 수정한 부분 입니다 .........==================== -->

		<div class="right">
			<div id="notice" align="center;">
				<h1>공지사항 수정</h1>
				<table class="managerTable">
					<form action="<%=request.getContextPath()%>/noticeUpdate"
						method="POST">

						<thead>
							<input type="hidden" name="nno" id="nno" value=<%=n.getNno()%>>
							<input type="hidden" name="id" id="id" value=<%=m.getEmpId()%>>
							<!-- 제목 작성 부분 -->
							<tr>
								<%
									if (m.getEmpId().equals("admin")) {
								%>
								<th style="font-size: 18px; width: 100px; height: 20px;">제목
									작성 :</th>
								<td colspan=2><input type="text" name="title"
									style="border: 0; outline: none; width: 800px; height: 30px"
									value=' <%=n.getNtitle()%>'></td>

								<%
									} else {
								%>
								<th style="font-size: 18px; width: 100px; height: 20px;">제목
									작성</th>
								<td colspan=2><%=n.getNtitle()%></td>
								<%
									}
								%>
							</tr>


							<!--  작성자 아이디 불러오는 부분 -->
							<tr>
								<%
									if (m.getEmpId().equals("admin")) {
								%>
								<th style="font-size: 18px;">작성자 :</th>
								<td colspan=2><input type="hidden" name="nwriter"
									value="<%=n.getNwriter()%>"><%=n.getNwriter()%></td>
								<%
									} else {
								%>
								<th style="font-size: 18px;">작성자 ID</th>
								<td colspan=2><%=n.getNwriter()%></td>
								<%
									}
								%>
							</tr>
							<!-- 작성일 불러오는 부분  -->
							<tr>
								<th style="font-size: 18px;">작성일</th>
								<td width="600px"><%=n.getNdate()%> <input type="hidden"
									id="nowDate" name="nowDate" value=""></td>
								<td align="right">내용 폰트 크기 선택 <select id="font_size"
									height="40px">
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>내용</th>
								<td colspan=2>
									<%
										if (m.getEmpId().equals("admin")) {
									%> <textarea id="ncontent"
										name="ncontent"
										style="height: 500px; width: 800px; resize: none; text-align: left; font-size: 20px"><%=n.getNcontent()%></textarea>
									<%
										} else {
									%> <textarea
										style="height: 500px; width: 800px; resize: none; text-align: left; font-size: 20px"
										readonly><%=n.getNcontent()%></textarea> <%
 	}
 %>
								
							</tr>
						</tbody>
				</table>
				<%
					if (m.getEmpId().equals("admin")) {
				%>
				<input type="submit" id="updateNotice" value=" 수 정  "
					style="width: 100px; height: 30px; margin-left: 300px">
				&nbsp; &nbsp;
				<%
					}
				%>
				</form>
				<button style="width: 100px; height: 30px;" id="back">취 소</button>
				&nbsp; &nbsp;
				<%
					if (m.getEmpId().equals("admin")) {
				%>
				<button id="deleteNotice"
					style="width: 100px; height: 30px; margin-bottom: 50px">삭
					제</button>
				<%
					}
				%>
			</div>

		</div>

		<!-- 풋터 부분 include -->
		<%@ include file="../common/COO_footer.jsp"%>
	</div>
	<script>
/*     document.getElementById('font_size').onclick = function(){
 		var fontSize = document.getElementById('font_size').value;
 		document.getElementById('ncontent').style.fontSize = fontSize+"px";
    }; */
/*     document.getElementById('font_face').onclick = function(){
 		var fontFace = document.getElementById('font_size').value;
 		document.getElementById('ncontent').style.font = ''+fontSize;
    }; */
    (function () { 
    	var day = new Date();
    	var nday = day.getFullYear()+"-"+ day.getMonth() + 1+"-"+day.getDate();
    	var nno = document.getElementById("nno").value;
		
/*     	var str = document.referrer.split('/');
    	var str1 = "";
    	for(var i = 3; i <=str.length-1; i++){
    		str1 += str[i];
    	}
    	console.log(str1); */
    	
    	document.getElementById('back').onclick = function(){
/*     		if(str1 == "semiviewshome.jsp"){
    			opener.document.location.reload();
    			self.close();
        		//window.location = document.referrer;
    		}else{
    			location.href = "/semi/noticeListServlet?search=all&date1=all&date2=all";
    		} */
    		location.href = "/semi/noticeListServlet?search=all&date1=all&date2=all";
    	}
    	    	
/*     	if(str1 == "semiviewshome.jsp"){
    		document.getElementById('updateNotice').style.visibility = "hidden";
    		document.getElementById('deleteNotice').style.visibility = "hidden";
    		//document.getElementById('back').location.href;
    	}else{
       		document.getElementById('updateNotice').style.visibility = "visible";
    		document.getElementById('deleteNotice').style.visibility = "visible";
    	} */
    
    	document.getElementById("nowDate").innerHTML = nday;
    	var id = document.getElementById("id").value;
    	if(id == "admin"){	//id
    			document.getElementById("deleteNotice").onclick = function(){
    				alert("삭제 합니다.");
    				location.href = "/semi/deleteNotice?nno="+nno;
    		}
    	}
    	
    })();
    
// 	document.getElementById("goNoticeList").onsubmit = function(){
//		return false;
//	}
    
/* 	document.getElementById("goNoticeList").onclick = function(){
		 location.href = "/semi/noticeListServlet?search=all&date1=all&date2=all"
	} */
	
	
    </script>
</body>
</html>