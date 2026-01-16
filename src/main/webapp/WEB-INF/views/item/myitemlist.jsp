<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 내 상품 관리</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
    <script src="${pageContext.request.contextPath}/js/item.js"></script>
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE</a>
</header>

<main class="my-item-container">
    <div class="my-item-header">
        <h2>📦 내가 등록한 상품</h2>
        <a href="/item/itemwriteForm" class="btn-main" style="font-size: 14px;">+ 신규 상품 등록</a>
    </div>

    <c:choose>
        <c:when test="${not empty list}">
            <c:forEach var="item" items="${list}">
                <div class="my-item-card">
                    <%-- 상품 썸네일 --%>
                    <img src="/timages/${item.i_timage}" alt="상품이미지" class="my-item-thumb">
                    
                    <%-- 상품 기본 정보 --%>
                    <div class="my-item-details">
                        <a href="itemsellerview?i_no=${item.i_no}" class="name">${item.i_name}</a>
                        <div class="price">
                            <fmt:formatNumber value="${item.i_price}" pattern="#,###" />원
                        </div>
                        <div style="font-size: 12px; color: #999; margin-top: 5px;">상품번호: ${item.i_no}</div>
                    </div>

                    <%-- 관리 액션 버튼 --%>
                    <div class="my-item-actions">
                        <a href="itemsellerview?i_no=${item.i_no}" class="btn-my-action">상세보기</a>
                        <a href="/item/itemupdateForm?i_no=${item.i_no}" class="btn-my-action edit">수정</a>
                        <a href="/item/delete?i_no=${item.i_no}" class="btn-my-action del">삭제</a>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        
        <c:otherwise>
            <div style="text-align:center; padding: 60px 0;">
                <p style="color:#999; margin-bottom: 20px;">아직 등록된 상품이 없습니다.</p>
                <a href="/item/itemwriteForm" class="btn-main">첫 상품 등록하기</a>
            </div>
        </c:otherwise>
    </c:choose>

    <div style="margin-top: 30px;">
        <a href="/" style="color: #666; text-decoration: none; font-size: 14px;">← 이전 페이지로</a>
    </div>
</main>

<footer>
    <p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
</footer>

</body>
</html>