var date = new Date();

$(function(){

    $("#docdate").val()
    //품의서 버튼
    $("#btn_1").click(function(){
        $("#doctype1").css("display","block");
        $("#doctype2").css("display","none");
        $("#doctype3").css("display","none");
        $("#type1").val("품의서");
        $("#docbody").html( '<textarea name="ir1" id="txtav" rows="6" cols="100" style="height:500px;"></textarea>'
        );
        

        	
    });
    //결의서 버튼
    $("#btn_2").click(function(){
        $("#doctype1").css("display","none");
        $("#doctype2").css("display","block");
        $("#doctype3").css("display","none");
        $("#type1").val("지출결의서");
    
      	 $("#docbody").html('<label id ="tdplus" class="buttonla labu" > + </label> &nbsp; <label id="tdminus" class="buttonla labu"> - </label>'+
      	        '&nbsp;&nbsp;&nbsp;&nbsp;<label id="checkpay" class="buttonla">자동금액계산</label>'+
      	        '<div id="paid">'+
      	         '최종금액 :<label id= "endpay"></label>'+'<input type="hidden" name="endpay" id="paide">'+
      	        '<table>'+
      	           ' <thead><tr><td>번호</td><td>물품명</td><td>단가</td><td>수량</td><td>단위</td><td>금액</td><td>비고</td></tr></thead>'+
      	            '<tbody id="textm">'+
      	                '<tr>'+
      	                '<td><label class="no">1</label></td>'+
      	                '<td><input type="text" size ="15 maxlength="15"></td>'+
      	                '<td><input type="text" size ="12" maxlength="12"  value ="0" class="money num" min="0" max="99999999"></td>'+
      	                 '<td><input type="number"  value ="0" class="su num" min="0"></td>'+
      	                '<td> <input type="text" size ="5" maxlength="5"  > </td>'+
      	                '<td > <input type="text" size ="20" maxlength="20" value ="0" class="pay num" > </td>'+
      	                '<td><input type="text" size ="15" maxlength="15"> </td>'+
      	                '</tr>'+
      	            '</tbody>'+
      	        '</table>'+
      	    	 '<textarea name="ir1" id="txtav" rows="6" cols="70" style=" width:640px; height:200px;"></textarea>'+'<div>'
 );
      	 
      	$("td").click(function(){
      	  $(".su").on({
      	       "click":function(){
      	           $(this).val("");
      	       },
      	      "blur":function(){ 
      	        
      	          var aa =$(this).val();
      	          if(isNaN( Number(aa))){
      	              alert("숫자만");
      	              $(this).val(0);
      	              $(this).select();
      	          }
      	          var a = parseInt($(this).val());
      	          var b = parseInt($(this).parent().prev("td").children(".money").val());
      	          $(this).parent().siblings("td").eq(4).children(".pay").val(a*b); 
      	      }
      	  });
      	});
   
   
  
  $("#tdplus").on("click",function (){
      if($("#textm").children("tr").length<10){

    	 
      var a ='<tr><td><label class="no">'+($("#textm").children("tr").length+1)+'<label></td>'
              +' <td><input type="text" size ="15 maxlength="15"></td>'
              +' <td><input type="text" size ="12" maxlength="12"  value ="0" class="money num" min="0" max="99999999"></td>'
              +' <td><input type="number"  value ="0" class="su num" min="0"></td>'
              +' <td><input type="text" size ="5" maxlength="5"  ></td>'
              +' <td><input type="text" size ="20" maxlength="20" value ="0" class="pay num" ></td>'
              +' <td><input type="text" size ="15" maxlength="15"></td></tr>'

              $("#textm").append(a);
          }
  }  );      
  
  $("#tdminus").on("click",function (){
      var a =$("#textm").children("tr").length;
      if(a>1){
          $("#textm").children("tr").eq(a-1).remove();
      }
      
  });
  
  $("#checkpay").on("click",function (){
      var a =$("#textm").children("tr");
      var b = 0;
      
       for(var i =0; i<a.length; i++){
    	   var c = Number(a.eq(i).find(".su").val());
    	   var d = Number(a.eq(i).find(".money").val());
    	   
    	   if(isNaN(c)||isNaN(d)){
    		   alert("숫자가 아닌 값이 있습니다, 확인해주세요");
    	   };
    	   a.eq(i).find(".pay").val(c*d);
         b += parseInt(a.eq(i).find(".pay").val());
       }
       console.log(b);
       $("#endpay").text(b);

  	});		
  
 
   
    });
    
    
    
    //휴가 신청서
    $("#btn_3").click(function(){
    	
        $("#doctype1").css("display","none");
        $("#doctype2").css("display","none");
        $("#doctype3").css("display","block");
        $("#type1").val("휴가신청서");
        console.log();
        $("#docbody").html(
   			 	'<span>휴가 종류</span>'+
   	         '<select name="leaveCode" id="leaveCode" >'+
   		   '<option value="">---</option>'+
   		   '<option value="L1">연차</option>'+
   		   '<option value="L2">월차</option>'+
   		    '<option value="L3">반차</option>'+
   		'</select>'+
   		'<br><br>'+
   		'<span class="startDate">시작(사용) 날짜</span>'+
   		'<input type="date" name="startDate" id="startDate" class="startDate">'+
   		'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
   		'<span class="endDate">종료 날짜</span> '+      
   		'<input type="date" name="endDate" class="endDate" id= "endDate">'+
   		'<br><br>'+
   		'<span class="dayOffType">반차 종류</span>'+
   		'<select name="dayOffType" id="dayOffType" class="dayOffType">'+
   		    '<option value="N">---</option>'+
   		   '<option value="A">오전</option>'+
   		   '<option value="P">오후</option>'+
   		'</select>'+
   		'<br><br>'+
   		'<span>휴가 사유</span> <br><br>'+
   	 '<textarea name="ir1" id="txtav" rows="6" cols="100" style="height:300px;"></textarea>'
   		
   	
   	 
   	);
   	
   	$('#leaveCode').change(function(){
	    if( $('#leaveCode').val()=="L1" ){
	        $('.dayOffType').css('visibility','hidden');
	        $('.endDate').css('visibility','visible');
	        $('.startDate').css('visibility','visible');
	    }else if( $('#leaveCode').val()=="L2" ){
	        $('.dayOffType').css('visibility','hidden');
	        $('.endDate').css('visibility','hidden');
	        $('.startDate').css('visibility','visible');
	    }else if( $('#leaveCode').val()=="L3" ){
	        $('.endDate').css('visibility','hidden');
	        $('.dayOffType').css('visibility','visible');
	        $('.startDate').css('visibility','visible');
	    }else{
	        $('.dayOffType').css('visibility','visible');
	        $('.endDate').css('visibility','visible');
	        $('.startDate').css('visibility','visible');
	    }
                         });   
   	
   	

   		});
    
    
  
    });
    
   
    
    
    
    //작성일자
    var month;
    if((date.getMonth()+1).length =1){
       month= "0"+(date.getMonth()+1)
    }else{
        (date.getMonth()+1)
    }
    $("#docdate").val(date.getFullYear()+"-"+month+"-"+date.getDate());



    //결재자체크 버튼
function setline(){
    window.open("checkpeople.jsp","childform","target : _blank");

}
		



	//	휴가 신청서 include용 script
function leaveCode(item){
	$(item).change(function(){
	    if( $('#leaveCode').val()=="L1" ){
	        $('.dayOffType').css('visibility','hidden');
	        $('.endDate').css('visibility','visible');
	        $('.startDate').css('visibility','visible');
	    }else if( $('#leaveCode').val()=="L2" ){
	        $('.dayOffType').css('visibility','hidden');
	        $('.endDate').css('visibility','hidden');
	        $('.startDate').css('visibility','visible');
	    }else if( $('#leaveCode').val()=="L3" ){
	        $('.endDate').css('visibility','hidden');
	        $('.dayOffType').css('visibility','visible');
	        $('.startDate').css('visibility','visible');
	    }else{
	        $('.dayOffType').css('visibility','visible');
	        $('.endDate').css('visibility','visible');
	        $('.startDate').css('visibility','visible');
	    }
	});
}	

