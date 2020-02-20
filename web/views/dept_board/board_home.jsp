<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<table style="width:100%; border-collapse:collapse;" id="boardhome">
                        <thead>
                            <tr class='table-line'>
                                <th>번호</th>
                                <th>분류</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>날짜</th>
                                <th>조회수</th>
                            </tr>
                        </thead>
                    </table>
                    <script>
    	$.ajax({
    		url:"<%=request.getContextPath() %>/b5.bo",
    		type:"post",
    		success:function(data){
    			console.log(data);

    		$.each(data,function(index,value){
    				console.log(data);
					var $tr = $('<tr>');
					var $bno = $('<td>').text(value.bno);
					var $category = $('<td>').text(value.category);
					var $btitle = $('<td>').text(value.btitle);
					var $bwriter= $('<td>').text(value.bwriter);
					var $bdate= $('<td>').text(value.bdate);
					var $bcount = $('<td>').text(value.bcount);
					
					$tr.append($bno);
					$tr.append($category);
					$tr.append($btitle);
					$tr.append($bwriter);
					$tr.append($bdate);
					$tr.append($bcount);					
					
					$('#boardhome').append($tr);
				});
    		}
    	});
    </script>
</body>
</html>