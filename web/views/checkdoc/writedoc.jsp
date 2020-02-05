<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%//세션값만 받아오기
    
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
                        <label> &nbsp;&nbsp;&nbsp;작성자 : </label><input type="text" class="inputLeft" disabled name ="docwriter" <%//세션에서 작성자 %>>
                        <label>부서 : </label><input type="text" class="inputRight" disabled name="deptcode" <%//세션에서 부서%>>
                        <br>
                        <label>작성일자 : </label><input type="text" class="inputLeft" name= "docdate" id="docdate" disabled>
                        <label>보존기한 : </label><input type="text" class="inputRight" value="영구보존" disabled>
                    </fieldset>
                    <br>
                    <label id = "setLine">결재선 지정</label>
                    <fieldset class="toField" style ="height:300px;" >
                        <legend>2. 결재선</legend>
                       <div id="lineList" >
                        <table> 
                            <tbody>
                            <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                            </tr>
                            <tr>
                                <td width ="80px">결재부서</td>
                                <td class ="deptview">기획부</td>
                            </tr>
                            <tr>
                                <td style="height: 40px;">결재자</td>
                                <td class="people"></td>
                            </tr>
                        </tbody>

                        
                    </table>
                   
                    <input type="hidden" class ="hiddenper">
                    <input type="hidden" name ="checkdept" class ="checkdept">
                    <input type="hidden" name ="checkper" class ="checkper">
                        <table>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr >
                                        <td width ="80px" >합의/수신</td>
                                        <td class ="deptview" colspan="3"><%//어디선가 끌고오겠지 %></td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="height: 40px;">결재자</td>
                                        <td colspan="3" class="people"></td>
                                    </tr>
                                </tbody>
                            </table>
                             <!--<input type="text" name ="checkper" class ="hiddenper">-->
                             <input type="hidden" class ="hiddenper">
                             <input type="hidden" name ="coldept " class ="coldept">
                             <input type="hidden" name ="colper" class ="colper">
                            <table> 
                                <tbody>
                                    <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 40px;">최종결재자</td>
                                        <td class="people2" colspan="3"></td>
                                    </tr>
                                    </tbody>
                                </table>
                                  <!--<input type="text" name ="checkper" class ="hiddenper">-->
                                <input type="hidden" class ="hiddenper1">
                                <input type="hidden" name ="endper" class ="endper">
                    
                        <table>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr >
                                        <td style="height: 40px;">참조자</td>
                                        <td class="people2" colspan="3"></td>
                                 </tr>
                                </tbody>
                            </table>
                              <!--<input type="text" name ="checkper" class ="hiddenper">-->
                             <input type="hidden" name ="viewper" class ="hiddenper1">
                            <input type="hidden" name ="viewper" class ="viewper">
                    </div>
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