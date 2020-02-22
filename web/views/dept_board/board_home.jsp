<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.coo.board.model.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/semi/resources/css/notice/table.css">
<style>
	#boardhome{margin-left:50px;}
	.bc{float:right; margin-left:10px;}
</style>
</head>
<body>
	<button id="rh" class="bc">갱신</button><button id="rh2" class="bc">게시판 바로가기</button>
	<table style="width:90%; border-collapse:collapse; table-layout:fixed;" id="boardhome">
                        <thead>
                            <tr class='table-line'>
                                <th>번호</th>
                                <th>분류</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>조회수</th>
                                <th>날짜</th>
                            </tr>
                        </thead>
                        <tbody id="rhd">
                          </tbody>
                    </table>
          <script>
                   $('#rh').click(function(){

                	   $.ajax({
                    		url:"/semi/bselectFive.bo",
                    		type:"get",
                    		success:function(data){
                    			
                    			$('#boardhome').children().remove();
                    			$.each(data,function(index,value){
                    				var date = value.bdate.split(',');
                    				
                    				var $tr = $('<tr class="table-line tra">');
                    				var $bno = $('<td>').text(value.bno);
                    				var $btype = $('<td>').text(value.btype);
                    				var $btitle = $('<td>').text(value.btitle);
                    				var $bwriter = $('<td>').text(value.bwriter);
                    				var $bdate = $('<td>').text(date[1]+"년 "+date[0]);
                    				var $bcount = $('<td>').text(value.bcount);
                    				
                    				$tr.append($bno);
                    				$tr.append($btype);
                    				$tr.append($btitle);
                    				$tr.append($bwriter);
                    				$tr.append($bcount);
                    				$tr.append($bdate);
                    				
                    				$('#boardhome').append($tr);
                    			});
                    		}
                    	});
                   });
           $('#rh2').click(function(){
        	  location.href="semi/selectList.bo"; 
           });      
    </script>
</body>
</html>