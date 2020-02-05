<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 일정 추가</title>

    <link rel="stylesheet" href="/semi/resources/css/Calendar/calendar_add.css">
</head>
<body>
    <div id="total">
        <div id="addArea">
            <input type="text" id="addtitle" placeholder="제목">

            <br><br><br><br>

            <span class="span1">시작</span>
            <input id="start" type="date"> <br><br><br>  
            <span class="span1">종료</span>
            <input id="end" type="date"> <br><br><br>

            <span class="span1">내용</span> <br>
            <textarea cols="47" rows="7"></textarea>

            <!-- 버튼 기능 추가해야됨 -->
            <button onclick="add();" class="btn">추가</button>
            <button onclick="window.close();" class="btn">취소</button>
        </div>

    </div>

    
</body>
</html>