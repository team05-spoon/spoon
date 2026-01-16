<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 관리자 통합 정보</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
    <script src="${pageContext.request.contextPath}/js/member.js"></script>
</head>
<body>

<div class="view-container">
    <h2 class="admin-title">👤 회원 기본정보</h2>
    <table class="view-table">
        <tr>
            <td>회원 번호</td>
            <td>${view.m_no}</td>
            <td>회원 아이디</td>
            <td>${view.m_id}</td>
            <td>회원 이름</td>
            <td>${view.m_name}</td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td>${view.m_tel}</td>
            <td>이메일</td>
            <td>${view.m_email}</td>
            <td>주소</td>
            <td>${view.m_addr}</td>
        </tr>
        <tr>
            <td>생일</td>
            <td colspan="5">${view.m_birth.toLocaleString()}</td>
        </tr>
    </table>

    <h2 class="admin-title" style="margin-top:50px;">🏭 판매자 상세정보</h2>
    <c:if test="${not empty seller}">
        <table class="view-table" style="border-top: 2px solid #444;">
            <tr>
                <td>판매자 번호</td>
                <td>${seller.s_no}</td>
                <td>판매자 이름</td>
                <td>${seller.s_name}</td>
                <td>사업자 번호</td>
                <td>${seller.s_bn}</td>
            </tr>
            <tr>
                <td>대표 번호</td>
                <td>${seller.s_num}</td>
                <td>판매자 상태</td>
                <td style="color:#2f7d32; font-weight:bold;">${seller.s_temp}</td>
                <td>회원 번호</td>
                <td>${seller.m_no}</td>
            </tr>
        </table>
    </c:if>
    <c:if test="${empty seller}">
        <p style="padding:30px; text-align:center; color:#999; border: 1px dashed #ccc; border-radius:10px;">
            이 회원은 판매자 정보가 없습니다.
        </p>
    </c:if>
        <a href="${pageContext.request.contextPath}/member/memberlist" class="btn-list">목록으로</a>
    </div>
</body>
</html>
