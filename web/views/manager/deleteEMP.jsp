<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		    <form action="" method="POST">
		<table id = "change3" class="managerTable" border="1">
		        <tr>
		            <th colspan="3" style="font-size: 1em; font-family: 고딕; text-align:left;" class="cap">사원삭제</th>
		      </tr>
		      <tr>
		          <td> 사 번 : </td>
		          <td> <input type="text" style="width: 200px;" id="deleteNumber"> <input type="button" value=" 검 색 " onclick="showDeleteList();"></td>
		          <!-- 사지을 가져와서 보여 주어야 됩니다. -->
		          <td rowspan="6" style="border: 1px solid black; width: 300px; height: 300px;"> 
		              <img src="./임시/image/Dobbi.jpg" width="320px" height="320px" id = "Show" > 
		          </td>
		      </tr>
		      <tr>
		          <td> 아이디  </td>
		          <td><label style="width: 300px; height: 24px;" id = "delete1"> 여기에서 출력 됩니다.</label> </td>
		      </tr>
		      <tr>
		          <td> 비밀번호  </td>
		          <td> <label style="width: 300px; height: 24px;" id = "delete2"> 여기에서 출력 됩니다.</label></td>
		      </tr>
		      <tr>
		          <td> 직 급   </td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete3"> 여기에서 출력 됩니다.</label>
		          </td>
		      </tr>
		      <tr>
		          <td> 성 별 </td>
		          <td> <label style="width: 300px; height: 24px;" id = "delete4"> 여기에서 출력 됩니다.</label> </td>
		      </tr>
		      <tr>
		          <td> 부 서 </td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete5"> 여기에서 출력 됩니다.</label>
		          </td>
		      </tr>
		      <tr>
		          <td>이메일</td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete6"> 여기에서 출력 됩니다.</label>
		          </td>
		        <!--   사진 등록 스크립트 onchange 이벤트 발생시로 해야 이미지가 불러 와 진다. -->
		          <td></td>
		      </tr>
		      <tr>
		          <td>주소 </td>
		          <td>
		              <label style="width: 300px; height: 24px;" id = "delete7"> 여기에서 출력 됩니다.</label>
		          </td>
		          
		      </tr>
		      <tr>
		          <td>비 고 </td>
		          <td colspan="2" rowspan="2">
		              <label style="width: 600px; height: 60;" id = "delete8"> 여기에서 출력 됩니다.</label>
		          </td>
		      </tr>
		      <tr>
		      </tr>
		      <tr>
		          <td align="center" colspan="3" class="managerTable">
		            
		              <input type="button" value = " 확 인 " style="width: 150px; height: 50px;" onclick="deleteExecute();"> 
		              &nbsp; &nbsp; 
		              <input type="reset" value = " 취 소 " style="width: 150px; height: 50px;">
		            </td>
		        </tr>
		        
		</table>
		    </form>