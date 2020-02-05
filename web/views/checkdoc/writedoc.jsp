<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	//com.coo.modelvo.member
    	//Member m = (Member)session.getAttribute("member");
    
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>COO - 전자결재</title>
    <link rel="stylesheet" href="/semi/resources/css/checkdoc/checkwrite.css">
    <script
    src="https://code.jquery.com/jquery-3.4.1.min.js"
    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
    crossorigin="anonymous"></script>
    <script src = "/semi/resources/js/checkdoc/checkwrite.js"></script>

    <style>
      


    </style>
</head>
<body>
    <div class="total"> 
        <button id="btn_1" class="btn">품의서</button>
        <button id="btn_2" class="btn" >결의서</button>
        <button id="btn_3" class="btn">휴가신청서</button>
        
        
        <hr>
        
        <div id="area1" class="area">
            <form action="">
                
                <div class="areaLeft">
                    <h2 id ='doctype1'>품의서</h2>
                    <h2 id ='doctype2'>결의서</h2>
                    <h2 id ='doctype3'>휴가신청서</h2>
                    <input type="hidden" name="doctype">


                    <fieldset class="writerField">
                        <legend>1. 작성자</legend>
                        <label> &nbsp;&nbsp;&nbsp;작성자 : </label><input type="text" class="inputLeft" disabled name ="docwriter" value ="<%//세션에서 작성자 %>">
                        <input type ="hidden" name ="empno" value ="<%//세션에서 no %>">
                        <label>부서 : </label><input type="text" class="inputRight" disabled name="deptcode" <%//세션에서 부서%>>
                        <br>
                        <label>작성일자 : </label><input type="text" class="inputLeft" name= "docdate" id="docdate" disabled>
                        <label>보존기한 : </label><input type="text" class="inputRight" value="영구보존" disabled>
                    </fieldset>
                    <br>
                    <label id = "setLine">결재선 지정</label>
                    <fieldset class="toField" style ="height:300px;" >
                        <legend>2. 결재선</legend>
                      <%@include file="writeinclude.jsp" %>
                    </fieldset>
                    <br>
                    <fieldset style= "height :140px;">
                        <legend>첨부파일 </legend>
                        <input type="file"value ="파일 업로드" id="upload" name ="fileup" multiple>
                        <div id = "filenames" style ="height : 130px; font-size:14px;"></div>
                    </fieldset>

                </div>
                <div class="areaRight">
                    <fieldset>
                        <legend>제목</legend>
                        <input type ="text" size="80" align = "center" name="doctitle">
                    </fieldset>

                    <fieldset>
                    <div id="docbody">
                         <!-- 인클루드 용-->    


                    </div>
                </fieldset>

                </div>

            </form>
        </div>

    </div> 
    <script>
       


    </script>

</body>
</html>