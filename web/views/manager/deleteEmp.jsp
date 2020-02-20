<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.*"
    errorPage="/views/common/errorPage.jsp" %>
<% Member mem = (Member)session.getAttribute("member");
  Member searchResult = (Member)request.getAttribute("searchResult"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원삭제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/semi/resources/css/manager/manageView.css">
</head>
	<body>
			<% if(mem.getEmpId().equals("admin")){ %>
		    <form action="<%=request.getContextPath() %>/mDelete.me" method="POST">
		<table id = "change3" class="managerTable" border="1">
		        <tr>
		            <th colspan="3" style="font-size: 1em; font-family: 고딕; text-align:left;" class="cap">사원삭제</th>
		      </tr>
		      <tr>
		          <td> ID </td>
		          <td> <input type="text" style="width: 200px;" id="crv4" name="userId" value="<%=searchResult.getEmpId() %>"readonly> </td>
		         </tr>
		        <tr>
		          <td align="center" colspan="3" class="managerTable">
		            
		              <input type="submit" value = "확 인 " style="width: 150px; height: 50px;">
		              <input type="button" value = "취 소 " style="width: 150px; height: 50px;" id="goback">
		            </td>
		        </tr>
		</table>
		    </form>
		    <%}%>
		    
	<script>
	   $('#goback').click(function(){
		  history.back(); 
	   });
	</script>
</body>
</html>