<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 비밀번호 변경</title>

    <link rel="stylesheet" href="/semi/resources/css/pwdChange/pwdChangeCss.css">
    <script src="/semi/resources/js/pwdChange/pwdChange.js"></script>
</head>
<body>
    <div class="totalArea">
        <form method="post" onsubmit="return submit2();">
            <fieldset class="field1">
                <legend>회원 정보</legend>
                <ul>
                    <li>
                       	 아이디 : <br>
                        <input type="text" id="userId" class="text">
                    </li>
                    <br>
                    <li>
                       	 비밀번호 : <br>
                        <input type="password" id="userPwd" class="text">
                    </li>
                </ul>
            
            </fieldset>
            <br>
            <fieldset class="filed2">
                <legend>비밀번호 수정</legend>
                <ul>
                    <li>
                       	비밀번호 : <br>
                        <input type="password" id="changePwd1" class="text" minlength="8" maxlength="12">
                    </li>
                    <br>
                    <li>
                       	비밀번호 확인 : <br>
                        <input type="password" id="changePwd2" class="text" minlength="8" maxlength="12">
                    </li>
                </ul>
            </fieldset>

            <input type="submit" value="변경" id="submitBtn">
            <button id="cancelBtn" onclick="cancel();">종료</button>
        </form>
    </div>

    
</body>
</html>