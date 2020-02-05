var ind = 0;
    var okcheck1 = '<input type ="button" value="결재" id="okcheck1">';
     $(function(){
         $("#top2 tr:eq(0)").children().each(function (index,item){
             item.innerHTML ="결재자" + (index+1);
         });

         $("#top3 tr:eq(0)").children().each(function (index,item){
             item.innerHTML ="합의자" + (index+1);
         });

         $("#top2 tr:eq(1)").children().each(function (index,item){
             item.innerHTML ="결재완";
         });
         
         $("#top3 tr:eq(1)").children("td").eq(ind).html(okcheck1);
    //     //결재버튼 출력 로직
    //     if( flow == 0){ //결재가 진행중일때
    //     //만약 아이디를 먼저 체크하게 되면 3가지를 다 가져와서 체크.
    //     //
    //         if(dept == 0){ //내부 결재가 진행중인가.(반려시 flow에서 이미 걸러짐)

    //         }else if(dept1 ==0){ //내부결개 완료후 합의 결재중

    //         }else if ('사장결재'.indexof(my)==0){

    //         }
    //         if(dept1==1 &&dept2 ==1){
    //         if(){ //사장이나 대리자에 아이디가 있나
                
    //                 if('사장결재'.indexof(my)==0){
    //                     if('상태가 휴가 조퇴가 아닌가' ){

    //                     }
    //             }
    //         }
            
    //         if(id !=null){//아이디가 null이 아니고 사장이 아닐때
             
    //             if(dept=mydept){//결재부서가 자신의 부서인가.
                    
                        
    //             }else if(dept1 ==1 && cola == mydept){
    //                 //기안 부서가 내부결제가 끝나고, 자신의 부서 차례인가.
    //             }else 
    //                 if(mystat !='휴가' && mystat !=''){

    //                 }
    //                 //결재 버튼 생성
    //             }              
    //         }
    //     }
    

        //결제 버튼창 출력
        $("#okcheck1").click(function(){
            $("#checkpop").css("display","block");
            $("#popback").css("display","block");
        });


        // $("#oksign").click(function(){
        //     if(confirm("결재 하시겠습니까?")){
        //         $("#checkpop").css("display","none");
        //         $("#popback").css("display","none");
        //         $("#okcheck1").parent("td").html("결재완");
        //     }
        // });
        $("#oksign").click(function(){
            if(confirm("결재 하시겠습니까?")){
                $("#imglook").css("display","block");
            }
        });
        $("#imglook").on('click','img',function(){
            $("#imglook").css("display","none");
             $("#checkpop").css("display","none");
                $("#popback").css("display","none");
                var a= $(this);
                   
                $("#okcheck1").parent("td").html(a);
        });
        $("#return").click(function(){
            if(confirm("반려 하시겠습니까?")){
                $("#checkpop").css("display","none");
                $("#popback").css("display","none");
                $("#okcheck1").parent("td").html("반려").css("color","red");
            }
        });

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