
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
    <script type="text/javascript" src="/semi/views/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
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
            <form id="docs"action="<%= request.getContextPath() %>/cInsert.ch" method="post" enctype="multipart/form-data">
                
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
                    <label id = "setLine" onclick="setline()">결재선 지정</label>
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
                                <td style="height: 70px;">결재자</td>
                                <td colspan= 3 class="people"></td>
                            </tr>
                        </tbody>

                        
                    </table>
                   <input type="hidden" class ="hiddenper"  id="chper">
                   <input type="hidden" class ="dept" name = "chdept" id="chdept">
                   <input type="hidden" name ="checkper"  class="perend">
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
                                        <td style="height: 70px;">결재자</td>
                                        <td colspan="3" class="people"></td>
                                    </tr>
                                </tbody>
                            </table>
                               <input type="hidden" class ="dept" name = "codept" id="codept">
                             <input type="hidden" class ="hiddenper" id="cope">
                             <input type="hidden" name ="colper" class ="perend" >
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
                        <label id="fileplus">파일추가</label>
                               <div id = "filenames" style ="height : 130px; font-size:14px;">
                 </div>
                        
                    </fieldset>
                    <script>
                    $(function(){
                    	 $("#btn_1").click();
                    	 
                    });
                  
                    
                    var flength = 0;
                    $("#fileplus").click(function(){
                    
                          if(flength <5 ){
                                	  var $input = $("<input type='file' name ='file"+flength+"'>")
                                	 $input.addClass('upload')
                                	  var input = "<label class = 'delfile' onclick='delfile(this);' >취소</label>"
                                	 $("#filenames").append($input);
                                	  $("#filenames").append(input);
                                	  flength++;
                                	 
                          }else{
                              alert("파일은 5개 까지 가능합니다.");
                             $(this).val("");    
                          }         
                  	});
                    
  
                     	 
                    function delfile(item){
                  	 flength = flength-1;
                   	$(item).prev("input[type=file]").remove();
                 
                   	$(item).siblings("input[type=file]");
                   	for(var i =0; i<flength; i++){
                   		$(item).siblings("input[type=file]").eq(i).attr("name","file" +i);
                   	}
                  	
                   	$(item).remove();
                  	 
                   };

                   
     
                    
                    //결재자, 합의자  이름 가져오기
                    $(".hiddenper").on("click",function(){
                    	var imhidden = $(this);
                      
                    	$.ajax({
                    		url:"/semi/sEName.ch",
                    		type:"get",
                    		data:{
                    			pcodes : imhidden.val(),
                    		},
                    		success: function(data){
                    		
                    			var dept = data["list1"];
                    			var pcodes = data["list2"];
                    			var pnames = data["list3"];
                    			console.log(dept);
                    			console.log(pcodes);
                    			console.log(pnames);
                    			
                    			for(var i = 0; i< pnames.length; i = i+2){
                    				var a = imhidden.siblings("table").find(".people").html();
                    				
                    				
                    				var label = "<div onclick='delperson(this);' class ='person'><input type='hidden' value="+i+">부서:"+dept[i/2] + "<br>정 : " + pnames[i] +"<br> 부 : " +pnames[i+1]+"</div>";
                    				
                    				imhidden.siblings("table").find(".people").html( a + "&nbsp"+ label);
                    			}
                    			imhidden.siblings(".perend").val(pcodes.join());
                    			imhidden.siblings(".dept").val(dept.join());
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
                        var cut2= $(i).parents("table").siblings(".dept").val().split(",");
                       // console.log(cut2);
                        //console.log(indext);
                        cut.splice(indext,2);
                        cut2.splice(indext/2,1);
                        //console.log(cut2);
                        //console.log(cut2.splice(indext,1));
                        $(i).parents("table").siblings(".perend").val(cut);
                        $(i).parents("table").siblings(".dept").val(cut2);
                        var child =$(i).parent().children("div");
                       
                        
                       for(var k = indext+1; k< child.length; k++){
                    	   $(child[k]).children("input").val(k-1)
                    	   console.log($(child[k]).children("input").val());
                    	  
                       }
                       if(child.length==1){
                		  $(i).parents("table").siblings(".dept").val("");
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
                  
						
                    </div>
                </fieldset>

                </div>
                <input type="hidden" name="text" id="fulling">
				 
            </form>
           <input type = "submit" id="gsubmit" value="전송" >
            <!--  <button onclick = "gsubmit();">asdads</button>-->
        </div>
			
    </div> 
		<script>
		$(function(){
			
		   	
		  $("#gsubmit").click(function() {	
			if($("#type1").val() =="지출결의서"){
				var a =$("#textm tr");
				 var pay = 0;
				for(var i = 0; i<a.length; i++){
					var b = $("#fulling").val();
				/* 	console.log(a.eq(i).find("label").text());
					console.log(a.eq(i).find("input:eq(0)").val());
					console.log(a.eq(i).find("input:eq(1)").val());
					console.log(a.eq(i).find("input:eq(2)").val());
					console.log(a.eq(i).find("input:eq(3)").val());
					console.log(a.eq(i).find("input:eq(4)").val());
					console.log(a.eq(i).find("input:eq(5)").val()); */
					 pay += parseInt(a.eq(i).find(".pay").val());
					$("#fulling").val(b+a.eq(i).find("label").text()+","
							+a.eq(i).find("input:eq(0)").val()+","+a.eq(i).find("input:eq(1)").val()+","
							+a.eq(i).find("input:eq(2)").val()+","+a.eq(i).find("input:eq(3)").val()+","
							+a.eq(i).find("input:eq(4)").val()+","+a.eq(i).find("input:eq(5)").val()+"/+/");
				}
				var c = $("#fulling").val();
				$("#paide").val(pay);		
				$("#fulling").val(c+pay);
			
			}else if($("#type1").val() =="휴가신청서"){
				var edate = $("#endDate").val();
				var b = $("#dot").val();
			
				console.log();
				if($("#endDate").val()== ""){
					edate = $("#startDate").val();
				}
				
				$("#fulling").val($("#leaveCode").val()+"/+/"+$("#startDate").val()+"/+/"+edate+"/+/"+$("#dayOffType").val());
			}
			
			$("#docs").submit();
		
			opener.document.location.reload();

			self.close();
		
	  });
		});
		</script>
		


</body>
</html>