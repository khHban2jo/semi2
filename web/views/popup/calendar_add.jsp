<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 일정 생성</title>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/semi/resources/css/ccalendar/calendar_add.css">
    



    
    
    <script>
		$(function(){ // 팝업창 닫히고 이전 페이지로 이동완료
			$('#createBtn').click(function(){
				window.opener.location.reload();
				window.close();
			});
		}); 
    </script>
    
</head>
<body onresize="parent.resizeTo(480,580)" onload="parent.resizeTo(480,580)">
<div id="totalSize">
    <form action="/semi/InsertSchedule.do" method="post"> 
    <div id="total">
        <div id="addArea">
            <input type="text" id="addtitle" name="addtitle" placeholder="일정 제목을 입력하십시오">

            <br><br><br><br>

            <span class="span1">시작일</span>
            <input id="start" name="calendarStart" type="date"> <br><br>  
            <span class="span1">종료일</span>
            <input id="end" name="calendarEnd" type="date"> <br><br>

            <span class="span1">일정 내용</span><br>
            <textarea cols="41" name="calendarContent" rows="6"></textarea>

            <!-- 생성된 일정을 다시 누르면 추가 버튼이 수정 버튼으로/ 취소버튼이 삭제버튼으로 if()-->
            <button onclick="add();" id="createBtn" class="btn">생성</button>
         	<button onclick="window.close();" class="btn">취소</button>
            
           
        </div>
    </div>
	</form>
</div>
    
</body>
</html>