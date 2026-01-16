<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 회원 정보 수정</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
    <script src="${pageContext.request.contextPath}/js/member.js"></script>
    <script src="${pageContext.request.contextPath}/js/address.js"></script>
</head>
<body>

<div class="update-container">
    <h2 class="admin-title">👤 회원 정보 수정</h2>

    <form name="member" method="post" action="${pageContext.request.contextPath}/member/memberupdate" onsubmit="return validateUpdate()">
        <input type="hidden" name="m_no" value="${update.m_no}">
        
        <table class="update-table">
            <tr>
                <td>아이디</td>
                <td class="readonly-text">${update.m_id}</td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="m_pw" placeholder="비밀번호 변경 시에만 입력하세요"></td>
            </tr>
            <tr>
                <td>이름</td>
                <td class="readonly-text">${update.m_name}</td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><input type="text" name="m_tel" value="${update.m_tel}"></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><input type="text" name="m_email" value="${update.m_email}"></td>
            </tr>
        <tr>
    <td>주소</td>
    <td>
        <div style="display: flex; gap: 5px; margin-bottom: 5px;">
            <%-- value 부분에 값이 없을 경우를 대비해 기본값 처리를 하거나 c:out 사용 --%>
            <input type="text" id="zipNo" 
                   value="${update.m_addr != null ? update.m_addr : ''}" 
                   placeholder="우편번호" readonly style="width: 120px; flex: none;">
            <button type="button" onclick="goPopup()" 
                    style="padding: 0 15px; background-color: #fff; border: 1px solid #000; cursor: pointer; font-size: 13px; font-weight: bold;">
                우편번호검색
            </button>
        </div>
        <input type="text" name="m_addr" id="roadFullAddr" 
               value="${update.m_addr != null ? update.m_addr : ''}" 
               placeholder="검색된 주소가 여기에 표시됩니다" readonly style="width: 100%;">
    </td>
</tr>
            <tr>
                <td>생일</td>
                <td class="readonly-text">
                    <fmt:formatDate value="${update.m_birth}" pattern="yyyy년 MM월 dd일" />
                </td>
            </tr>
        </table>

        <div class="btn-group">
            <input type="submit" value="수정하기" class="btn-submit">
            <input type="button" value="취소하기" class="btn-cancel" onclick="history.back()">
        </div>
    </form>
</div>
</body>
</html>