<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.coo.board.model.vo.*"%>
 <% ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<button id="rh">갱신</button>
	<table style="width:80; border-collapse:collapse;" id="boardhome">
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
                        <tbody>
                           	<% if(list != null){ %>
                            <% for(Board b : list){ %>
                               <input type="hidden" value="<%= b.getBno() %>">
                               <td><%=b.getBno() %></td> 
                               <td><%=b.getCategory() %></td>
                               <td><%=b.getBtitle() %></td>
                               <td><%=b.getBwriter() %></td>
                               <td><%=b.getBdate() %></td>
                               <td><%=b.getBcount() %></td>
                           	 <% } %>
                          <% } %>
                          </tbody>
                    </table>
                    <script>
    </script>
</body>
</html>