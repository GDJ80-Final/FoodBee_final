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
				<div class="form-row justify-content-center align-items-center mt-3">
		        	<div class="col-auto my-1">
						<select id="office" class="custom-select mr-sm-2">
							<option value="">---본사/지사 선택---</option>
						</select>
			        </div>
		        	<div class="col-auto my-1">
					<select id="dept" class="custom-select mr-sm-2">
						<option value="">---부서 선택---</option>
					</select>
			        </div>
		        	<div class="col-auto my-1">
					<select id="team" class="custom-select mr-sm-2">
						<option value="">---팀 선택---</option>
					</select>
			        </div>
		        	<div class="col-auto my-1">
					<select id="rankName" name="rankName" class="custom-select mr-sm-2">
						<option value="">---직급 선택---</option>
						<option value="사원">사원</option>
						<option value="대리">대리</option>
						<option value="팀장">팀장</option>
						<option value="부서장">부서장</option>
						<option value="지서장">지사장</option>
						<option value="CEO">CEO</option>
					</select>
			        </div>
			  	</div>
			  	<div class="form-row justify-content-center align-items-center mt-3">
			  		<div class="col-auto my-1">
				    	<input type="number" id="empNo" name="empNo" class="form-control-sm" placeholder="사원번호를 입력하세요 ">
				  	</div>
			  		<div class="col-auto my-1">
				    	<button id="searchBtn" type="button" class="btn btn-primary">검색</button>
				  	</div>
			  	</div>
			</form>
		    <table class="table mt-3" id="empList">
		        
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
		   <!-- panel & page -->
			<div class="bootstrap-pagination mt-3" id="page">
		         <nav>
		             <ul class="pagination justify-content-center">
		                 <li class="page-item"><button type="button" id="first" class="page-link">처음</button>
		                 </li>
		                 <li class="page-item"><button type="button" class="page-link" id="pre">이전</button>
		                 </li>
		                 <li class="page-item active"><div class="page-link" id="currentPage">${currentPage}</div>
		                 </li>
		                 <li class="page-item"><button type="button" class="page-link" id="next">다음</button>
		                 </li>
		                 <li class="page-item"><button type="button" class="page-link" id="last">마지막</button>
		                 </li>
		             </ul>
		         </nav>
		     </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>

    