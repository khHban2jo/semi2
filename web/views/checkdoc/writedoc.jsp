
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.Member"%>
    <%
    	
    	Member m = (Member)session.getAttribute("member");
    	String type ="";
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
                    <input type="hidden" name="doctype" id="type1">


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
                   <input type="text" name ="checkdeptC" class ="deptC" >
                   <input type="text" name ="checkdeptN" class ="deptN" id="chdeptN">
                   <input type="text" class ="hiddenper"  id="chper">
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
                             <input type="text" name ="coldeptC" class ="deptC">
                             <input type="text" name ="coldeptN" class ="deptN" id="codeptN">
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
                                     <td width ="80px" >부서</td>
                                        <td class ="deptview" colspan="3" id="endladept"></td>
                                        </tr>
                                    <tr>
                                        <td style="height: 40px;">최종결재자</td>
                                        <td class="people" colspan="3"></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <input type="hidden" name ="enddeptC" class ="deptC">
                                <input type="hidden" name ="enddeptN" class ="deptN" id="enddeptN">
                                <input type="hidden" class ="hiddenper" id="endp">
                                <input type="hidden" name ="endper" class ="perend" >
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
                            <input type="hidden" name ="viewper" class ="hiddenper1 perend" id=viewp>
                      </div>
                    </div>
                    </fieldset>
                    <br>
                    <fieldset style= "height :140px;">
                        <legend>첨부파일 </legend>
                               <div id = "filenames" style ="height : 130px; font-size:14px;">
                        <input type="file"value ="파일 업로드"  name ="fileup0" class ="upload"><label onclick ="delfile();">취소</label>
                 </div>
                        
                    </fieldset>
                    <script>
                    $(function(){
                    	 $("#btn_1").click();
                    	 
                    });
                  
                    
                    var flength = 0;
                    //$(".upload").change(function(){
                      
                      //var files = $(this)
                      //var fileset = $(this).get(0);
                     // console.log(files);
                     // console.log(flength);
                         //  if(flength <5 ){
                                  //if(fileset.files.size <=10*1024*1024){
                                	  //console.log(flength);
                                	  //flength++;
                                	  //var $input = $("<input type='file' name ='fileup"+flength+"'>")
                                	 
                                	//  $input.addClass('upload')
                                	  //var input = "<label class='delfile'>취소</label><br>"
                                	 // console.log(input);
                                	 // $("#filenames").append($input);
                                	 // $("#filenames").append(input);
                                    	 
                                  //}else{
                                      //alert(fileset.files.name +" 의 크기가 너무 큽니다. 파일1개의 최대 크기는 10mb입니다." );
                                      //$(this).val("");
                                  //}                     
                          // }else{
                            //  alert("파일은 5개 까지 가능합니다.");
                           //   $(this).val("");
                              
                     //  }      

                  	//}};
                 // onclick ="delfile();
                    
                    //결재자, 합의자, 최종결재자 이름 가져오기
                    $(".hiddenper").on("click",function(){
                    	var imhidden = $(this);
                      
                    	$.ajax({
                    		url:"/semi/sEName.ch",
                    		type:"get",
                    		data:{
                    			pcodes : imhidden.val(),
                    			deptname : imhidden.siblings(".deptN").val()
                    		},
                    		success: function(data){
 
                    			var dept = data["list1"];
                    			var pcodes = data["list2"];
                    			var pnames = data["list3"];
                    
                    		
                    			imhidden.siblings(".deptC").val(dept);
                    			var a = imhidden.siblings(".table").find(".people").html("")
                    			for(var i = 0; i< pnames.length; i = i+2){
                    				var a = imhidden.siblings("table").find(".people").html()
                    				
                    				var label = "<div onclick='delperson(this);' class ='person'><input type='hidden' value="+i+"> 정 : " + pnames[i] +"<br> 부 : " +pnames[i+1]+"</div>";
                    				imhidden.siblings("table").find(".people").html( a + "&nbsp"+ label);
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
                    	console.log(imhidden);
                    	console.log(imhidden.val());
                      
                    	$.ajax({
                    		url:"/semi/sECName.ch",
                    		type:"get",
                    		data:{
                    			pcodes : imhidden.val()
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
                       
                        
                       for(var k = indext+1; k< child.length; k++){
                    	   $(child[k]).children("input").val(k-1)
                    	   console.log($(child[k]).children("input").val());
                    	  
                       }
                       console.log(child.length);
                       if(child.length==1){
                		  $(i).parents("table").siblings(".deptC").val("");
                		  $(i).parents("table").siblings(".deptN").val("");
                		  $(i).parents("table").find(".deptview").html("");
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
                         <textArea cols="20" rows="20" name="text"></textArea>
						
                    </div>
                </fieldset>

                </div>
				<input type = "submit">
            </form>
        </div>

    </div> 
		<script>
			<%-- $(".btn").change(function(){
				var a
			 if($("#doctype").val()=="품의서"){
				 <%type = "품의서"; %>
				 a="<%=type%>"
			 }else if($("#doctype").val()=="지출결의서"){
				 <%type = "지출결의서"; %>
				 a="<%=type%>"
			 }else if($("#doctype").val()=="휴가신청서"){
				 a = <%@include file="/views/checkdoc/include/vacDoc.jsp" %>
			 }			
			 
			  $.ajax({
				  url:"/semi/writebody.ch",
				  type:"post",
				  success:function(data){
					  console.log(data);
					  
					  $("#docbody").html(a );
				  },
			     error:function(){
					  alert("독바디에러");
				  }
			  });
			}); --%>
		
		</script>

</body>
</html>