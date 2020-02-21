<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 			$.ajax({
				url : "요청 주소",
				type: "get/post",
				data: "전달할 값" / {name : "홍길동",age:20},
				async: true /false,(비동기 / 동기 : 사용 여부)
				dataType:"text/html", // 서버에서 응답하는 데이터의 유형
				success:function(data){...},
				error:function(error,code,msg){...},
				complete:function(){...} // 무조건 실행하는 함수
			}) -->
<div id="notice" style="background: #f8f9fa;">
	<div class="table-line" style="width: 100%; height: 100%;">
		<table style="width: 100%; height: 100%; border-collapse: collapse; border: 1px solid #444444;" id="fiveList">
			<thead>
				<tr class='table-line'>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
		</table>
		<script>
		
		ajaxStart();
			function ajaxStart() {
				$.ajax({
					url: "/semi/noticeAjax.no",
					type: "get",
					success:function(data){
						console.log(data);
						$.each(data, function(index,value){
							
							var date = value.ndate;
							var dates = date.split(',');							
							
							var $tr = $('<tr style="font-size: 20px; text-align: center;">');
							var $Nno = $('<td>').text( value.nno); 
							var $Ntitle= $('<td>').text( value.ntitle);
							var $Nwriter = $('<td>').text( value.nwriter);
							var $Ndate=$('<td>').text(dates[1]+" "+dates[0]);
							var $Ncount=$('<td>').text( value.ncount);
							
							$tr.append($Nno);
							$tr.append($Ntitle);
							$tr.append($Nwriter);
							$tr.append($Ndate);
							$tr.append($Ncount);
							
							$('#fiveList').append($tr);
						});
						
						$('#fiveList tr').mouseenter(function(){
							if($(this).children().eq(0).text() != '번호'){
								$(this).css({"background":"yellow", "cursor":"pointer"});
							}
						}).mouseout(function(){
							$(this).css({"background":"snow"});
						}).click(function(){
							var nno = $(this).children().eq(0).text();
							
							if($(this).children().eq(0).text() != '번호'){
								location.href="<%=request.getContextPath()%>/noticeSelectOn?nno=" + nno;
							}
/* 							if($(this).children().eq(0).text() != '번호'){
								window.open("/semi/noticeSelectOn?nno="+nno, "", "width=1200, height=900");
							} */
							
						})
						
					},error:function(){
						console.log("에러입니다.");
					}
				});
			}// end ajaxStart
			
		</script>
	<script>	
/* 		$('#fiveList tr').mouseenter(function(){
			if($(this).children().eq(0).text() != '번호'){
				$(this).css({"background":"yellow", "cursor":"pointer"});
			}
		}).mouseout(function(){
			$(this).css({"background":"snow"});
		}) */
	</script>
	</div>
</div>