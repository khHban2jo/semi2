
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.coo.check.model.vo.*,java.util.ArrayList"%>
<%
	ArrayList<CheckDoc> list = (ArrayList<CheckDoc>) request.getAttribute("list");
	PageInfo pi = (PageInfo) request.getAttribute("pi");
	int status = (Integer)request.getAttribute("st");
	int listCount = pi.getCheckListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPaging();
	int startPage = pi.getStartPaging();
	int endPage = pi.getEndPaging();
	int limitpage = pi.getLimitPage();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>COO - 결재 게시판</title>

<link rel="stylesheet" href="/semi/resources/css/common/basic.css">
<link rel="stylesheet" href="/semi/resources/css/notice/button.css">
<link rel="stylesheet" href="/semi/resources/css/notice/margin.css">
<link rel="stylesheet" href="/semi/resources/css/notice/table.css">



</head>
<body>
	<div class="total">
		<!-- 헤더부분 include -->
		<%@ include file="common/COO_header.jsp"%>

		<!-- 화면 좌측 고정부 include -->
		<%@ include file="common/COO_left.jsp"%>

		<div class="right">
			<!-- 게시판 시작 -->
			<div class="margin-list-head">
				<h2 style="color: #767676;" align="left">
					결재 게시판
					</h1>
					<hr color="lightgray">
					<button type="button" class="btn btn-light" id="all">
						전체
					</button>
					<button type="button" class="btn btn-primary" id="writed">
						제안
					</button>
					<button type="button" class="btn btn-wait " id="wait">
						결재대기
					</button>
					<button type="button" class="btn btn-info" id="flow">
						진행중
					</button>
					<button type="button" class="btn btn-success" id="end">
						결재완료
					</button>
					<button type="button" class="btn btn-warning" id="return">
						반려
					</button>

					<br> &nbsp;

					<script>
                function pagemove(item){
                	var status = $("#pStatus").val();
                	var getCP =  $(item).find("input").val();
                	var search =$("#search").val(); 
                	var keyword =$("#keyword").val();
                	$.ajax({
                		
                		url:"/semi/calist.ch",
                		type:"get",
                		data:{
                			currentPage: getCP,
                			status : status,
                			search : search,
                			keyword :keyword
                		},
                		success:function(data){
                            $("#listbody").children().remove();
                			var list = data["list"];
                			var pi = data["pi"];
                			var listCount = parseInt(pi["checkListCount"]) - ((parseInt(pi["currentPage"])-1)* parseInt(pi["limitPage"]));
 
                			for(var i = 0; i<list.length; i++){
                				var count = listCount- i;
                	
                				var $tr = $("<tr>");
                				var $td1 = $("<td>");
                				var $td2 = $("<td>");
                				var $td3 = $("<td>");
                				var $td4 = $("<td>");
                				var $td5 = $("<td>");
                				var $td6 = $("<td>");
                				var $input = $("<input type=hidden>");
                				var $span = $("<span>");
                				$span.text(count);
                				$input.val(list[i]["docNumber"]);
                				$td1.append($span);
                				$td1.append($input)
               					$td2.text(list[i]["aTitle"])
               					$td3.text(list[i]["awriterName"])
               					$td4.text(list[i]["deptName"])
               					var flow;
                				if(list[i]["aStatus"]==0 || list[i]["aStatus"]==1){
                					flow="진행중"
                				}else if(list[i]["aStatus"]==2){
                					flow="결재완료"
                				}else{
                					flow="반려"
                				}
               					$td5.text(flow);
               					var date = list[i]["docDate"].split(",");
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
               					$("#listbody").append($tr);
                			} 
                			//button disabled
               
                			//pagingArea
                			$("#pagingArea").empty();
                			var pcp =parseInt(pi["currentPage"]);
                			//<<
                			var $buttonf =  $('<button onclick="pagemove(this);">');
                			$buttonf.append('<input type="hidden" value="1">' + "<<");
                				
                			//<
                			var $buttonp=$("<button>");
                			$buttonp.append('<input type="hidden" value="'+(pcp - 1)+'">' + "<");
                			if(pcp == 1){
                				$buttonp.attr("disabled","true");
                			}else{
                				$buttonp.attr("onclick","pagemove(this)");
                			}
                			$("#pagingArea").append($buttonf);
                			$("#pagingArea").append("&nbsp;");
                			$("#pagingArea").append($buttonp);
                			$("#pagingArea").append("&nbsp;");
                			var pis = parseInt(pi["startPaging"]);
                			var pie = parseInt(pi["endPaging"]);
                			for(var i = pis; i<=pie; i++ ){
                				var $button = $("<button>");
                				$button.append("<input type=hidden value='"+i+"'>" + i);
                				
                				if( i ==pcp){
                					$button.attr("disabled","true");
                				}else{
                					$button.attr("onclick","pagemove(this)");
                				}
                				
                				$("#pagingArea").append($button);
                				$("#pagingArea").append("&nbsp;");
                				
                			}
                			
                			if(pie == 0){
                				$("#pagingArea").append("<button disabled>1</button>");
                				$("#pagingArea").append("&nbsp;");
                			}
                			
                			
                		
                			//>
                			var pmp = parseInt(pi["maxPaging"]);
                			$buttonN = $("<button>");
                			$buttonN.append("<input type=hidden value='"+(pcp+1)+"'>" + ">");
                			if(pcp == pmp){
                				$buttonN.attr("disabled","true");
                			}else{
                				$buttonN.attr("onclick","pagemove(this)");
                			}
                			//>>
                			var $buttonM =  $('<button onclick="pagemove(this);">');
                			$buttonM.append('<input type="hidden" value="'+pmp+'">'+">>");
                			$("#pagingArea").append($buttonN);
                			$("#pagingArea").append("&nbsp;");
                			$("#pagingArea").append($buttonM);
                			$("#pagingArea").append("&nbsp;");
                			
                		},
                		error:function(){
                			alert("페이징 에러")
                		}
                	}) 
                }
                
                
                	$("#all").click(function(){
                		$("#pStatus").val(0)
                		$("#search").val("0");
                		$("#keyword").val("");
                		pagemove($(this));
                	})
                	$("#flow").click(function(){
                		$("#search").val("0");
                		$("#pStatus").val(1);
                		$("#keyword").val("");
                		pagemove($(this));
                	})
                	$("#end").click(function(){
                		$("#search").val("0");
                		$("#pStatus").val(2);
                		$("#keyword").val("");
                		pagemove($(this));
                	})
                	$("#return").click(function(){
                		$("#search").val("0");
                		$("#pStatus").val(3);
                		$("#keyword").val("");
                		pagemove($(this));
                	})
                	$("#wait").click(function(){
                		$("#search").val("0");
                		$("#pStatus").val(4);
                		$("#keyword").val("");
                		pagemove($(this));
                	});
                	$("#writed").click(function(){
                		$("#search").val("0");
                		$("#pStatus").val(5);
                		$("#keyword").val("");
                		pagemove($(this));
                	})
               
                </script>
            <br><br>
					<select id="search" name="search"
								style="height: 24px; margin-left: 220px; position: relative; left: 534px;">
								<option value="0">-----</option>
								<option value="1">제목</option>
								<option value="2">기안자</option>
							</select>&nbsp; <input class="form-control" type="text" id="keyword"
								name="keyword" placeholder="검색어를 입력하세요" style="width: 200px; height: 18px; position: relative; left: 534px;" >

							<button id="btn" onclick="pagemove(this);" style="position: relative; left: 534px; height: 24px; background-color:#017DD6; color:white; border:0;">
								<input type="hidden" value="1">검색
							</button>
					<div class="table-line">
						<input type="hidden" id="pStatus" value="<%=status%>">
						<table style="width: 100%; border-collapse: collapse;" id="list">
						<br><br>
							<thead>
								<tr class='table-line'>
									<th style="background-color: #EEEEED">번호</th>
									<th style="background-color: #EEEEED">제목</th>
									<th style="background-color: #EEEEED">기안자</th>
									<th style="background-color: #EEEEED">기안부서</th>
									<th style="background-color: #EEEEED">상태</th>
									<th style="background-color: #EEEEED">날짜</th>
								</tr>
							</thead>
							<tbody id="listbody" style="text-align: cente;">
								<%
									int i = listCount - ((currentPage - 1) * limitpage);
								%>
								<%
									for (CheckDoc b : list) {
								%>
								<tr>
									<!--  <td><input type="checkbox">  </td>-->
									<td><input type="hidden" class="docno"
										value="<%=b.getDocNumber()%>"><%=i%></td>
									<td><%=b.getaTitle()%></td>
									<td><%=b.getAwriterName()%></td>
									<td><%=b.getDeptName()%></td>
									<%
										if (b.getaStatus() == 0 || b.getaStatus() == 1) {
									%>
									<td>결재중</td>
									<%
										} else if (b.getaStatus() == 2) {
									%><td>결재완료</td>
									<%
										} else {
									%><td>반려</td>
									<%
										}
									%>

									<td><%=b.getDocDate()%></td>
								<tr>
									<%
										i--;
										}
									%>
								
							</tbody>
						</table>
						<button id="write" class="btn btn-light"
							style="margin-left: 980px; position: relative; background-color:#017DD6; color:white; border:0;"
							onclick="window.open('views/checkdoc/writedoc.jsp','COO-전자결재' ,'target:_blank;');">글쓰기</button>
						<br>
						<div>
						<br>
							
							<div class="pagingArea" id="pagingArea" align="center">
								<button onclick="pagemove(this);">
									<input type="hidden" value="1"><<
								</button>

								<button disabled><</button>


								<%
									for (int p = startPage; p <= endPage; p++) {
										if (p == currentPage) {
								%>
								<button disabled><%=p%></button>
								<%
									} else {
								%>
								<button onclick="pagemove(this);">
									<input type="hidden" value="<%=p%>"><%=p%></button>
								<%
									}
								%>
								<%
									}
								%>

								<%
									if (currentPage >= maxPage) {
								%>
								<button disabled>></button>
								<%
									} else {
								%>
								<button onclick="pagemove(this);">
									<input type="hidden" value="<%=currentPage + 1%>">>
								</button>
								<%
									}
								%>
								<button onclick="pagemove(this);">
									<input type="hidden" value="<%=pi.getMaxPaging()%>">>>
								</button>


							</div>
						</div>
					</div>
			</div>
		</div>

		<!-- 풋터 부분 include -->
		<%@ include file="common/COO_footer.jsp"%>
	</div>
	<script>



$(function(){
	$("#list").mouseenter(function(){
		$("#list td").mouseenter(function(){
			$(this).parent().css({"background":"darkgray", "cursor":"pointer"});
	
		}).mouseout(function(){
			$(this).parent().css({"background":"white"});
		}).click(function(){
			
			var docNumber = $(this).parent().find("input[type=hidden]").val();
			
			<%--location.href="<%=request.getContextPath()%>/cread.ch?docNumber=" + docNumber;--%>
		window.open("<%=request.getContextPath()%>/cread.ch?docNumber=" + docNumber,'','top=80px, left=250px width=1220px,height=710px, resizable=no, location=no, toolbars=no,scrollbars=no');
	


	});
	
	});
	
});



   
</script>


</body>
</html>