var date = new Date();

$(function(){

    $("#docdate").val()
    //품의서 버튼
    $("#btn_1").click(function(){
        $("#doctype1").css("display","block");
        $("#doctype2").css("display","none");
        $("#doctype3").css("display","none");
        $("#type1").val("품의서");

    });
    //결의서 버튼
    $("#btn_2").click(function(){
        $("#doctype1").css("display","none");
        $("#doctype2").css("display","block");
        $("#doctype3").css("display","none");
        $("#type1").val("지출결의서");

    });
    //휴가 신청서
    $("#btn_3").click(function(){
    	
        $("#doctype1").css("display","none");
        $("#doctype2").css("display","none");
        $("#doctype3").css("display","block");
        $("#type1").val("휴가계획서");
        
    });
    $("#btn_1").click();
    
    //작성일자
    var month;
    if((date.getMonth()+1).length =1){
       month= "0"+(date.getMonth()+1)
    }else{
        (date.getMonth()+1)
    }
    $("#docdate").val(date.getFullYear()+"-"+month+"-"+date.getDate());
    

//결재자 자동채우기용
    function fillp(){
    	console.log("부모함수 실행")
    $(".hiddenper").on("change",function(){
    	
    		
        // console.log($(this).val());
        // console.log($(this).prev("table"));
        // console.log($(this).prev("table").find(".people").html());

        //배열 자르기
        var person1 = $(this).val().split();
        //자르고 데이터베이스에서 정 부 가져오기 mainp , subp
        //배열당 보기
        var personfill ="";
        //최종 넘어갈 사람
        //var personend ;
         for(var i = 0; i<person1.length; i++){
             persontfill +=  "<div class='person' onclick ='delperson(this);'>"+ i+" . 정:" +mainp+"<br> 부:" +sub +"</div>"
         }

           // personfill +=  "<div class='person' onclick ='delperson(this);'>" +1+".정:" + $(this).val()+"<br>&nbsp; 부:" +$(this).val() +"</div>"
           // $(this).prev("table").find(".people").html(personfill);
    });

    //참조자 자동채우기용
    $(".hiddenper1").on("change",function(){
         //배열 자르기 및 넘어감
        //var person1 = $(this).val().split();
        $(this).prev("table").find(".people2").html($(this).val());
    });
    
    }


    //결재자체크 버튼
$("#setLine").click(function(){
    window.open("checkpeople.jsp","childform","target : _blank");
   // console.log($(".hiddenper").filter("input[type=text]"));
   
//     $(".hiddenper").filter("input[type=text]").eq(0).val(12345);
//    $(".hiddenper").filter("input[type=text]").eq(0).trigger("change");

});



//파일 목록 출력
$("#upload").change(function(){
//    var fileset = $(this).get(0);
//    console.log(fileset)
//         if(fileset.files.length <6){
//            for(var i =0; i<fileset.files.length; i++ ){
//                if(fileset.files[i].size <=10485760){
//                  	   document.getElementById("filenames").innerHTML += fileset.files[i].name +"<br>";
//                  	   filestext[i].value =fileset.files[i].name; 
//                }else{
//                    alert(fileset.files[i].name +" 의 크기가 너무 큽니다. 파일1개의 최대 크기는 10mb입니다." );
//                    $(this).val("");
//                }
//         }
//         }else{
//             alert("파일은 5개 까지 가능합니다.");
//             $(this).val("");
//     }
//    
//    console.log($("#filenames").html());
//
		var fileset= $(this).get(0);
		console.log(fileset);
	});


	//	휴가 신청서 include용 script
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

    //결재자클릭시 제거
function delperson(i){
    var indext =parseInt(i.innerText) -1;
    console.log(indext)
    if(confirm( i.innerText +" 결제선을 삭제하시겠습니까?")){
       i.remove();
    // 최종 인덱스에 맞는 값 splice()로 잘라내기 
} 

}
