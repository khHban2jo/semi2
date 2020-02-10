
$(function(){
    //  현재시간 설정
    $('#day').html(new Date().toLocaleDateString());
    $('#time').html(new Date().toLocaleTimeString());

    var time = setInterval(timer, 1000);
    function timer(){
        $('#time').html(new Date().toLocaleTimeString());
    }

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
    	$.ajax({
        	url: "/semi/eTime.ta",
        	type:"get",
        	data:{
        		type : "T2"
        	},
        	success:function(msg){
        		alert(msg);
        	},
        	complete:function(){
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
        		
        		if(now.getDay()==0||now.getDay()==6||checkHoliday){
        			//	토 / 일 요일 이거나 공휴일이라면 특근으로 처리한다.
        			$.ajax({
        				url: "/semi/holidayEnd.ta",
        				type:"get",
        				success: function(data){
        					
        				},
        				complete:function(){
        					location.href = "/semi/open.ta";
        				}
        			});
        		}else{
	        		if(now.getHours()<19){
	        			alert("19시 이전 퇴근!\n추가 근무 시간 없음!");
	        			location.href = "/semi/open.ta";
	        		}else{
	        			$.ajax({
	        				url: "/semi/overTime.ta",
	        				type:"get",
	        				success:function(a){
	        					alert(a);
	        				},
	        				complete:function(){
	        					location.href = "/semi/open.ta";
	        				}
	        			});
	        		}
        		}
        	}
        });
    	
    });

    //  휴무신청 버튼
    $('#vacationBtn').click(function(){
        
    });
    
    //	결재확인 버튼
    $('#checkBtn').click(function(){
    	
    });
    

});