<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 비밀번호 변경</title>

    <link rel="stylesheet" href="/semi/resources/css/pwdChange/pwdChangeCss.css">
    <script src="/semi/resources/js/pwdChange/pwdChange.js"></script>
    <style>
    
    	/* header{
    		background-color : #A9D0F5;
    		
    		
    	} */
    	
    	/* table{
    		border : 1px solid black;
    	} */
    	
    	
  
    	th,td{
    		border : 0px solid black;
    		
   			 padding: 10px;
    	}
    	
    	
    </style>
</head>
<body>
    <!-- <div class="totalArea">
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
            </form> 
            </div>-->
            <!-- <div alert="center">
             <form method="post" onsubmit="return submit2();">
                <h3>회원 정보 수정 </h3>
                <br>
                <h4>회원 확인</h4>
                <h5>이름</h5>
                
                <input type="text" id="userId" class="text">
                
                <h5>비밀번호</h5>
                <input type="password" id="changePwd1" class="text" minlength="8" maxlength="12">
                <hr>
                
                <h4>비밀번호 수정</h4>
                <h5>비밀번호</h5>
                <br>
                <input type="password" id="changePwd1" class="text" minlength="8" maxlength="12">
               
                <h5>비밀번호 확인</h5>
                
               		 <input type="password" id="changePwd2" class="text" minlength="8" maxlength="12">
					<BR>
           			 <input type="submit" value="변경" id="submitBtn">
           		 <button id="cancelBtn" onclick="cancel();">종료</button>
        	</form>
   		 </div> -->
   		 
   		 
   		 
   		 <header >
   		 
   		 	<h2 style="color:#A9D0F5"  >회원 정보 수정 </h2>
   		 </header>
   		 <hr>
   		 
   		 <section align="center">
   		 	
   		 			<table>
   		 				<tr>
   		 					<td colspan="1" style="border:0px solid white; " align="left" >
   		 					
			   		 		<h3>회원 정보 확인</h3>
			   		 		</td>
			   		 	</tr>
   		 				<tr>
   		 				
   		 					<td align="right">
   		 					<h5><span style="color:red;">* </span> 아이디<input type="text" id="userId" class="text" style="border-radius:4px"></h5>
   		 					
   		 					</td>
   		 				</tr>
   		 				<tr>
   		 					<td align="right">
   		 					<h5><span style="color:red;">* </span> 비밀번호<input type="password" id="userPwd" class="text" style="border-radius:4px"></h5>
   		 				
   		 					</td>
   		 				
   		 			
   		 				<tr>
   		 				
   		 					<td colspan="1" style="border : 0px solid white;" align="left"><h3> 비밀번호 수정</h3>
   		 					</td>
   		 				</tr>
   		 				
   		 				<tr>	
   		 					<td align="right">
   		 						<h5><span style="color:red;">* </span> 수정할 비밀번호<input type="password" id="changePwd1" class="text" minlength="8" maxlength="12"
   		 						style="border-radius:4px"></h5>
   		 					</td>
   		 					
   		 				</tr>
   		 				
   		 				<tr>
   		 					<td align="right">
   		 						<h5><span style="color:red;">* </span> 비밀번호 확인<input type="password" id="changePwd2" class="text" minlength="8" maxlength="12" 
   		 						style="border-radius:4px"></h5>
   		 					</td>
   		 					
   		 				</tr>
   		 				
   		 			</table>
   		 	
   		 	
   		 	
   		 	
   		 </section>

   		 		<input type="submit" value="변경" id="submitBtn" style="background-color:#A9D0F5; color:white;" >
           		<button id="cancelBtn" onclick="cancel();" style="color:black;">취소</button>
           		<br><br><br>
    
</body>
</html>