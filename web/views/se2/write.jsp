<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"%>
<% Member m = (Member)session.getAttribute("member"); %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script type="text/javascript" src="/semi/views/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="stylesheet" href="/semi/views/se2/css/write.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
    <form action="<%=request.getContextPath() %>/bInsert.bo" method="post">
    <div id="editor">
    <br>
    <label for="tt" style="margin:10px;">제목&nbsp;&nbsp;
    <input type="text" size="30" name="title" id="tt"></label>&nbsp;&nbsp;
   
    <label for="sel">분류&nbsp;<select name="category" id="sel">
        <option value="all">전체</option>
        <option value="normal">일반</option>
        <option value="biz">업무</option>
        <option value="dept">부서별</option>
    </select></label>&nbsp;&nbsp;&nbsp;
    <label>작성자</label>&nbsp;
    <input type="text" name="writer" size="15" value="<%= m.getEmpId() %>" readonly>
    <br><br>    
	<textarea name="ir1" id="ir1" rows="10" cols="100" name="content"></textarea>

    <br>
    <button type="reset">취소</button>&nbsp;&nbsp;<button type="submit">작성하기</button>
	</div>
    </form> 
   <script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "ir1",
	 sSkinURI: "/semi/views/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
 </script>
</body>
</html>