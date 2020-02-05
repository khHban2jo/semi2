<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 홈</title>

    <link rel="stylesheet" href="/semi/resources/css/common/basic.css">
</head>
<body>
    <div class="total">
    	<!-- 헤더부분 include -->
    	<%@ include file="common/COO_header.jsp" %>
    	
    	<!-- 화면 좌측 고정부 include -->
    	<%@ include file="common/COO_left.jsp" %>

        <div class="right">
            <div id="notice" style="background:#f8f9fa;"></div>
            <span id="todo"></span>
            <span id="approval"></span>
        </div>
 <!--메인메뉴쿼리  -->
		<script>
			$(function(){
				$('#notice').load('./notice/notice.jsp','#notice');
			});
		</script>
		<!-- 풋터 부분 include -->
        <%@ include file="common/COO_footer.jsp" %>
    </div>
</body>
</html>