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
	<div class="table-line">
		<table style="width: 100%; border-collapse: collapse;" id="list">
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
			function ajaxStart() {
				$.ajax({
					url : "/semi/noticeAjax.no",
					type : "get",
					success:function(data) {
						$.each(data, function(index, value) {
							var $tr = $('<tr>');
							var $noticeNo = $('<td>').text(value.Nno);
							var $noticeTitle = $('<td>').text(value.Ntitle);
							var $noticeWriter = $('<td>').text(value.Nwriter);
							var $noticeDate = $('<td>').text(value.Ndate);
							var $noticeCount = $('<td>').text(value.Ncount);

							$tr.append($noticeNo);
							$tr.append($noticeTitle);
							$tr.append($noticeWriter);
							$tr.append($noticeDate);
							$tr.append($noticeCount);

							$('#list').append($tr);
						});
					},error:function() {
						alert("에러가 발생 했습니다.");
					}
				});
			}// end ajaxStart
			
			setInterval("ajaxStart()", 1000 * 60 * 60);

		</script>
	</div>
</div>