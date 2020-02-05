<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%//직원테이블에서 부서 및 필요한 값 들고 오기
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
        <ol>
            <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class =".dept">기획부</label>
                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
                <li><input type ="checkbox" class ="person1"><label>201 부장 이윤석</label></li>
                <li><input type ="checkbox" class ="person1"><label>202 과장 펭수</label></li>
                <li><input type ="checkbox" class ="person1"><label>203 팀장 김진수</label></li>
                <li><input type ="checkbox" class ="person1"><label>204 대리 김국진</label></li>
            </ul>
            
            <li class ="qe"><input type ="checkbox" class ="deptcheck"><label class =".dept">기획부</label>
                <input type="button" class="fold"  value ="+">
            </li>
            <ul class ="de">
                <li><input type ="checkbox" class ="person1"><label>208 부장 이윤석</label></li>
                <li><input type ="checkbox" class ="person1"><label>209 과장 펭수</label></li>
                <li><input type ="checkbox" class ="person1"><label>210 팀장 김진수</label></li>
                <li><input type ="checkbox" class ="person1"><label>211 대리 김국진</label></li>
            </ul>
            
            
        </ol>
        

    </ul>
      


    

    </div>
</fieldset>

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
        <input type="button" value ="넣기" class ="enter">
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
        <input type="button" value ="넣기" class ="enter">
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
        <input type="button" value ="넣기" class ="enter">
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
        <form>
         <input type ="text" name ="chedept" id="chedept" value="">
         <input type ="text" name= "cheper" id="cheper" value="">
         <input type ="text" name= "coladept" id ="coladept" value="">
         <input type ="text" name= "colaper" id = "colaper" value="">
         <input type ="text" name= "resper" id = "resper" value="">
         <input type ="text" name= "endper" id = "endper" value="">
         <input type="submit" onclick ="return end()" value="전송">
        </form>
    </div>
    <input type="button" value ="닫기" onclick="close1();" id ="clo">
</div>


    <!--결제선 가져오기-->

    <div id="backdiv">

      

    </div>
    <div id="seldiv">
        <select id="deptsel">
            <%//결제 관련 테이블에서 dept 다른것들 option 출력 %>
        </select>
        <select id="pushper1">
            <option value="save1">결제라인1</option>
            <option value="save2">결제라인2</option>
            <option value="save3">결제라인3</option>
        </select>
        <select id="pushper2">
            <option value="save1">결제라인1</option>
            <option value="save2">결제라인2</option>
            <option value="save3">결제라인3</option>
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

    

    <script>
 
    </script>
</div> 
</div>
</body>
</html>