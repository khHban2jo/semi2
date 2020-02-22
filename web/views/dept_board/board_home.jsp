<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.coo.board.model.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
	#boardhome{margin-left:50px; text-align: center;}
	.bc{float:right; margin-left:10px;}
	tr{
	border:1px;
    border-style:none none solid;
    border-color:lightgray;
    height:35px;
	}
</style>
</head>
<body>
	<br>
	<div id="rh3">
	<button id="rh2" class="bc">게시판 바로가기</button>
	<table style="width:90%; border-collapse:collapse; table-layout:fixed;" id="boardhome">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>분류</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>조회수</th>
                                <th>날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
          <script>
                  a();
                	 function a(){
          				$.ajax({
                    		url:"/semi/bselectFive.bo",
                    		type:"get",
                    		success:function(data){
                    			
                    			$.each(data,function(index,value){
                    				var date = value.bdate.split(',');
                    				var $tr = $('<tr>');
                    				var $bno = $('<td>').text(value.bno);
                    				var $category = $('<td>').text(value.category);
                    				var $btitle = $('<td>').text(value.btitle);
                    				var $bwriter = $('<td>').text(value.bwriter);
                    				var $bdate = $('<td>').text(date[1]+"년 "+date[0]);
                    				var $bcount = $('<td>').text(value.bcount);
                    				var $input = $('<input type="hidden">')
                    				$input.val(value.bno);
                    				
                    				$tr.append($input);
                    				$tr.append($bno);
                    				$tr.append($category);
                    				$tr.append($btitle);
                    				$tr.append($bwriter);
                    				$tr.append($bcount);
                    				$tr.append($bdate);

                    				$('#boardhome').append($tr);
                    				
                    			});
                    		}
                    	});
                	 }
           $('#rh2').click(function(){
        	  location.href="/semi/searchBoard.bo?title=all"; 
           });
          
           $(function(){
        	   
           $('#rh3 td').click(function(){
        	   var bno = $(this).parent().find("input").val();
        	   location.href="<%=request.getContextPath() %>/selectOne.bo?bno="+bno;
           	});
          });
    </script>
    </div>
</body>
</html>