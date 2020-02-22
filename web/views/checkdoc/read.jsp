
<%@page import="javafx.scene.DepthTest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList , com.coo.check.model.vo.*, com.coo.member.model.vo.Member,java.sql.Date"%>
 <%
    //게시판
    //문서 
    //둘다 문서 번호 검색해서 가져올것 
    //자신이 포함되 있나 확인   
    //합의자에 자신이 포함된 인덱스 찾기  둘은 자바 스크립트에서
    //세션 아이디 받아오기
 
	Member m = (Member)session.getAttribute("member"); 
 	int id = m.getEmpCode();
 	String sid = Integer.valueOf(id).toString();
    CheckDoc check = (CheckDoc)request.getAttribute("info");
    //사람이름 찾아와야됨.
    RoundDoc doc = (RoundDoc)request.getAttribute("doc");
    String text =doc.getText();
    int endPay = 0;
	

 	//String doctext = (String)request.getAttribute("doc");
    ArrayList<String> files = (ArrayList<String>)request.getAttribute("files");
    String approver = check.getApprover();
    String doctype = check.getDocType();
   	int docStatus = check.getaStatus();
	String inPe = (check.getInPeople() ==null)?"":check.getInPeople();
	String colPe = (check.getColPeople()==null)?"":check.getColPeople();
	String viewPe = (check.getViewPeople()==null)?"":check.getViewPeople();
	String getIn = check.getInStatus();
	
	
	
     
  %>
<!DOCTYPE html>
<html lang="ko">
<head>
    
    <meta charset="UTF-8">
    <title>문서보기</title>
    <link rel="stylesheet" href="/semi/resources/css/checkdoc/checkread.css">


    <script
    src="https://code.jquery.com/jquery-3.4.1.min.js"
    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
    crossorigin="anonymous"></script>
    <script src = "/semi/resources/js/checkdoc/checkread.js"></script>


</head>
<%//session != null &&
if(check.getDeleteyn().equals("N") && (check.getaWriter() == id
		||inPe.contains(sid)||
		colPe.contains(sid)||
		viewPe.contains(sid)||
	check.getViewPeople().contains(sid))){  %>
<body>  
	<script>
		$(function(){
			//ajax
			var reload =function(){
				
			}
			 var getNames = function(item){
				 var code = item;
				$.ajax({
					url:"/semi/sREName.ch",
					type:"get",
					async: false,
					data:{
						peArr:code
					},
					success:function(data){
					     getName = data;
					     
				      
					 },
					 error:function(){
						 alert("이름 가져오는데 에러");
					 
					}
					
				});
				
				return getName;
			 }
			 //결재 용 이름 로우 생성
				var makeNametd = function(item, table, index){
					var tr = table.eq(index);
					for(var i = 0; i<item.length; i= i+2){
					var $td =$("<td align='center'>");
					$td.html('정:' + item[i] + '<br> 부:' +item[i+1]);
					tr.append($td);
					}
				}
				//결재용 진행 로우 생성
				var makeflowtd= function(item,table){
					 var tr = table.eq(1);
					 for(var i in item){
						 var $td = $("<td align='center'>");
						 var text ;
							switch(item[i]){
			 				case "1" : text = "승인"; break;
							case "2" : text =	 "반려"; break;
			 				case "5" : text =	"결재중"; break;
							default : var text = ""; break;
							}
						 $td.html(text);
						 tr.append($td);
					 }
					}
			
				var okcheck1 = '<input type ="button" value="결재" id="okcheck1" onclick="check1();">';//결재 버튼
       	 
				var myCode= '<%=id%>'; //내코드
	    		var inpe = '<%=inPe%>'; //내부인원코드,
				var colpe= '<%=colPe%>'; //합의인원코드
				var viewpe = '<%=viewPe%>'; //참조자 코드

	    
			//내부
				 var innames = getNames(inpe);
				 var top2 = $("#top2 tr");
				 var inchecked = '<%=check.getInStatus()%>'.split(",");
				 makeNametd(innames,top2,0);
				 makeflowtd(inchecked,top2);
				/*  mydeptindex =innames.indexOf(myCode);
				 mydeptindex2  */

			//합의	 
				 if(!colpe == ""){
				 var colnames = getNames(colpe);
				 var top3 = $("#top3 tr");
				 var colchecked = '<%=check.getColStatus()%>'.split(",");
				 makeNametd(colnames,top3,0);
				 makeflowtd(colchecked,top3);

				/*  mycolindex =innames.indexOf(myCode);
				 mycolindex2=innames.lastindexOf(myCode); */
				 }
			//뷰
				 if(!viewpe ==""){
					 $.ajax({
						 url:"/semi/sECName.ch",
						 type:"get",
						 data:{
							 pcodes:viewpe
						 },
						 success:function(data){
							var viewL = $("#viewline");
							for(var i in data){
								var $div= $("<div>");
								$div.addClass("viewper");
								$div.html(data[i]["deptName"] +"<br>" + data[i]["empName"]);
								viewL.append($div);
							
							    if(i%7 ==6){
							    	viewL.append("<br><br>");
							    }
								
							}
									 
						 },
						 error:function(){
							 alert("뷰인원");
						 } 
					 }); 
				 }	 
			
			//데이터 베이스에 값 넘어간느 ajax
			function fulling(docNo, approin, docStatus, insertcode, colcode,comment){
				console.log(docNo);
				console.log(approin);
				var type ='<%=check.getDocType()%>'
				
				/*window.location.href='<%= request.getContextPath() %>/uDFlow.ch?docNumber='+docNo+'&next='+approin
																			+'&docSt='+docStatus+'&inCode='+insertcode
																			+'&colcodes='+colcode+'&rcomment='+comment
																			+'&doctype='+type;*/
				$.ajax({
					url:"/semi/uDFlow.ch",
					type:'get',
					data:{
						docNumber: docNo,
						next : approin,
						docSt : docStatus,
						inCode : insertcode,
						colcodes : colcode,
						rcomment : comment,
						doctype: type
					},
					success:function(data){
						window.location.href='<%= request.getContextPath()%>/cread.ch?docNumber='+docNo
						
					},
					error:function(){
						alert("넘기는대 에러");
					} 
				}); 
				
				
				
			}

			        
				//넘어가야되는 값 총합  1. 다음 결재자, 2.독넘버, 3, 독스텟, 4.변경 결재 코드 5.합의변경코드, 6. 리스트코멘트
			  var flowok =  function(docNo, table, approin, docStatus, insertcode, colcode,comment ){
				$("#oksign").click(function(){
					result = "승인";
					var result = "";
				         if(confirm("결재 하시겠습니까?")){	
				        	 console.log("ddd");
				            $("#checkpop").css("display","none");
				             $("#popback").css("display","none");
				               result = "승인";
				           }
				           $("#okresult").val(result);
				           if($("#okresult").val()=="승인"){
				        	   table.html("승인");

				        	   
				        	   fulling(docNo, approin, docStatus, insertcode, colcode,comment);
				           }
				        
				  });
					    
			   }	 
				
				var flowreturn = function( ){
			        $("#return").click(function(){
			            if(confirm("반려 하시겠습니까?")){
			                $("#checkpop").css("display","none");
			                $("#returnCopop").css("display","block");
			                $("#okcheck1").parent("td").html("반려").css("color","red");
			                //입력창 뜨기
			            }
			        });
				}
			
			
			 //1. 내가 결재 할 수 있는 조건 : 1) approver에 포함되있고, 정or 부일 때 정이 출근 안했을 경우
				var approver = '<%=approver%>'.split(",");
				var mystatus = false;
				if(approver.indexOf(myCode) == 0){ //정일때
					mystatus = true;
				}else if(approver.indexOf(myCode)==1){ //부일때
				  	 $.ajax({
										url:"/semi/cMStatus.ch",
										type:"get",
										async: false,
										data:{
											masCode:approver[0]
										},
										success:function(data){
											console.log(data);
											var result;
											if(data == 'Y'){
												mystatus = false;
											}else{
												mystatus = true;
											}
											return result;
										},error:function(){
											alert("마스터 상태체크");
										}
									
								});  
				}
				
				//내가 결재 가능할 때  결재문서 진행 상태에 따른 것 찾기
				
					var flow;
					var cStatus; //결재자 진행상황
					var docStatus =<%=docStatus%>; //문서진행상황
					var table; //결재완료 적을 테이블컬럼
					var docNo =<%=check.getDocNumber()%>;
					var approin ='<%=check.getApprover()%>'; //다음 결재자
					var insertcode = '<%=check.getInStatus()%>'; //내부결재 코드 
					var colcode = '<%=check.getColStatus()%>'; //내부결재시 넘어갈스탯
					var comment; //리턴 코멘트
					
					//반려용 메소드
					$("#saveComment").click(function(){
						var insertcode = '<%=check.getInStatus()%>';
						var colcode = '<%=check.getColStatus()%>';
						var docStatus ='<%=docStatus%>';
						console.log(docStatus);
						comment = $("#comment1").val();
						if(comment.length <= 300){
							var com = comment.split("\n");
							var arr=[];
							for(var i in com){
								arr.push(com[i]+"<br>");
							}
							comment = arr.join("");
							console.log(comment);
							if(docStatus == 0){
								cStatus=insertcode.split(",");
								console.log(cStatus.length);
									flow = cStatus.indexOf("5");
									cStatus[flow] = 2;
									insertcode = cStatus.join();							
								
							}else if(docStatus ==1){
								cStatus = colcode.split(",");
								console.log(cStatus.length);
								
									flow = cStatus.indexOf("5");
									cStatus[flow] = 2;
									colcode = cStatus.join();
								
							}
							 approin =<%=id%>;
						     docStatus = 3;
						     
						     $("#popback").css("display","none");
						     $("#returnCopop").css("display","none");
						     fulling(docNo, approin, docStatus, insertcode, colcode,comment);
							 
						
						}else{
							alert("반려 코멘트는 300자를 넘길 수 없습니다. 현재" + comment.length );
						}
					
					
					}); 
				
				if(mystatus){ //결과 값에 따라서
					
					console.log(docStatus);
					
					if(docStatus == 0){ //내부결재중
					    cStatus = insertcode.split(",");

						flow = cStatus.indexOf("5");
						table = $("#top2 tr:eq(1)").find("td").eq(flow);
						table.html(okcheck1);
						cStatus[flow] = "1";
						insertcode= cStatus.join();
						if(!colpe == ""){ //겸직
							myColin1 = colpe.split(",").indexOf(myCode);
							myColin2 = colpe.split(",").lastIndexOf(myCode);
							if(myColin1 != -1 && myColin2 != -1){
							  colstat = colcode.split(",");
						 	   if(myColin1%2== 0 ){
						 		    var ab =myColin1/2;
						 	    	colstat[ab] ="7"; //내가 정인 인덱스 찾기;	    	 
						 	   }
								if(myColin2%2== 0){
						 	   		colstat[myColin2/2] ="7";
						 	 	}
						 	   colcode = colstat.join();
						 	   console.log(colcode);
							}
						}
  					
						   if(flow+1 == cStatus.length){ //마지막 결재자였을 경우							  
							 if(!colpe == ""){ //합의 결제자가 있을 경우 
								 //console.log(colcode);
								 docStatus = 1;
								 colstat = colcode.split(",");
/* 								 console.log(colstat[0]);
								 console.log(typeof(colstat[0]));
								 console.log(colstat[0]=="7") */
								 if(colstat[0] == "7"){
									colstat[0]= "1";
									flow = colstat.indexOf("0");
									if(flow == -1){
										for(var i = 1; i<colstat.length; i++){
											colstat[i]= "1";
										}
											approin = 0;
											 docStatus = 2;
										
									}else {
										for(var i = 1 ; i<flow;i++){
								    	 	colstat[i]== "1";
										}
										colstat[flow]="5";			
										approin = colpe.split(",").slice(flow*2,flow*2+2).join(); 
									}
								 }else{
							     approin = colpe.split(",").slice(0,2).join();
							     colstat[0] = "5";
								 }
						
							     colcode = colstat.join();
							 }else{
							console.log("");
								 docStatus =2;
								approin = 0;
								 	
							 }
								
						 }else{
							 cStatus[flow+1] ="5";
							 insertcode= cStatus.join();
							 approin = inpe.split(",").slice((flow+1)*2, (flow+1)*2+2).join();						
						  
							 }
						   
					}else if(docStatus == 1){//합의결재중 
						cStatus = '<%=check.getColStatus()%>'.split(",");
						flow = cStatus.indexOf("5");
						
						if(flow != -1){
						table = $("#top3 tr:eq(1)").find("td").eq(flow);
						table.html(okcheck1);
						cStatus[flow] ="1";
						}
						if(flow+1 == cStatus.length){
							 colcode = cStatus.join();
							docStatus =2;
							approin = 0;
								 
						}else{//마지막 합의자가 아닐때
							console.log(flow+1);
							console.log(cStatus[flow+1]);
							if(cStatus[flow+1] =="7"){ //겸직처리용
								var aa = cStatus.indexOf("0");
								if(aa!=-1){
									for(var i =flow+1; i<aa-1;i++ ){
								    	cStatus[i] ="1";
								    }	
									cStatus[aa] = "5";
									approin = colpe.split(",").slice(aa*2, aa*2+2).join();

								}else{
									for(var i =flow+1; i<cStatus.length;i++ ){
								    	cStatus[i] ="1";
									}
									
										docStatus =2;
										approin = 0;
									 	
								}
								
							    
							
							}else{
								cStatus[flow+1] ="5";
								approin = colpe.split(",").slice((flow+1)*2, (flow+1)*2+2).join();
							}
							
							colcode = cStatus.join();
						}
						
					}
				
				flowok(docNo,table,approin,docStatus,insertcode,colcode,comment);
				flowreturn();
				
				
				}				
				
			});
		
		function check1(){
            $("#checkpop").css("display","block");
            $("#popback").css("display","block");
        }
	    
		
		
	     //반려시 넘어갈것 반려 코멘트 독스테이터스 4 , 기안자, 독넘버
		
		
		

	
	//결재 버튼
	//진행 배열 변경  //나는 값에 따른 변경, 결재 완료 시 다음 사람 5
	//내 인덱스가 해당 인덱스에 마지막인가.?
	//마지막일시 진행상태 변경
	//다음 인원을 잘라서 approval에 넣기 -> ajax에서 처리 해야됨
	//최종일시 결재 완료처리
	
	//ajax에서 변경값 approval, 결재상태, 내부겷재 상태
	
	//반려 코멘트시
	//approval -> 기안자, 결재 상태, 반려코멘트 삽입
	
	
	
		
	</script>
    <!--결재 팝업-->
    <div id= "popback"> </div>
    <div id ="checkpop" align= "center">
        <input type = "button" value ="승인" id="oksign">
        <input type = "button" value ="반려" id="return">
        <input type ="button" value ="닫기" id="close">
    </div>

    <div id="imglook">
        <h4>결재 도장 선택</h4>
        <table>
            <tbody>
                <tr>
            </tr>
            </tbody>
        </table>
    </div>
    <div id="returnCopop">
    	<textarea id = "comment1" cols="38" rows="15" sytle ="resize:none"></textarea>
    <button id= "saveComment">전송</button><span>최대 300자</span>
    </div>
   
    <div id ="top">

        <div id="top1">
        	<input type ="hidden" value ="" id="okresult">
            <table width ="170px">
                <tr>
                    <td align="center" width="30px"><%=check.getDeptName() %></td>
                    
                </tr>
                <tr>
                    
                    <td align="center"> <%=check.getJobName() %></td>
                </tr>
                <tr>
                    
                    <td align="center"><%=check.getAwriterName() %></td>
                </tr>
            </table>

        </div>
        <div id="top2">
                <table width ="260px"  >
                 <tr>
                </tr>
                <tr>
                </tr>
                </table>
            </div>
        
         <div id="colaboDept">
                <table width ="80px">
                            <tr>
                            <td  align="center">상태</td>
                            
                        </tr>
                        <tr>
                            <td align="center"><%if(check.getaStatus()==2) {%>
                            						결재완료
														
                            		<%}else if(check.getaStatus()==3){ %>
                            				반려
                            		<%}else{%>
                            				진행중
                            		<%} %>
                            					</td>
                           
                        </tr>
                        </table>
        </div> 

        <div id="top3" style="float: right;">
        <table width ="260px"  align="center">
            <tr>
			
        </tr>
        <tr>

        </tr>
        </table>
        <script>
        	
        
        </script>
        </div>
        <!-- <div id="endline">
            <table width ="80px">
                <tr>
                <td align="center">최종결재</td>
                
            </tr>
            <tr>
                
               
            </tr>
            </table>
        </div> -->
         <fieldset id="viewline">
             <legend><label id="view1">&nbsp;참조자&nbsp;</label></legend>


        </fieldset>
  

    

       
    </div>
    
    <div id ="doc">
        <div id="docinfo">
        <span> 제목 :</span>
        <div style ="display: inline-block; background :white; border :1px solid black; width: 400px;" ><%=check.getaTitle() %></div>
        <div style ="display: inline-block; border :1px solid black;"><%=doctype%></div>
        <%if(check.getReturnComment() != null){ %>
        <button id="returncbtn">반려코멘트 보기</button> 
        <%} %>
        </div>

      
        
  
    <br>
    <div id="docwrite">
 		
 	
        </div>
    </div> 
    <div id="bottom" align ="center"> 
        <label style="float: left;">첨부파일</label><br>
        <div id= filelist>
        <%if(!files.isEmpty()){ %>
        <%for(int i = 0; i<files.size(); i++){
        	%>
        <a href="/semi/cfDown.ch?path=<%=files.get(i) %>"> <%=files.get(i) %>
							</a><br>
      <%}} %>
        </div>
    </div>
    
    <div id="retruncomment">
      <button id="close3">닫기</button>
        <div id= "comment">
        <%=check.getReturnComment() %>

        </div>
      
    </div>

    <script>
    
		$(function(){
			var text1  = '<%=text%>';
		    var arr = text1.split("/+/");
			
			var type = '<%=doctype%>';
			if(type=="휴가신청서"){
				var vtype;
				if(arr[0]=='L1'){
					vtype = "연차";
				}else if(arr[0]=='L2'){
					vtype = "월차";
				}else{
					vtype = "반차";
				}
				var sDate = arr[1];
				var eDate = arr[2];
				
				var dot ="전일";
				if(arr[3]=='A'){
					dot = "오전";
				}else if(arr[3]=='P'){
					dot = "오후";
				}
				var text = arr[4].split(",");
				
				
				var $span1 = $("<span>");
				var $span2 = $("<span>");
				$span1.text("휴가종류 : ");
				$span2.text(vtype);
				
				$spanday =$("<span>");
				$spanday.text("기간 : ");
				var $inDate1 = $("<input type='date' readonly id='sday'>");
				var $inDate2 = $("<input type='date' readonly id='eday'>");
				$inDate1.val(sDate);
				$inDate2.val(eDate);
				
				var $span3 = $("<span>");
				$span3.text("시간 :" +dot);
				
				console.log(text);
				var $div =$("<div id ='text' style =' border:1px solid black; width:500px; height:500px; overflow:auto;'>");
				$div.html(text);
				//$div.html(text);
				$("#docwrite").append($span1);
				$("#docwrite").append($span2);
				$("#docwrite").append("<br><br>");
				$("#docwrite").append($spanday);
				$("#docwrite").append($inDate1);
				$("#docwrite").append("-")
				$("#docwrite").append($inDate2);
				$("#docwrite").append("<br><br>")
				$("#docwrite").append($span3);
				$("#docwrite").append("<br><br>");
				$("#docwrite").append($div);
				
				
				
			}else if(type=="지출결의서"){
				console.log(arr);
				var length = arr.length;
				console.log(length);
				var paid = arr[length-2];
				var parr= [];
				/* console.log(paid.substring(paid.length-3,paid.length));
				console.log(paid.substring(0,paid.length%3)); */
				for(var i=paid.length; i>0; i=i-3){
					if(i-3>0){
						parr.unshift(','+paid.substring(i-3,i));
					}else{
						parr.unshift(paid.substring(0,paid.length%3));
					}
					
				}
				var text = arr[length-1].split(",");
				//console.log(paid);
				//console.log(text);
				$("#docwrite").html('<span>최종금액 : '+parr.join("")+'</span><br><table id="ttt" style="border:1px solid black;"">'+
				           ' <thead><tr><td width = "40px">번호</td><td width = "150px">물품명</td><td width = "90px">단가</td><td width = "50px";>수량</td><td>단위</td><td width = "90px">금액</td><td width = "150px">비고</td></tr></thead>'+
				            '<tbody id="textm">' +'</tbody>'+'</table>');
				for( var i = 0; i<length-2;i++){
					var textsp = arr[i].split(",");
					$tr = $("<tr>");
					$td1 =$("<td>");
					$td2 =$("<td>");
					$td3 =$("<td class='num'>");
					$td4 =$("<td class='num'>");
					$td5 =$("<td class='num'>");
					$td6 =$("<td class='num'>");
					$td7 =$("<td>");
					$td1.text(textsp[0]);
					$td2.text(textsp[1]);
					$td3.text(textsp[2]);
					$td4.text(textsp[3]);
					$td5.text(textsp[4]);
					$td6.text(textsp[5]);
					$td7.text(textsp[6]);
					
					$tr.append($td1);
					$tr.append($td2);
					$tr.append($td3);
					$tr.append($td4);
					$tr.append($td5);
					$tr.append($td6);
					$tr.append($td7);
					
					$("#textm").append($tr);
				}
				
				$("#ttt td").css("border","1px solid black");
				$(".num").css("text-align","right")
				var $div = $("<div style ='border:1px solid black; width:747px; height:200px; overflow:auto;'>");
				$div.html(text);
		        $("#docwrite").append($div);
			}else{
				
				var $div = $("<div style =' border:1px solid black; width:747px; height:657px; overflow:auto;' >");
				$div.html(arr[0].split(","));
				$("#docwrite").append($div);
			}
		});
   
    </script>

   
    
</body>
<%} else{%><body>권한이 없습니다.</body><%} %>
</html>