
<%@page import="javafx.scene.DepthTest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList , com.coo.check.model.vo.*, com.coo.member.model.vo.Member"%>
 <%
    //게시판
    //문서 
    //둘다 문서 번호 검색해서 가져올것 
    //자신이 포함되 있나 확인   
    //합의자에 자신이 포함된 인덱스 찾기  둘은 자바 스크립트에서
    //세션 아이디 받아오기
    //HttpSession session = 
	Member m = (Member)session.getAttribute("member"); 
 	int id = m.getEmpCode();
 	String sid = Integer.valueOf(id).toString();
    CheckDoc check = (CheckDoc)request.getAttribute("info");
    //사람이름 찾아와야됨.
 	String doctext = (String)request.getAttribute("doc");
    
	String inPe = (check.getInPeople() ==null)?"":check.getInPeople();
	String colPe = (check.getColPeople()==null)?"":check.getColPeople();
	String endPe = (check.getEndPerson()==null)?"":check.getEndPerson();
	String viewPe = (check.getViewPeople()==null)?"":check.getViewPeople();
	String peArr[];
	
	
     
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
		endPe.contains(sid)||
		viewPe.contains(sid)||
	check.getViewPeople().contains(sid))){  %>
<body>  
	<script>
	//잘랐음
		$(function(){
			
		
		var inpea=[];
		if(<%=!inPe.equals("")%>){
			<%peArr = inPe.split(", ");
			for(int i =0; i<peArr.length;i++){
			%>
			inpea.push(<%=peArr[i]%>);
			<%}%>
			
			 var a2 = $("#top2 tr:eq(0)").html();
			 
		 }
		
		 for(var i =0; i*2< inpea.length; i++){
			 $("#top2 tr:eq(0)").html(a2 += "<td id= col+["+i+"]> 정 :" + inpea[i*2] +"<br> 부 :" +inpea[i*2+1]+"</td>");
		 }
		 console.log(inpea);
		
		var colpea=[];
		if(<%=!colPe.equals("")%>){
			<%peArr = colPe.split(", ");
			for(int i =0; i<peArr.length;i++){
			%>
			colpea.push(<%=peArr[i]%>);
			
			<%}%>
			//$.ajax({
			//	url:"csearchname",
			//	type:"get",
			//	arr:{
			//		peArr:colpea
			//	},
			//	success:function(peArr){
			//		colpea=[];
			//		 var a = $("#top3 tr:eq(0)").html();
			//		 for(var i =0; i*2< colpea.length; i++){
			//			 $("#top3 tr:eq(0)").html(a += "<td id= col+["+i+"]> 정 :" + colpea[i*2] +"<br> 부 :" +colpea[i*2+1]);
			//
			//		 }
			//	}
			//})
		 var a = $("#top3 tr:eq(0)").html();
					 for(var i =0; i*2< colpea.length; i++){
						 $("#top3 tr:eq(0)").html(a += "<td id= col+["+i+"]> 정 :" + colpea[i*2] +"<br> 부 :" +colpea[i*2+1]);
			
					 }
			
			
		}
		var endpea=[];
		if(<%=!endPe.equals("")%>){
			<%peArr = endPe.split(", ");
			for(int i =0; i<peArr.length;i++){
			%>
			endpea.push(<%=peArr[i]%>); 
			<%}%>
			console.log(endpea);
		}
		var viewpea=[];
		if(<%=!viewPe.equals("")%>){
			<%peArr = viewPe.split(", ");
			for(int i =0; i<peArr.length;i++){
			%>
			viewpea.push(<%=peArr[i]%>);
			<%}%>
			console.log(viewpea);
		}
		});
		
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
    <div id ="top">

        <div id="top1">
            <table width ="170px">
                <tr>
                    <td rowspan="3" align="center"><!--<img src=<%//ajax에서 가져오기 %> width ="100px" height="140">  --></td>
                    <td align="center" width="90px">시설관리부</td>
                    
                </tr>
                <tr>
                    
                    <td align="center"> 부장</td>
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
                 <%//for(int i = 0; i<?.length; i++{
                    	// <td></td>	
                    	//여기서 만들고 버튼은 자바 스크립트에서
                    	//}%>
                    	<td></td>
            <td></td>
            <td></td>
            <td></td>
                </tr>
                </table>
            </div>
        

        <div id="colaboDept">
                <table width ="80px">
                            <tr>
                            <td  align="center">합의부서</td>
                            
                        </tr>
                        <tr>
                            <td align="center"><%if(check.getColDept()!=null) {%>
                            					<%=check.getDeptCode() %>
                            		<%} %>
                            					</td>
                           
                        </tr>
                        </table>
        </div>

        <div id="top3" style="float: right;">
        <table width ="260px"  align="center">
            <tr><%//여기도 합의 부서 짜기 %>

        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        </table>
        <script>
        	
        
        </script>
        </div>
        <div id="endline">
            <table width ="80px">
                <tr>
                <td  align="center" >최종승인</td>
                
            </tr>
            <tr>
                <td align="center"></td>
               
            </tr>
            </table>
        </div>
         <fieldset id="viewline">
             <legend><label id="view1">&nbsp;참조자&nbsp;</label></legend>
			<%//로직 짜기 %>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <br>
             <br>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>
             <div class="viewper"> 인사부 <br> 김진홍</div>


        </fieldset>
  

    

       
    </div>
    
    <div id ="doc">
        <div id="docinfo">
        <span> 제목 :</span>
        <div style ="display: inline-block; background :white; border :1px solid black; width: 400px;" ><%=check.getaTitle() %></div>
        <div style ="display: inline-block; border :1px solid black;"><%=check.getDocType() %></div>
        <%if(check.getReturnComment() != null){ %>
        <button id="returncbtn">반려코멘트 보기</button> 
        <%} %>
        </div>

      
        
  
    <br>
    <div id="docwrite">
 		<%=doctext %>
 	
        </div>
    </div> 
    <div id="bottom" align ="center"> 
        <label style="float: left;">첨부파일</label><br>
        <div id= filelist>

        </div>
    </div>
    <div id="retruncomment">
        <div id= comment>
        <%//게시판의 반려 코멘트 들어감 %>

        </div>
        <button id="close3">닫기</button>
    </div>

    <script>
    
    </script>

   
    
</body>
<%} else{%><body>1111</body><%} %>
</html>