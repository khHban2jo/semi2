<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <html>
 <head><title>확인</title>
 <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 </head>
<body>
<div id="docs" style=" dispaly:inline-block; width: 700px; height : 200px;background: #f8f9fa;">
	<span>결재대기  : <span id="count"></span></span>
	<div class="table-line" style="width: 100%; height: 100%;">
		<table style="width: 100%; height: 100%; border-collapse: collapse; border: 1px solid #444444;" id="">
				<thead>                  
                    <tr class='table-line'>                         
                      <th>번호</th>
                     <th>제목</th>
                     <th>기안자</th>
                     <th>기안부서</th>
                     <th>상태</th>
                     <th>날짜</th>
                  </tr>
                    

			</thead>
			<tbody id = "waitl"></tbody>
		</table>
	<span>기안문서</span>
	<table style="width: 100%; height: 100%; border-collapse: collapse; border: 1px solid #444444;" id="">
			<thead>
				<tr class='table-line1'>
					 <th>번호</th>
                                <th>제목</th>
                                <th>기안자</th>
                                <th>기안부서</th>
                                <th>상태</th>
                                <th>날짜</th>
				</tr>
			</thead>
			<tbody id = "writel"></tbody>
		</table>
		<script>
		
		ajaxS1()
			function ajaxS1() {
				$.ajax({
					url: "/semi/cHIn.ch",
					type: "get",
					success:function(data){
						$("#count").text(data["wc"]);
						var count = data["wl"].length;
						$.each(data["wl"],function(index,item){
							 var $tr = $("<tr style='text-align:center;'>");
            				var $td1 = $("<td style='width:40px;'>");
            				var $td2 = $("<td style='width:200px;'>");
            				var $td3 = $("<td style='width:60px;'>");
            				var $td4 = $("<td style='width:70px;'>");
            				var $td5 = $("<td>");
            				var $td6 = $("<td>");
            				var $input = $("<input type=hidden>");
            				var $span = $("<span>");
            				$span.text(count-index);
            				$input.val(item.docNumber);
            				$td1.append($span);
            				$td1.append($input)
            				var title=item["aTitle"];
            				if(title.length >16){
            					title = title.substring(0,13) +"..."
            				}
           					$td2.text(title);
           					$td3.text(item["awriterName"]);
           					$td4.text(item["deptName"]);
           					var flow;
           					
            				if(item["aStatus"]==0 || item["aStatus"]==1){
            					flow="진행중"
            				}else if(item["aStatus"]==2){
            					flow="결재완료"
            				}else{
            					flow="반려"
            				}
           					$td5.text(flow);
           					var date = item["docDate"].split(",");
           					var date2 =date[0].split("월");
           					if(date2[0].length=1){
           						date2[0]= "0"+date2[0];
           					}
           					date2[1]=date2[1].substring(1,3);
           					date = date[1]+"-"+date2[0]+"-"+date2[1]
           					$td6.text(date);
           					$tr.append($td1);
           					$tr.append($td2);
           					$tr.append($td3);
           					$tr.append($td4);
           					$tr.append($td5);
           					$tr.append($td6);
           					$("#waitl").append($tr); 
						});
						
						
						var count1 = data["wrl"].length;
						$.each(data["wrl"],function(index,item){
							 var $tr = $("<tr style='text-align:center;'>");
            				var $td1 = $("<td style='width:40px;'>");
            				var $td2 = $("<td style='width:200px;'>");
            				var $td3 = $("<td style='width:70px;'>");
            				var $td4 = $("<td style='width:70px;'>");
            				var $td5 = $("<td style=''>");
            				var $td6 = $("<td style=''>");
            				var $input = $("<input type='hidden'>");
            				var $span = $("<span>");
            				$span.text(count1-index);
            				$input.val(item.docNumber);
            				$td1.append($span);
            				$td1.append($input)
            				var title=item["aTitle"];
            				if(title.length >16){
            					title = title.substring(0,13) +"..."
            				}
           					$td2.text(title);
           					$td3.text(item["awriterName"]);
           					$td4.text(item["deptName"]);
           					var flow;
            				if(item["aStatus"]==0 || item["aStatus"]==1){
            					flow="진행중"
            				}else if(item["aStatus"]==2){
            					flow="결재완료"
            				}else{
            					flow="반려"
            				}
           					$td5.text(flow);
           					var date = item["docDate"].split(",");
           					var date2 =date[0].split("월");
           					if(date2[0].length=1){
           						date2[0]= "0"+date2[0];
           					}
           					date2[1]=date2[1].substring(1,3);
           					date = date[1]+"-"+date2[0]+"-"+date2[1]
           					$td6.text(date);
           					$tr.append($td1);
           					$tr.append($td2);
           					$tr.append($td3);
           					$tr.append($td4);
           					$tr.append($td5);
           					$tr.append($td6);
           					$("#writel").append($tr); 
						});
						

					},error:function(){
						console.log("에러입니다.");
					}
				});
			}// end ajaxStart
			$(function(){
				$("#docs table").mouseenter(function(){
					$("#docs td").mouseenter(function(){
					
						$(this).parent().css({"background":"darkgray", "cursor":"pointer"});
					}).mouseout(function(){
						$(this).parent().css({"background":"white"});
					}).click(function(){
						//console.log($(this).parent().find("input[type=hidden]").val());
						var docNumber = $(this).parent().find("input[type=hidden]").val();
					window.open("<%=request.getContextPath()%>/cread.ch?docNumber=" + docNumber,'','target=_blank');
				
					
				

				});
				
				});
				
			});
		</script>
	<script>	
	</script>
	</div>
</div>
</body>
 </html>