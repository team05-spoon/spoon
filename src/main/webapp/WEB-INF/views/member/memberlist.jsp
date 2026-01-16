<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 회원 관리</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
    <script src="${pageContext.request.contextPath}/js/member.js"></script>
</head>
<body>

<div class="admin-container">
    <h2 class="admin-title">👥 회원 관리 목록</h2>

    <table class="member-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>생년월일</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${list}">
                <tr>
                    <td>${member.m_no}</td>
                    <td>
                        <a href="memberview2?m_no=${member.m_no}" class="id-link">
                            ${member.m_id}
                        </a>
                    </td>
                    <td>${member.m_name}</td>
                    <td>${member.m_birth.toLocaleString()}</td>
                    <td>
                        <a href="/member/memberdelete?m_no=${member.m_no}" class="btn-del-small">회원 삭제</a>
                    </td>
                </tr>
            </c:forEach>
            
            <c:if test="${empty list}">
                <tr><td colspan="5" style="padding:40px; color:#999;">가입된 회원이 없습니다.</td></tr>
            </c:if>
        </tbody>
    </table>

    <a href="${pageContext.request.contextPath}/" class="btn-back">← 메인으로 돌아가기</a>
</div>

</body>
</html>