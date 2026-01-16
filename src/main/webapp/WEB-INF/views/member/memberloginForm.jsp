<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 로그인</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
    <script src="${pageContext.request.contextPath}/js/member.js"></script>
</head>
<body class="login-page">

<div class="login-container">
    <div class="login-header">
        <h2>FARM PEOPLE</h2>
        <p>자연의 신선함을 전하는 팜 피플입니다.</p>
    </div>

    <c:if test="${param.error != null}">
        <div class="error-msg">아이디 또는 비밀번호가 일치하지 않습니다.</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/m_spring_security_check">
        <div class="input-group">
            <label for="m_username">아이디</label>
            <input type="text" id="m_username" name="m_username" placeholder="아이디를 입력하세요" required>
        </div>
        
        <div class="input-group">
            <label for="m_password">비밀번호</label>
            <input type="password" id="m_password" name="m_password" placeholder="비밀번호를 입력하세요" required>
        </div>

        <div class="input-group" style="display: flex; align-items: center; gap: 8px; margin-top: -10px; margin-bottom: 25px;">
            <input type="checkbox" id="rememberMe" name="remember-me" style="width: auto; cursor: pointer;">
            <label for="rememberMe" style="margin: 0; font-size: 13px; color: #666; font-weight: 400; cursor: pointer;">로그인 상태 유지</label>
        </div>

        <button type="submit" class="btn-login">로그인하기</button>
    </form>

    <div class="login-footer">
        아직 회원이 아니신가요? <br><br>
        <a href="${pageContext.request.contextPath}/member/memberwriteForm">회원가입 하기</a> 
        <span style="color:#ddd; margin:0 10px;">|</span>
        <a href="${pageContext.request.contextPath}/">홈으로</a>
    </div>
</div>

</body>
</html>