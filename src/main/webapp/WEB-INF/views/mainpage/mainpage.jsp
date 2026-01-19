<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 농수산물 직거래</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE</a>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/notice/noticelist" class="notice-link">📢 공지사항</a>
    </div>
</header>

<section class="top-banner">
    <div class="banner-content">
        <h1>오늘 우리 집 식탁이 <span style="color:#ffeb3b;">풍년</span>입니다</h1>
        <p>산지에서 식탁까지, 가장 완벽한 상태로 직송합니다</p>
    </div>
</section>

<div class="category-section">
    <div class="category-container">
        <a href="${pageContext.request.contextPath}/item/itemlist" class="cat-btn all-items">
            <span class="icon">📦</span>
            <span class="label">전체상품</span>
        </a>
        <a href="${pageContext.request.contextPath}/item/itemlist?i_ctg=fruit" class="cat-btn">
            <span class="icon">🍎</span>
            <span class="label">과일</span>
        </a>
        <a href="${pageContext.request.contextPath}/item/itemlist?i_ctg=meat" class="cat-btn">
            <span class="icon">🥩</span>
            <span class="label">육류</span>
        </a>
        <a href="${pageContext.request.contextPath}/item/itemlist?i_ctg=seafood" class="cat-btn">
            <span class="icon">🐟</span>
            <span class="label">수산물</span>
        </a>
        <a href="${pageContext.request.contextPath}/item/itemlist?i_ctg=vegetable" class="cat-btn">
            <span class="icon">🍯</span>
            <span class="label">채소</span>
        </a>
    </div>
</div>

<aside class="quick-menu">
    <c:choose>
        <c:when test="${not empty pageContext.request.userPrincipal}">
            <div class="quick-head">
                <div class="user-badge">${member.m_temp}</div>
                <div class="user-info">${pageContext.request.userPrincipal.name}님</div>
            </div>
            <div class="quick-list">
                <c:choose>
                    <c:when test="${member.m_temp eq 'ADMIN'}">
                        <a href="/member/memberlist">👥 회원 목록</a>
                        <a href="/seller/sellerlist2">🏢 판매자 목록</a>
                        <a href="/seller/sellerlist">📩 판매 신청 내역</a>
                        <a href="${pageContext.request.contextPath}/item/adminitemlist">📦 전체 상품 관리</a>
                    </c:when>
                    <c:when test="${member.m_temp eq 'SELLER'}">
                        <a href="/item/itemwriteForm">✍️ 신규 상품 등록</a>
                        <a href="/item/myitemlist">🛒 내 상품 관리</a>
                    </c:when>   
                    <c:otherwise>
                        <a href="/item/itemlist">🛒 상품 쇼핑하기</a>
                        <a href="/seller/sellerwriteForm" style="color:#ffeb3b; font-weight:bold;">🌱 판매자 신청하기</a>
                    </c:otherwise>
                </c:choose>
                <a href="/member/memberview?m_no=${member.m_no}">👤 마이페이지</a>
                <a href="/cart/cartlist">🛒 내 장바구니</a>
                <a href="/order/orderlist">📜 주문 내역</a>
                <a href="/notice/noticelist">📢 공지사항</a>
                <a href="/board/boardlist" style="color:#ffeb3b;">📝 자유 게시판</a>
                <a href="/logout" style="background:rgba(0,0,0,0.2);">🔓 로그아웃</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="quick-head"><div class="user-info">Welcome!</div></div>
            <div class="quick-list">
                <a href="${pageContext.request.contextPath}/member/memberloginForm">🔑 로그인</a>
                <a href="${pageContext.request.contextPath}/member/memberwriteForm">📝 회원가입</a>
                <a href="${pageContext.request.contextPath}/board/boardlist">📝 자유 게시판</a>
            </div>
        </c:otherwise>
    </c:choose>
</aside>

<main class="container">
    <h2 class="section-title">지금 가장 핫한 <b>신선 먹거리</b></h2>
    <div class="product-grid">
        <c:choose>
            <c:when test="${not empty newItems}">
                <c:forEach var="i" items="${newItems}" varStatus="st">
                    <c:if test="${st.count <= 8}">
                        <a href="${pageContext.request.contextPath}/item/itemmemberview?i_no=${i.i_no}" class="product-card">
                            <div class="img-box" style="background-image:url('${pageContext.request.contextPath}/timages/${i.i_timage}');"></div>
                            <div class="info-tag">[산지직송]</div>
                            <div class="info-name">${i.i_name}</div>
                            <div class="info-price">
                                <fmt:formatNumber value="${i.i_price}" pattern="#,###"/>원
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="grid-column: span 4; text-align:center; padding: 100px 0; color: #999;">
                    현재 등록된 신선 상품이 없습니다.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<footer class="footer">
    <p><b>FARM PEOPLE - 흙수저들</b></p>
    <p>© 2026 FARM PEOPLE. All Rights Reserved. | KH 정보교육원 프로젝트</p>
</footer>

</body>
</html>