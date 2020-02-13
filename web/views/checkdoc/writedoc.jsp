
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
    <link rel="stylesheet" href="/semi/resources/css/notice/button.css"><!-- 1순위 -->
    <script
    src="https://code.jquery.com/jquery-3.4.1.min.js"
    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
    crossorigin="anonymous"></script>
    
    <script type="text/javascript" src="/semi/views/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
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
                        <label>부서 : </label><input type="text" class="inputRight" readonly name="deptcode" value= "<%=m.getDeptTitle()%>">
                        <br>
                        <label>작성일자 : </label><input type="text" class="inputLeft" name= "docdate" id="docdate" readonly>
                        <label>보존기한 : </label><input type="text" class="inputRight" value="영구보존" readonly>
                    </fieldset>
                    <br>
                    <label id = "setLine">결재선 지정</label>
                    <fieldset class="toField" style ="height:300px;" >
                        <legend>2. 결재선</legend>
                      <div id="lineList" >
                      <div>
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
                                <td colspan= 3 class="people"></td>
                            </tr>
                        </tbody>

                        
                    </table>
                   
                   
                     <input type="hidden" name ="checkdept" class ="checkdept" id="chdept">
                     <input type="hidden" class ="hiddenper" class ="checkper" id="chper">
                    <input type="text" name ="checkper"  class="perend">
					</div>
                   
                   <div>
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
                              <input type="text" name ="coldept " class ="coldept" id="codept1">
                             <input type="text" class ="hiddenper" id="cope">
                            
                             <input type="text" name ="colper" class ="perend" >
                             </div>
                             <div>
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
                                        <td class="people" colspan="3"></td>
                                    </tr>
                                    </tbody>
                                </table>
                                  <!--<input type="text" name ="checkper" class ="hiddenper">-->
                                <input type="text" name ="enddept " class ="enddept" id="enddept1">
                                <input type="text" class ="hiddenper" id="endp">
                                <input type="text" name ="endper" class ="perend" >
                    </div>
                     <div>
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
                                        <td class="people" colspan="3"></td>
                                 </tr>
                                </tbody>
                            </table>
                              <!--<input type="text" name ="checkper" class ="hiddenper">-->
                            <input type="text" name ="viewper" class ="hiddenper1 perend" id=viewp>
                      </div>
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
                    
                    $(".hiddenper").on("click",function(){
                    	var imhidden = $(this);
                      
                    	$.ajax({
                    		url:"/semi/sEName.ch",
                    		type:"get",
                    		data:{
                    			pcodes : $(this).val(),
                    			deptname : $(this).prev().val()
                    		},
                    		success: function(data){
                    			var dept = data["list1"];
                    			var pcodes = data["list2"];
                    			var pnames = data["list3"];
/*                     			console.log(dept);
                    			console.log(pcodes);
                    			console.log(pnames);
                    			console.log(imhidden.prev());
                    			
                    			console.log(imhidden.prev().prev().find(".people")); */
                    			imhidden.prev().val(dept);
                    			var a = imhidden.prev().prev().find(".people").html("")
                    			for(var i = 0; i< pnames.length; i = i+2){
                    				var a = imhidden.prev().prev().find(".people").html()
                    				
                    				var label = "<div onclick='delperson(this);' class ='person'><input type='hidden' value="+i+"> 정 : " + pnames[i] +"<br> 부 : " +pnames[i+1]+"</div>";
                    				imhidden.prev().prev().find(".people").html( a + "&nbsp"+ label);
                    			}
                    			imhidden.next().val(pcodes.join());
                    			
                    		},
                    		erorr :function(){
                    			alert("에러")
                    		}
                    		
                    	})
                    	
                    	
                  		
                   });
                    $(".hiddenper1").on("click",function(){
                    	var imhidden = $(this);
                      
                    	$.ajax({
                    		url:"/semi/sECName.ch",
                    		type:"get",
                    		data:{
                    			pcodes : $(this).val()
                    		},
                    		success: function(data){
                    			console.log(data);
                    			var list= data;
                    			for(var i = 0; i< list.length; i ++){
                    				console.log("확인")
                    				var a = imhidden.prev().find(".people").html()
                    				var label = "<div onclick='delvperson(this);' class ='person'><input type='hidden' value="+i+"> 부서 : " + data[i].deptName +"<br> 부 : " +data[i].empName+"</div>";
                    				imhidden.prev().find(".people").html( a + "&nbsp"+ label);
                    			}
                    			
                    		},
                    		erorr :function(){
                    			alert("에러")
                    		}
                    		
                    	})
                    });
                    function delperson(i){
                    	
                    if(confirm( i.innerText +" 결제선을 삭제하시겠습니까?")){
                        var indext = parseInt($(i).find("input").val());
                        var cut = $(i).parents("table").siblings(".perend").val().split(",");
                        console.log(indext);
                        cut.splice(indext,2);
                        $(i).parents("table").siblings(".perend").val(cut);
                        var child =$(i).parent().children("div");
                        var check = child[1];
                        
                       for(var k = indext+1; k< child.length; k++){
                    	   $(child[k]).children("input").val(k-1)
                    	   console.log($(child[k]).children("input").val());
                       }
                       i.remove();
                    }
                   }
                    
                    function delvperson(i){
                    	
                        if(confirm( i.innerText +" 결제선을 삭제하시겠습니까?")){
                            var indext = parseInt($(i).find("input").val());
                            var cut = $(i).parents("table").siblings(".perend").val().split(",");
                            console.log(indext);
                            cut.splice(indext,1);
                            $(i).parents("table").siblings(".perend").val(cut);
                            var child =$(i).parent().children("div");
                            var check = child[1];
                            
                           for(var k = indext+1; k< child.length; k++){
                        	   $(child[k]).children("input").val(k-1)
                        	   console.log($(child[k]).children("input").val());
                           }
                           i.remove();
                        }
                       }
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
					
					<textarea name="ir1" id="contents" rows="10" cols="100"
									style="width:100%; height:550px; min-width:610px; display:none;"></textarea>
                    </div>
                </fieldset>

                </div>
				<input type = "submit">
            </form>
        </div>

    </div> 
    
    <script>
    	$('#btn_1')
    </script>
    <script type="text/javascript">
    
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "contents",
	 sSkinURI: "/semi/views/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
	
	  function goSaveAndSubmit(){
	    
	   oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD",[]);
	   
	   $('#gosubmit').submit();

	   }
       


    </script>

</body>
</html>