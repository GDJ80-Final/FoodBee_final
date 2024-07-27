<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="modal fade" id="addReason" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">삭제 사유입력</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
			  <select id="reasonSelect">
			  	 <option value="" disabled selected>삭제 사유를 선택하세요</option>
                 <option value="욕설/비속어">욕설/비속어</option>
                 <option value="광고/스팸">광고/스팸</option>
                 <option value="음란물">음란물</option>
                 <option value="기타">기타</option>
			  
			  </select>
			  <div class="error-message" id="errorMessage">사유입력은 필수입니다.</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" id="addReasonButton">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
