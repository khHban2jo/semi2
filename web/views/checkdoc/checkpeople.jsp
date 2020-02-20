
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
        <input type="button" value ="넣기" class ="ebtn enter">
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
        <input type="button" value ="넣기" class ="ebtn enter">
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


  

     <input type = "button" value ="결제선가져오기" id="push1"> 
    <div id="sub" style="border :0px;">
 
        
         <input type ="text" name= "cheper" id="cheper" value="">
   
         <input type ="text" name= "colaper" id = "colaper" value="">
    
         <input type ="hidden" name= "resper" id = "resper" value="">
         <input type="submit" onclick ="return end()" value="전송">

    </div>
    <input type="button" value ="닫기" onclick="close1();" id ="clo">
</div>
	

    <!--결제선 가져오기-->

    <div id="backdiv">
			
      	

    </div>
    <div id="seldiv">
        <select id="deptsel">
            
        </select>
        <select id="listsave1">
            <option value="1">결제라인1</option>
            <option value="2">결제라인2</option>
            <option value="3">결제라인3</option>
        </select>
         <select id="listget1">
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
	
	var mydept ="";
	var getTable;
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
				console.log(data);

				for(var i in data["list1"]){
					var code= data["list1"][i];
					var deptsearch = data["list2"][code];
					dept[i].innerHTML = code; //라벨 박기
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
		
		
		 $.ajax({
				url:"/semi/gStLine.ch",
				type:"get",
				data:{
					empcode:<%=m.getEmpCode()%>
				},
				success:function(data){
					
		  
		   		var $select = $("#deptsel");
		   		$select.find("option").remove();
		   		var code= data["list1"];
		  		
		   		for(var i = 0; i <code.length; i++){
					if(data["list2"][code[i]] != undefined){
						 var $op = $("<option>");
						$op.val(data["list2"][code[i]].deptCode);
						$op.text(data["list2"][code[i]].deptName);
						$select.append($op);
			  		 }
		   		}
			  
				  getTable= data["list2"];
				  
			
			  
	},
	error:function(){
		alert("불러오는데 오류가 생겼습니다.");
	}
	
	
		}); 
		 return getTable;
	});
	//체크박스
		function checkperson(i){

	 		if($(i).prop("checked")){
				var a= $(i).siblings("label").text().split(" ");
				var c= $("#selectper tbody").html();
				var d="<tr><td>"+a[0]+"</td><td>"+a[1]+"</td><td>"+a[2]+"</td><td>"+a[3] +"</td></tr>";
			//기존 배열과 확인후 삭제		
				$("#selectper tbody").html(c+d );
		
			}else{
				 var a= $(i).siblings("label").text().split(" ");
				 var b = $('#selectper>tbody>tr');
				for(var i =0; i< b.length;i++){
					if(b[i].innerHTML.indexOf(a[0])>-1){
						if(b[i].innerHTML.indexOf(a[1])>-1){
							b[i].remove();
						}	
					}
				}

			}

		}
		
		
		
	
	
	$("#push1").click(function(){

					   $("#backdiv").css("display","block");
					   $("#seldiv").css("display","block");
					   $("#sel").css("display","block");
					   $("#listget1").css("display","block");

					   $("#listget1").trigger("change");
		});
	
	$("#listget1").change(function(){

		var getT = getTable;
		console.log(getT);
	
		
		var tbody = getT[$("#deptsel").val()]["list"+$("#listget1").val()];
		console.log(tbody);
		if(tbody != undefined){
		$("#saveper tbody").html(tbody);
		}else{
			$("#saveper tbody").html("");
		}

	});
		
		$("#save").click(function(){
			
			$.ajax({
				url:"/semi/sStline.ch",
				type:"post",
				data:{
					empcode :<%=m.getEmpCode()%>,
					dept:$("#deptsel").val(),
					number:$("#listsave1").val(),
					table:$("#saveper tbody").html()
				},
				success:function(data){
					console.log(data);
					 $("#close2").trigger("click");
				},
				error:function(){
					alert("저장하는데 오류가 생겼습니다.");
				}
			  
			});
		});
		
		

		
		
	</script>
	
	
</body>
</html>