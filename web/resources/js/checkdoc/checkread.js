var ind = 0;
   
     $(function(){



        $("#returncbtn").click(function(){
            //반려 코멘트 보기
            $("#retruncomment").css("display","block");
            $("#popback").css("display","block");
          
        });

        $("#close3").click(function(){
            $("#retruncomment").css("display","none");
            $("#popback").css("display","none");
        })

        
    

     $("#close").click(function(){
        $("#checkpop").css("display","none");
        $("#popback").css("display","none");
    
        });
    });