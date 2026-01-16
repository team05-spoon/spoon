<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
    <script src="${pageContext.request.contextPath}/js/member.js"></script>
    <script src="${pageContext.request.contextPath}/js/address.js"></script>
</head>
<body style="background-color: #f4f7f6;">

<div class="write-container">
    <h2 class="write-title">FARM PEOPLE</h2>
    <p style="text-align: center; color: #666; margin-bottom: 30px;">새로운 회원을 환영합니다!</p>

    <form name="memberwriteForm" method="post"
          action="${pageContext.request.contextPath}/member/memberwrite"
          onsubmit="return validateMemberWrite()">

        <div class="form-group">
            <label>아이디</label>
            <input type="text" name="m_id" placeholder="사용할 아이디를 입력하세요">
        </div>

        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="m_pw" placeholder="비밀번호를 입력하세요">
        </div>

        <div class="form-group">
            <label>이름</label>
            <input type="text" name="m_name" placeholder="실명을 입력하세요">
        </div>

       <div class="form-group">
    		<label>전화번호</label>
    		<input type="text" name="m_tel" placeholder="숫자만 11자리 입력 (예: 01012345678)" maxlength="11">
		</div>

		<div class="form-group">
    		<label>이메일</label>
    		<input type="text" name="m_email" placeholder="example@farm.com">
		</div>

        <div class="form-group">
            <label>주소</label>
            <div style="display: flex; gap: 5px; margin-bottom: 5px;">
                <input type="text" name="m_zip" id="zipNo" placeholder="우편번호" readonly style="width: 120px; flex: none;">
                <button type="button" onclick="goPopup()" style="padding: 0 15px; background-color: #fff; border: 1px solid #000; cursor: pointer; font-size: 13px; font-weight: bold;">우편번호검색</button>
            </div>
            <input type="text" name="m_addr" id="roadFullAddr" placeholder="검색된 주소가 여기에 표시됩니다" readonly>
            </div>

        <div class="form-group">
            <label>생일</label>
            <input type="date" name="m_birth">
        </div>

        <button type="submit" class="btn-write">회원가입 완료</button>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/member/memberloginForm" style="color: #888; text-decoration: none; font-size: 13px;">이미 계정이 있으신가요? 로그인</a>
        </div>
    </form>
</div>

</body>
</html>
