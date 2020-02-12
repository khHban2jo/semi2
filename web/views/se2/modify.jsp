<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*,com.coo.board.model.vo.*"%>
<% Member m = (Member)session.getAttribute("member"); %>
<% Board b = (Board)request.getAttribute("board"); %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
<link rel="stylesheet" href="/semi/resources/css/notice/button.css">
<script type="text/javascript" src="/semi/views/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="stylesheet" href="/semi/views/se2/css/write.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
    <form action="<%=request.getContextPath() %>/bUpdate.bo" method="post" id="gosubmit">
    <div id="editor">
    <br>
    <label for="tt" style="margin:10px;">제목&nbsp;&nbsp;
    <input type="text" size="30" name="title" id="tt" value="<%=b.getBtitle() %>"></label>&nbsp;&nbsp;
    <input type="hidden" name="deptview" value="<%=m.getDeptCode()%>">
    <input type="hidden" name="bno" value="<%=b.getBno() %>">
    <label for="sel">분류&nbsp;<select name="category" id="sel">
        <option value="1">전체</option>
        <option value="2">일반</option>
        <option value="3">업무</option>
        <option value="4">부서별</option>
    </select></label>&nbsp;&nbsp;&nbsp;
    <label>작성자</label>&nbsp;
    <input type="text" name="writer" size="15" value="<%= m.getEmpId() %>" readonly>
    <br><br>    
	<textarea name="ir1" id="contents" rows="10" cols="100"><%=b.getBcontent() %></textarea>

    <br>
    
    <button class="btn btn-light" type="reset">취소</button>
    <button class="btn btn-light" onclick="goSaveAndSubmit();">수정하기</button>
	</div>
    </form> 
   <script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "contents",
	 sSkinURI: "/semi/views/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
	
	  function goSaveAndSubmit(){
	    
	   oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD",[]);
	   
	   $('#gosubmit').submit();

	   }
 </script>
</body>
</html>