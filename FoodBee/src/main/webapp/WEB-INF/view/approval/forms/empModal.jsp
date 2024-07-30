<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 모달 -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">사원검색</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
			  <form>
				<div>
					본사/지사
					<select id="office">
						<option value="">---본사/지사 선택---</option>
					</select>
					부서
					<select id="dept">
						<option value="">---부서 선택---</option>
					</select>
					팀
					<select id="team">
						<option value="">---팀 선택---</option>
					</select>
					직급 
					<select id="rankName" name="rankName">
						<option value="">---직급 선택---
						<option value="사원">사원
						<option value="대리">대리
						<option value="팀장">팀장
						<option value="부서장">부서장
						<option value="지서장">지사장
						<option value="CEO">CEO
					</select>
				</div>
				<div>
					사원 번호
					<input type="number" id="empNo" name="empNo">
					
					<button id="searchBtn" type="button">검색</button>
				</div>
			</form>
		    <table class="table" id="empList">
		        
		            <tr>
		                <th>본사/지사</th>
						<th>부서</th>
						<th>팀</th>
						<th>직급</th>
						<th>사원번호</th>
						<th>사원명</th>
		                <th>선택</th>
		            </tr>
		        
		   </table>
		   <div id="page">
		        <button type="button" id="first">First</button>
		        <button type="button" id="pre">◁</button>
		        <button type="button" id="next">▶</button>
		        <button type="button" id="last">Last</button>
		   </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>

    