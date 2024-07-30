<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <div class="common-section">
        <table>
            <tr>
                <th colspan="2">기안서</th>
                <th>기안자</th>
                <th>중간결재자</th>
                <th>최종결재자</th>
            </tr>
            <tr>
                <td colspan="2">결재</td>
                                  
                <td>
                <input type="number" name="drafterEmpNo" id="drafterEmpNo" value="" readonly>
                
                </td>
                <td id="midApprover">
                <input type="number" name="midApproverNo" id="midApproverNo" value="" readonly>
                <button type="button" id="midApproverBtn" class="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색
                </button>
                </td>
                <td id="finalApprover">
                 <input type="number" name="finalApproverNo" id="finalApproverNo" value="" readonly>
                <button type="button"  id="finalApproverBtn" class="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색
                </button></td>
            </tr>
            <tr class="sign">
                <td colspan="2">결재</td>
                                  
                <td id="drafterSign">기안자 sign </td>
                <td id="midApproverSign">mid approver sign</td>
                <td id="finalApproverSign">final approver sign</td>
            </tr>
            <tr>
                <td>수신참조자</td>
                <td colspan="4">
                
                <input type="text" id="referrerField" style="width:80%;" name="referrerEmpNo" readonly>
                <button type="button"  id="referrer" class="search-btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">검색</button></td>
            </tr>
        </table>
        <div class="form-section">
            <div class="form-group">
                <label for="name">성명:</label>
                <input type="text" id="name" readonly>
                <label for="department" style="margin-left: 10px;">부서:</label>
                <input type="text" id="department" readonly>
            </div>
         </div>
    </div>