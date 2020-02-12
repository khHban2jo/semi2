
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.Member"%>
    <%
    	
    	Member m = (Member)session.getAttribute("member");
    
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
            <form action="<%= request.getContextPath() %>/cInsert.ch" method="post" enctype="multipart/form-data">
                
                <div class="areaLeft">
                    <h2 id ='doctype1'>품의서</h2>
                    <h2 id ='doctype2'>결의서</h2>
                    <h2 id ='doctype3'>휴가신청서</h2>
                    <input type="text" name="doctype" id="type1">


                    <fieldset class="writerField">
                        <legend>1. 작성자</legend>
                        <label> &nbsp;&nbsp;&nbsp;작성자 : </label><input type="text" class="inputLeft" readonly name ="docwriterName" value ="<%=m.getEmpName() %>">
                        <input type ="hidden" name ="empcode" value ="<%=m.getEmpCode() %>">
                        <label>부서 : </label><input type="text" class="inputRight" readonly name="deptcode" value= "<%=m.getDeptCode()%>">
                        <br>
                        <label>작성일자 : </label><input type="text" class="inputLeft" name= "docdate" id="docdate" readonly>
                        <label>보존기한 : </label><input type="text" class="inputRight" value="영구보존" readonly>
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
                                <td class ="deptview" id="indept"></td>
                            </tr>
                            <tr>
                                <td style="height: 40px;">결재자</td>
                                <td class="people"></td>
                            </tr>
                        </tbody>

                        
                    </table>
                   
                    <input type="hidden" class ="hiddenper">
                    <input type="text" name ="checkper" class ="checkper" id="chper">
                    <input type="text" name ="checkdept" class ="checkdept" id="chdept">
                   
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
                                        <td class ="deptview" colspan="3" id="colladept"></td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="height: 40px;">결재자</td>
                                        <td colspan="3" class="people"></td>
                                    </tr>
                                </tbody>
                            </table>
                             <!--<input type="text" name ="checkper" class ="hiddenper">-->
                             <input type="text" class ="hiddenper" id="cope">
                             <input type="text" name ="coldept " class ="coldept" id="codept">
                             <input type="hidden" name ="colper" class ="colper" >
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
                                <input type="text" class ="hiddenper" id="endp">
                                <input type="hidden" name ="endper" class ="endper" >
                    
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
                            <input type="text" name ="viewper" class ="hiddenper1" id=viewp>
                            <input type="hidden" name ="viewper" class ="viewper" >
                    </div>
                    </fieldset>
                    <br>
                    <fieldset style= "height :140px;">
                        <legend>첨부파일 </legend>
                        <input type="file"value ="파일 업로드" id="upload" name ="fileup" multiple>
                        <div id = "filenames" style ="height : 130px; font-size:14px;"></div>
                        
                    </fieldset>
                    <script>
                    $("#upload").change(function(){
                      var fileset = $(this).get(0);
                      filestext= document.getElementsByClassName("ddd");
                      console.log(fileset)
                           if(fileset.files.length <6){
                              for(var i =0; i<fileset.files.length; i++ ){
                                  if(fileset.files[i].size <=10485760){
                                   	   document.getElementById("filenames").innerHTML += fileset.files[i].name +"<br>";
                                    	   filestext[i].value =fileset.files[i].name; 
                                  }else{
                                      alert(fileset.files[i].name +" 의 크기가 너무 큽니다. 파일1개의 최대 크기는 10mb입니다." );
                                      $(this).val("");
                                      
                                  }
                           }
                           }else{
                               alert("파일은 5개 까지 가능합니다.");
                               $(this).val("");
                               
                       }
                      
                    console.log($("#filenames").html());

                  	});
                    
                    
                    </script>
                </div>
                <div class="areaRight">
                    <fieldset>
                        <legend>제목</legend>
                        <input type ="text" size="80" align = "center" name="doctitle">
                  
                    </fieldset>

                    <fieldset>
                    <div id="docbody">
                         <!-- 인클루드 용-->    
					<textArea cols="20" rows="20" name="text"></textArea>

                    </div>
                </fieldset>

                </div>
				<input type = "submit">
            </form>
        </div>

    </div> 
    <script>
       


    </script>

</body>
</html>