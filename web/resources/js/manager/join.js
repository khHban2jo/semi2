   $('#eNameCheck').click(function(){
         var regExp = /[a-z|A-Z]/;
         var eName1 = $('#eName1').val();
         var eName2 = $('#eName2').val();

         if(!regExp.test(eName1)){
            alert("영문만 입력해주세요");
            return false;
         }

         if(!regExp.test(eName2)){
            alert("영문만 입력해주세요");
            return false;
         }
         $('#uid').val(eName1+"."+eName2);
         $('#checkId').removeAttr('disabled');
           return true;
      });
   
   $('#checkId').click(function(){
         $.ajax({
           url:"<%= request.getContextPath() %>/idDup.me",
           type:"get",
           data:{
                 userId:$('#userId').val()
           },success:function(data){
              
               if(data=='y'){
                  alert("아이디 사용가능");
               }else{
                  alert("아이디 사용불가");
               }
           },error:function(){
               alert("조회 실패");
           }
         });
      });
   $('#pwdCheck').click(function(){
      var pwd1 = $('#pwd1').val();
      var pwd2 = $('#pwd2');
      var regExp = /[0-9|a-z]/;
      
      if(!regExp.test(pwd1)){
         alert("숫자와 영문으로만 작성해주시기 바랍니다."); 
         return false;
      }
      
      if(!regExp.test(pwd2)){
         alert("숫자와 영문으로만 작성해주시기 바랍니다."); 
         return false;
      }
      
      if(pwd1==pwd2.val()){
         alert("비밀번호가 일치합니다.");		     			 
      }else{
         alert("비밀번호가 틀립니다.");
         pwd2.select();
         return false;
      }
      return true;
   });
   
  $('#pschk').click(function(){
      var regExp = /^[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0-1])[1-4][0-9]{6}$/;
       var psid = $('#psid').val();
       
      if(regExp.test(psid)){
          alert("keep going");
      }else{
          alert("주민등록번호 양식에 맞지 않습니다.");
          return false;
      }
      
      //성별, 나이
      var str = $('#psid').val();
      switch(str.substr(6,1)){
      case "1":$('#male').attr('checked','true'); break;
      case "3":$('#male').attr('checked','true'); break;
      case "2":$('#female').attr('checked','true'); break;
      case "4":$('#female').attr('checked','true'); break;
      }
      
      var year = new Date().getFullYear();
      var age = parseInt(str.substr(0,2));
      regExp = /([0-1])/;
      if(regExp.test(age)){
          $('#age1').val(year - (age+2000));
      }else{
          $('#age1').val(year - (age+1900));
      }
      return true;
  });
  
  $('#maillist').change(function(){
      $('#mail').val($('#mail').val()+$('#maillist').val());
  });
  $('#p2').change(function(){
      var regExp = /[0-9]{3,4}/;
      var p2 = $('#p2').val();
      
      if(!regExp.test(p2)){
          alert("잘못된 입력 양식. 숫자를 입력해주세요");
          return false;
          p2.focus();
      }
          return true;
  });
  
  $('#p3').change(function(){
      var regExp = /[0-9]{3,4}/;
      var p3 = $('#p3').val();
      
      if(!regExp.test(p3)){
          alert("잘못된 입력 양식. 숫자를 입력해주세요");
          p3.focus();
          return false;
      }
          return true;
  });
  
  $('#pName').change(function(){
	 var regExp = /^[가-힣]$/;
	 var pName = $('#pName');
	 if(!regExp.test(pName.val())){
		 alert("한글을 입력해주세요");
		 pName.focus();
		 return false;
	 }else{
		 return true;
	 }
  });
  
     function check(){
      var chk = $('input').val();
      if(chk=="" || chk==null || chk==undefined){
         alert("빈 칸을 채워주세요");
          return false;	 
      }else{
    	  
      return true;
      }
  }