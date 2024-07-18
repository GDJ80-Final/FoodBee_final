<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
	}

	.form-container {
	    width: 50%;
	    margin: 50px auto;
	    padding: 20px;
	    background-color: #fff;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	td {
	    padding: 10px;
	    vertical-align: top;
	}
	
	label {
	    font-weight: bold;
	}
	
	input[type="text"],
	input[type="file"],
	textarea {
	    width: 100%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	textarea {
	    height: 200px;
	    resize: none;
	}
	
	.search-btn {
	    margin-left: 10px;
	    padding: 8px 12px;
	    background-color: #f0f0f0;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    cursor: pointer;
	}
	
	.search-btn:hover {
	    background-color: #e0e0e0;
	}
	
	.form-buttons {
	    display: flex;
	    justify-content: flex-end;
	}
	
	.cancel-btn,
	.send-btn {
	    padding: 10px 20px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	}
	
	.cancel-btn {
	    background-color: #ccc;
	    margin-right: 10px;
	}
	
	.send-btn {
	    background-color: #4CAF50;
	    color: white;
	}
	
	.send-btn:hover {
	    background-color: #45a049;
	}
	
	.cancel-btn:hover {
	    background-color: #b0b0b0;
	}
	
		/* Modal Styles */
	.modal {
	    display: none;
	    position: fixed;
	    z-index: 1;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgb(0,0,0);
	    background-color: rgba(0,0,0,0.4);
	}
	
	.modal-content {
	    background-color: #fefefe;
	    margin: 15% auto;
	    padding: 20px;
	    border: 1px solid #888;
	    width: 80%;
	    max-width: 500px;
	    border-radius: 10px;
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	#employee-list {
	    list-style-type: none;
	    padding: 0;
	}
	
	#employee-list li {
	    padding: 8px;
	    border-bottom: 1px solid #ccc;
	    cursor: pointer;
	}
	
	#employee-list li:hover {
	    background-color: #f0f0f0;
	}

</style>
</head>
<body>
	 <div class="form-container">
	 	<form method="post" action="${pageContext.request.contextPath}/addMsg" id="addMsgForm" enctype="multipart/form-data">
	        <table>
	            <tr>
	                <td><label for="recipient">받는사람:</label></td>
	                <td>
	                    <input type="text" id="recipient">
	                    <button class="search-btn" onclick="openModal()" type="button">검색</button>
	                </td>
	            </tr>
	            <tr>
	                <td><label for="subject">제목:</label></td>
	                <td><input type="text" id="subject"></td>
	            </tr>
	            <tr>
	                <td><label for="msgFile">첨부파일:</label></td>
	                <td><input type="file" id="msgFile"></td>
	            </tr>
	            <tr>
	                <td colspan="2">
	                    <label for="message">쪽지쓰기:</label>
	                    <textarea id="message" placeholder="쪽지쓰기 textarea"></textarea>
	                </td>
	            </tr>
	            <tr>
	                <td colspan="2" class="form-buttons">
	                    <button class="cancel-btn">취소</button>
	                    <button class="send-btn">보내기</button>
	                </td>
	            </tr>
	        </table>
        </form>
    </div>
    
    <!-- Modal -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>사원 검색</h2>
            <input type="text" id="search-employee" placeholder="사원 이름 검색">
            <button onclick="searchEmployee()">검색</button>
            <ul id="employee-list">
                <!-- 검색 결과 목록 -->
            </ul>
        </div>
    </div>
<script>
	function openModal() {
	    document.getElementById('modal').style.display = 'block';
	}
	
	function closeModal() {
	    document.getElementById('modal').style.display = 'none';
	}
	
	function searchEmployee() {
	    const searchValue = document.getElementById('search-employee').value.toLowerCase();
	    const employeeList = [
	        '김철수',
	        '이영희',
	        '박민수',
	        '최지은'
	    ];
	
	    const filteredEmployees = employeeList.filter(employee =>
	        employee.toLowerCase().includes(searchValue)
	    );
	
	    const employeeListElement = document.getElementById('employee-list');
	    employeeListElement.innerHTML = '';
	
	    filteredEmployees.forEach(employee => {
	        const li = document.createElement('li');
	        li.textContent = employee;
	        li.onclick = () => {
	            document.getElementById('recipient').value = employee;
	            closeModal();
	        };
	        employeeListElement.appendChild(li);
	    });
	}
	
	window.onclick = function(event) {
	    const modal = document.getElementById('modal');
	    if (event.target === modal) {
	        closeModal();
	    }
	}
</script>
</body>
</html>