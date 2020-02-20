$(function(){
	


   $("ol>ul").slideUp();

   $(".foldall").on("click",function(){
       if($(this).val() == '+'){
           $(".de").css("display","block");
           $(this).val('-');
           $(".fold").val('-');
       }else{
           $(".de").css("display","none");
           $(this).val('+');
           $(".fold").val('+');
       }
   });

   //선택되 테이블 체크
   $(".line table").on("click","tr",function(){
       $("td").css('background','white');
       $(this).children().css("background",'yellowgreen');

       //정보 저정
       $(this).parents("div").siblings().filter(".inindex").val($(this).index());
       $(this).parents("div").siblings(".inhtml").val("<tr>"+$(this).html()+"</tr>"); 
         
   });
  
   //체크박스

   $("#peoplemap input[type=checkbox]").on("click",function(){
       //만약 체크했는데 이전 체크가 된것들이 있으면 해재 
       if($(this).prop("checked")){
           $(this).parent().next("ul").children().children("input[type=checkbox]").filter(":checked").each(function(index,item){
               item.click();
 
            })
       //만약 체크를 풀었는데 이전 체크가 안된것들 있으면 우선 체크   
       }else{ $(this).parent().next("ul").children().children("input[type=checkbox]").not(":checked").each(function(index,item){
               item.click();
            })}
            //그리고 전부 다시 누르기
           $(this).parent().next("ul").children().children("input[type=checkbox]").each(function(index,item){
               item.click();
           })
           
   });


   $("#peoplemap label").on("click",function(){
       $(this).prev("input[type=checkbox]").click();
   });
   
   $(".all").click(function(){
       if($(this).prop("checked")){
           $(this).parent().siblings().children().children("input[type=checkbox]").filter(":checked").each(function(index,item){
               item.click();
            })
           }else{
           $(this).parent().siblings().children().children("input[type=checkbox]").not(":checked").each(function(index,item){
               item.click();
            })
          
       }
       $(this).parent().siblings().children().children("input[type=checkbox]").each(function(index,item){
               item.click();
           });

          
   });
   
   var codeRemove= function(i){
	   //중복인원 제거용 함수
	   var tr = $(i).siblings("div").find("tr")
	   tr.each(function(index,item){
		   var ch = $(this).children("td").eq(0).text();
		   $('#selectper tr:contains('+ch+')').remove();         
	   });	
   }
   
   var tablem = function(j){
	   //원본 베이블 저장
      
       //저장후 추가
       for(var i= $("#selectper tbody").find("tr").length-1; i >=0; i--){
    	   var origin = $(j).siblings("div").find("tbody").html();
    	   var inp = "<tr>" + $("#selectper tbody").find("tr").eq(i).html() +"</tr>";
   
    	   $(j).siblings("div").find("tbody").html(origin + inp);
       }
       $("#selectper tbody").html("");
	   //체크 풀기
	   $("#map input[type=checkbox]").prop("checked","");
	   
   }
   
   
   $(".enter").click(function(){
	   
       //기존 배열과 확인후 삭제
       var tr = $(this).siblings("div").find("tr");
       if(tr.length<4){
    	   codeRemove($(this));
    	   tablem($(this));
       }
   });

   
   $(".venter").click(function(){
       
       //기존 배열과 확인후 삭제
       var tr = $(this).siblings("div").find("tr");
       if(tr.length>0){
    	   
    	   codeRemove($(this) );
       }
       
       tablem($(this));
   	});


   //위 버튼
   $(".up").click(function(){
       ind = $(this).siblings(".inindex").val();
       $(this).siblings(".inhtml").val();
       
       
       if( $(this).siblings(".inindex").val() >=1){

       //제거
       $($(this).siblings("div").find("tr")).eq(ind).remove();

       //인덱스 -1 추가   
       $($(this).siblings("div").find("tr")).eq(ind-1)
       .before($(this).siblings(".inhtml").val());
       //저장인덱스 변경
       $(this).siblings(".inindex").val(ind -1);
       //클릭
       $($(this).siblings("div").find("tr")).eq($(this).siblings(".inindex").val()).click();
       }
   });


   //아래 버튼
$(".down").click(function(){
    ind = $(this).siblings(".inindex").val();

    $(this).siblings(".inhtml").val();

    if( -1<$(this).siblings(".inindex").val()&&
        $(this).siblings(".inindex").val() < $($(this).siblings("div").find("tr")).length-1){

       $($(this).siblings("div").find("tr")).eq(parseInt(ind)).remove();
       $($(this).siblings("div").find("tr")).eq(ind)
       .after($(this).siblings(".inhtml").val());
       
       $(this).siblings(".inindex").val(parseInt(ind)+1);
       $($(this).siblings("div").find("tr")).eq($(this).siblings(".inindex").val()).click();
   }

    
});
//제거
$(".drop").click(function(){
    ind = $(this).siblings(".inindex").val();
       $($(this).siblings("div").find("tr")).eq(parseInt(ind)).remove();
       $(this).siblings(".inindex").val(-1);

});

//초기화
$("#null1").click(function(){
   $("#selectper tbody").html("");
   $("#map input[type=checkbox]").prop("checked","");

});

$("#endlineset").on("click",function(){
  if( $(this).prop("checked")){
   $("#right4").css("display","block");
  }else{
   $("#right4").css("display","none");
   $("#endline tbody").html("");
  }
});

$(".fold").on("click",function(){

   $(this).parent().next("ul").slideToggle();
   if($(this).val()== '+'){
       $(this).val('-');
       $(".foldall").val('-')
   }else{
       $(this).val('+');
       $(".foldall").val('+')
   }
});

//결제라인저장 
$("#saveline").click(function(){
   $("#backdiv").css("display","block");
   $("#seldiv").css("display","block");
   $("#save").css("display","block");
   $("#listsave1").css("display","block");

   $("#saveper tbody").html($("#checkper tbody").html());
 
})


$("#sel").click(function(){
   $("#checkper tbody").html($("#saveper tbody").html());
   $("#close2").trigger("click");
});


//결제선 창 닫기
$("#close2").click(function(){
   $("#saveper tbody").html("");
   $("#backdiv").css("display","none");
   $("#seldiv").css("display","none");
   $("#listget1").css("display","none");
   $("#listsave1").css("display","none");
   $(this).siblings("button").css("display","none");
});
});


function end(){

    var arr;
    var dept;
    var tfcheck = true;

    //결재인원
    arr=[];
    
    $("#chedept").val($("#checkper tr").find("td:eq(1)").html());
    $("#checkper tr").each(function(index,item){
       arr.push($(this).find("td:eq(0)").html()+" "+$(this).find("td:eq(1)").html());
       
   })
   if(arr.length >4 ){
        alert("최대 4명까지");
        tfcheck = false;
    }
   $("#cheper").val(arr.join());

  

   //합의인원
   arr=[];
   if(arr.length >4 ){
        alert("최대 4명까지");
        tfcheck = false;
    }
   $("#coladept").val($("#colper").find("td:eq(1)").html());
    $("#colper tr").each(function(index,item){
    	 arr.push($(this).find("td:eq(0)").html()+" "+$(this).find("td:eq(1)").html());
   })
   $("#colaper").val(arr.join());

   //수신인원
   arr=[];
    $("#responeper tr").each(function(index,item){
       arr.push($(this).find("td:eq(0)").html());
   })
   $("#resper").val(arr.join());

  

  //결제 확인

   
   if($("#cheper").val() == ""){
       alert("결제인원은 비어있을수 없습니다.");
       tfcheck = false;
   }else{
	    $(".people",parent.opener.document).html("");
	    $(".perend",parent.opener.document).val("");
	    $("#chper",parent.opener.document).val($("#cheper").val());
	    $("#cope",parent.opener.document).val($("#colaper").val());
	    $("#viewp",parent.opener.document).val($("#resper").val());
	 
	    $("#chper",parent.opener.document).click();
	   
	    $("#cope",parent.opener.document).click();
	   
        $("#viewp",parent.opener.document).click();
    	
   }
    

   if(tfcheck){
	  
	
       //window.close();
   }
}



function close1(){
   
   if(confirm("닫으시겠습니까?")){
       window.close();
   }
   
}
