
$(function(){
    //  현재시간 설정
    $('#day').html(new Date().toLocaleDateString());
    $('#time').html(new Date().toLocaleTimeString());

    var time = setInterval(timer, 1000);
    function timer(){
        $('#time').html(new Date().toLocaleTimeString());
    }
    
    $('.progressBar').css('width',per+'%');

    //  출근버튼 클릭
    $('#startBtn').click(function(){
    	var now = new Date();
		
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		month = month >= 10? month : '0' + month;
		var day = now.getDate();
		day = day >= 10? day : '0' + day;
		
		var now2 = year + '' + month + '' + day;
		
		var checkHoliday = false;
    	$.each(holiday, function(index, value){
    		if( value == now2 ){
    			checkHoliday = true;
    		}
    	});
    	
    	var type;
    	if(now.getDay()==0||now.getDay()==6||checkHoliday){
    		//	토 / 일요일 또는 공휴일 출근은 T4
    		type = "T4";
    	}else{
    		//  나머지 일반 출근은 T1
    		type = "T1";
    	}
    	
		$.ajax({
			url: "/semi/sTime.ta",
			type:"get",
			data:{
				type:type
			},
			success:function(msg){
				alert(msg);
			},
			complete:function(){
				location.href = "/semi/open.ta";
			}
		});
    	
    });

    //  퇴근버튼 클릭
    $('#endBtn').click(function(){
    	var now = new Date();
		
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		month = month >= 10? month : '0' + month;
		var day = now.getDate();
		day = day >= 10? day : '0' + day;
		
		var now2 = year + '' + month + '' + day;
		
		//	공휴일 check 변수
		var checkHoliday = false;
    	$.each(holiday, function(index, value){
    		if( value == now2 ){
    			checkHoliday = true;
    		}
    	});
    	
    	var type;
    	if(now.getDay()==0||now.getDay()==6||checkHoliday){
    		//	토 / 일요일 또는 공휴일 퇴근은 T5
    		type = "T5";
    	}else{
    		//  나머지 일반 퇴근은 T2
    		type = "T2";
    	}
    	
    	$.ajax({	//	ajax 1번 시작
        	url: "/semi/eTime.ta",
        	type:"get",
        	data:{
        		type : type
        	},
        	success:function(msg){
        		alert(msg);
        	},
        	complete:function(){		//	ajax-compleate 1번 시작
        		if(now.getDay()==0||now.getDay()==6||checkHoliday){
        			//	토 / 일 요일 이거나 공휴일이라면 특근으로 처리한다.
        			$.ajax({
        				url: "/semi/endH.ta",
        				type:"get",
        				data:{
        					now : now.getHours()+''+ ( now.getMinutes()>10? now.getMinutes():"0"+now.getMinutes() )
        				},
        				success: function(msg){
        					alert(msg);
        				},
        				complete:function(){
        					location.href = "/semi/open.ta";
        				}
        			});
        		}else{		//	else문 1번
	        		if(now.getHours()<19){
	        			alert("19시 이전 퇴근!\n추가 근무 시간 없음!");
	        			location.href = "/semi/open.ta";
	        		}else{
	        			$.ajax({
	        				url: "/semi/overTime.ta",
	        				type:"get",
	        				data:{
	        					now : now.getHours()+''+ ( now.getMinutes()>10? now.getMinutes():"0"+now.getMinutes() )
	        				},
	        				success:function(a){
	        					alert(a);
	        				},
	        				complete:function(){
	        					location.href = "/semi/open.ta";
	        				}
	        			});
	        		}
        		}		//	else문 1종료
        	}		//	ajax-complete 1번 종료
        });		//	ajax 1번 종료
    });

    //  휴무신청 버튼
    $('#vacationBtn').click(function(){
    	var url = "/semi/views/checkdoc/writedoc.jsp";
        var name = "문서상신";
        var option = 'top=80px, left=250px width=1250px,height=850px, resizable=no, location=no, toolbars=no,scrollbars=no';
        window.open(url, name, option);
    });
    
    //	결재확인 버튼
    $('#checkBtn').click(function(){
    	if( $('#checkBtn').html() =='결재 확인' ){
    		$('#checkBtn').html('근무 현황');
    		$.ajax({
        		url: "/semi/myVacDoc.ta",
        		type: "get",
        		success: function(){
        			
        		},
        		complete: function(){
        			
        		}
        	});
    		$('.area2').css('display','none');
    		$('.area3').css('display','block');
    	}else{
    		$('#checkBtn').html('결재 확인');
    		$('.area3').css('display','none');
    		$('.area2').css('display','block');
    	}
    	
    });
    

});