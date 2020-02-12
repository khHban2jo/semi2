
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.coo.member.model.vo.Member"%>
    <%
    	Member m = (Member)session.getAttribute("member");
		String myde = m.getDeptCode();
    
    //결제 관련 테이블에서 어레이 리스트로 자신이 정일때 , 부서,  결제 정보 가져오기%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제선 선택</title>
    <link rel="stylesheet" href="/semi/resources/css/checkdoc/checkpeople.css">
    <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
    <script src ="/semi/resources/js/checkdoc/checkpeople.js"></script>

   
   
</head>
<body>
<div id ="good">
<div id="left">
    <fieldset id = "mapf">
        <legend>조직도</legend>
    <div id ="map">
    <!--<input type= "text" value ="" id ="fill">-->
    <ul id="peoplemap">
        <li><input type ="checkbox" class="all"><label>전체 보기</label>
            <input type="button" class="foldall"  value ="+">
        </li>
        <ol id = "peaplem">
            <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class ="dept"></label>
                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
            </ul>
            
            <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class ="dept"></label>

                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
               
            </ul>
            
            <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class ="dept"></label>
                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
               
            </ul>
            
            <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class ="dept"></label>
                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
               
            </ul>
            
               <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class ="dept"></label>
                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
               
            </ul>
            
            
        </ol>
        

    </ul>
    </div>
</fieldset>
<script>
var mydept ="";

$(function(){
	$.ajax({
		url:"/semi/pMap.ch",
		type:"get",
		success:function(data){
			var dept= $(".dept");
			var ul = $(".de");
			var $li = $("<li>");
			var $check = $('<input type ="checkbox" class ="person1" onclick="checkperson(this);">');
			var $la = $('<label onclick="clickla(this);>');
			
			for(var i in data.list1){
				var code= data["list1"][i];
				var deptsearch = data["list2"][code];
				dept[i].innerHTML = code; //라벨 박기
				if(deptsearch[0].deptCode == "<%=myde%>"){ 
					$("#chedept").val(deptsearch[0].deptName); //자신 부서명 찾기
				}
				for(var j in deptsearch){ // 
					var people = deptsearch[j];
					var text;
					with(people){
					text = empCode + " " +deptName + " " +job + " "+empName;
					}
					ul[i].innerHTML +='<li><input type ="checkbox" class ="person1" onclick="checkperson(this);"><label onclick="clickla(this);">' + text +"</label></li>";
					
				}
			}
				
	
		},error:function(){
			alert("에러")
		}
		
	});
	
});

	function checkperson(i){

 		if($(i).prop("checked")){

			var a= $(i).siblings("label").text().split(" ");
			var c= $("#selectper tbody");
			var d="<tr><td>"+a[0]+"</td><td>"+a[1]+"</td><td>"+a[2]+"</td><td>"+a[3] +"</td></tr>";
		//기존 배열과 확인후 삭제
			 if(c.find("tr").length >0){
				c.find("tr").each(function(index,item){				
				$("#selectper tbody").html(c.html()+d );
			 	});
	
 			}else{
   				$("#selectper tbody").html(d);
 			}
		}else{
			 var a= $(i).siblings("label").text().split(" ");
			 $('#selectper tr:contains('+a[0]+')').remove(); 
		}

	}
	
	
	function clickla(i){
		console.log($(i));
	       //$(i).prev(".person1").click();
	    console.log($(i).prev(".person1"));
	   }

</script>


<fieldset id = self>
    <legend>선택</legend>
    <span id ="caution">결제라인에는 역순으로 들어갑니다.</span>
    
    <div id ="select" align ="center">

            <table id = selectper >
            <thead>
                <tr>
                <th>
                    사번
                </th>
                <th>
                    부서
                </th>
                <th>
                    직책
                </th>
                <th>
                    이름
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
  

    </div>
    <input type ="button" value ="초기화" id ="null1">
</fieldset>
</div>
<div id="right">
        <span id= cautionLine>결제는 위에서 아래로진행됩니다.</span>
    <fieldset class = "rightf1  inright" id ="right1">
        <legend>결재자</legend>

        <input type="text" class="inindex">
        <input type="text" class="inhtml">
        <input type="button" value ="넣기" class ="ebtn ienter">
        <input type="button" value ="제거" class ="drop">
        <input type="button" value ="라인저장"  id="saveline">
        <div class ="line" >
            <table id = "checkper">
                <tbody>

                </tbody>

            </table>
        </div>
        <input type="button" value ="up" class="up" id ="chup">
        <input type="button" value ="down" class="down" id ="chdo">
       

    </fieldset>


    <fieldset class = "rightf1  inright" id ="right2"  >
        <legend>합의/참조</legend>

        <input type="text" class="inindex">
        <input type="text" class="inhtml">
        <input type="button" value ="넣기" class ="ebtn center">
        <input type="button" value ="제거" class ="drop">
        <div class ="line">

            <table id = "colper">
                <tbody>

            </tbody>
            </table>
        </div>
        <input type="button" value ="up" class="up" id ="coup">
        <input type="button" value ="down" class="down" id ="codo">


    </fieldset>


     <fieldset class = "rightf1 inright" id ="right3">
        <legend>수신자</legend>

      
        <input type="text" class="inindex">
        <input type="text" class="inhtml">
        <input type="button" value ="넣기" class ="ebtn venter">
        <input type="button" value ="제거" class ="drop">
        <div class ="line">
            <table id = "responeper">
                <tbody>

            </tbody>
            </table>
        </div>
        <input type="button" value ="up" class="up" id ="reup">
        <input type="button" value ="down" class="down" id ="redo">

    
    </fieldset>



     <input type="checkbox" class="endlineset" id ="endlineset"><label id="endlabel" for ="endlineset">최종결제자</label>
     <div id ="right4" class ="inright">
        <input type="text" class="inindex">
        <input type="text" class="inhtml">
        <input type="button" value ="결제자" class ="endenter">
        
        <div class ="line end">
            <table id = "endline">
             <tbody>

            </tbody>
            </table>
        </div>
        <input type="button" value ="제거" class ="enddrop">

     </div>
  

     <input type = "button" value ="결제선가져오기" id="push1"> 
    <div id="sub" style="border :0px;">
 
         <input type ="text" name ="chedept" id="chedept" value="">
         <input type ="text" name= "cheper" id="cheper" value="">
         <input type ="text" name= "coladept" id ="coladept" value="">
         <input type ="text" name= "colaper" id = "colaper" value="">
         <input type ="text" name= "resper" id = "resper" value="">
         <input type ="text" name= "endper" id = "endper" value="">
         <input type="submit" onclick ="return end()" value="전송">

    </div>
    <input type="button" value ="닫기" onclick="close1();" id ="clo">
</div>


    <!--결제선 가져오기-->

    <div id="backdiv">

      

    </div>
    <div id="seldiv">
        <select id="deptsel">
            <option value="D0">a</option>
            <option value="D2">b</option>
        </select>
        <select id="pushper1">
            <option value="1">결제라인1</option>
            <option value="2">결제라인2</option>
            <option value="3">결제라인3</option>
        </select>
         <select id="pushper2">
            <option value="1">결제라인1</option>
            <option value="2">결제라인2</option>
            <option value="3">결제라인3</option>
        </select>
        <div class ="line">

            <table id = "saveper">
                <tbody>

            </tbody>
            </table>
        </div>
  
        <button id="sel">결제라인 지정</button>
        <button id="save">결제라인 저장</button>
        <button id="close2">닫기</button>
    </div>

    

</div> 
	<script>
	
	$("#pushper2").click(function(){
		console.log($("#deptsel").val());
		console.log($("#pushper2").val())
		<%-- $.ajax({
			url:"",
			type:"get",
			data:{
				empcode:<%=m.getEmpCode()%>
			},
			success:function(data){
				var tbody = data[$("#deptsel").val()][$("#pushper2").val()];
				table:$("#saveper tbody").html(data);
			},
			error:function(){
				alert("불러오는데 오류가 생겼습니다.");
			}
		}); --%>
	});
		
		$("#save").click(function(){
			   //servlet에 sel값과 pushper2값,$("#saveper tbody").html  넘겨주기
			   $("#close2").trigger("click");
			});



		
		function setsaveline(i){
			$.ajax({
				url:"",
				type:"get",
				data:{
					dept:$("#deptsel").val(),
					number:$("#pushper1").val(),
					table:$("#saveper tbody").html()
				},
				success:function(data){
					
				},
				error:function(){
					alert("불러오는데 오류가 생겼습니다.");
				}
			
		});
		}
	
	</script>
</body>
</html>