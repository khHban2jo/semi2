<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCtype html>
 <div id="lineList" >
                        <table> 
                            <tbody>
                            <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                            </tr>
                            <tr>
                                <td width ="80px">결재부서</td>
                                <td class ="deptview">기획부</td>
                            </tr>
                            <tr>
                                <td style="height: 40px;">결재자</td>
                                <td class="people"></td>
                            </tr>
                        </tbody>

                        
                    </table>
                   
                    <input type="hidden" class ="hiddenper">
                    <input type="hidden" name ="checkdept" class ="checkdept">
                    <input type="hidden" name ="checkper" class ="checkper">
                        <table>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr >
                                        <td width ="80px" >합의/수신</td>
                                        <td class ="deptview" colspan="3"><%//어디선가 끌고오겠지 %></td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="height: 40px;">결재자</td>
                                        <td colspan="3" class="people"></td>
                                    </tr>
                                </tbody>
                            </table>
                             <!--<input type="text" name ="checkper" class ="hiddenper">-->
                             <input type="hidden" class ="hiddenper">
                             <input type="hidden" name ="coldept " class ="coldept">
                             <input type="hidden" name ="colper" class ="colper">
                            <table> 
                                <tbody>
                                    <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 40px;">최종결재자</td>
                                        <td class="people2" colspan="3"></td>
                                    </tr>
                                    </tbody>
                                </table>
                                  <!--<input type="text" name ="checkper" class ="hiddenper">-->
                                <input type="hidden" class ="hiddenper1">
                                <input type="hidden" name ="endper" class ="endper">
                    
                        <table>
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr >
                                        <td style="height: 40px;">참조자</td>
                                        <td class="people2" colspan="3"></td>
                                 </tr>
                                </tbody>
                            </table>
                              <!--<input type="text" name ="checkper" class ="hiddenper">-->
                             <input type="hidden" name ="viewper" class ="hiddenper1">
                            <input type="hidden" name ="viewper" class ="viewper">
                    </div>