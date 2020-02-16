<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	'<span>휴가 종류</span>'+
	'<select name="leaveCode" id="leaveCode" onchange="leaveCode();">'+
	   '<option value="blank">---</option>'+
	   '<option value="L1">연차</option>'+
	    '<option value="L2">월차</option>'+
	    '<option value="L3">반차</option>'+
	'</select>'+
	'<br><br>'+
	<!-- date 기본값 오늘 날짜 -->'+
	'<span class="startDate">시작(사용) 날짜</span>'+
	'<input type="date" name="startDate" id="startDate" class="startDate">'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
	'<span class="endDate">종료 날짜</span>          <!-- 월차 / 반차 선택 시 disabled -->'+
	'<input type="date" name="endDate" class="endDate">'+
	'<br><br>'+
	'<span class="dayOffType">반차 종류</span>'+
	'<select name="dayOffType" id="dayOffType" class="dayOffType">'+
	    '<option value="black">---</option>'+
	   '<option value="A">오전</option>'+
	    '<option value="P">오후</option>'+
	'</select>'+
	'<br><br>'+
	'<span>휴가 사유</span> <br><br>'+
	'<textarea name="vContent" id="vContent" >'+






















'위와 같은 사유로 휴가서 제출하오니, 승인하여 주시길 바랍니다.'+
   '</textarea>'
