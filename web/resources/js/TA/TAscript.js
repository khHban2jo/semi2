
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
        $.ajax({
        	url: "/semi/sTime.ta",
        	type:"get",
        	data:{
        		type:"T1"
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
        		
        		if(now.getDay()==0||now.getDay()==6){
        			
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