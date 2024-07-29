<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .form-section {
            padding: 20px;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .form-group label {
            width: 80px;
            margin-right: 10px;
        }
        .form-group input[type="text"], .form-group textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .form-group input[type="text"]:first-child {
            margin-right: 20px;
        }
        .form-group textarea {
            height: 100px;
            resize: none;
        }
        .file-upload {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        .file-upload label {
            width: 80px;
            margin-right: 10px;
        }
        .file-upload input[type="text"] {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        .file-upload button {
            background-color: #000;
            color: #fff;
            border: none;
            padding: 8px 10px;
            cursor: pointer;
        }
        .form-actions {
            display: flex;
            justify-content: center;
            margin: 20px;
        }
        .form-actions button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin: 0 10px;
        }
        .form-actions .cancel-btn {
            background-color: #444;
            color: #fff;
        }
        .form-actions .submit-btn {
            background-color: #e74c3c;
            color: #fff;
        }
    </style>
</head>

        <div class="form-section">
            <div class="form-group">
                <label for="category">유형:</label>
                <input type="radio" id="category" name="category" value="year"> 연차          
                <input type="radio" id="category" name="category" value="half" style="margin-left: 20px;"> 반차
            </div>
            <div class="form-group">
                <label for="remaining">잔여 휴가:</label>
                
                <label for="period" style="margin-left: 500px;">기간:</label>
                <input type="date" id="period" name="period"> ~
                <input type="date" id="period" name="period">
            </div>
            <div class="form-group">
                <label for=emergency>비상연락:</label>
                <input type="text" id="emergency" name="emergency">
            </div>
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title">
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content" placeholder="휴가 사유을 작성하세요."></textarea>
            </div>
            <div class="file-upload">
                <label for="attachment">첨부파일:</label>
                <input type="text" id="attachment" name="attachment">
                <button>찾기</button>
            </div>
        </div>



