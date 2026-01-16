<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 판매자 상품관리</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script src="${pageContext.request.contextPath}/js/item.js"></script>
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE <small style="color:#2f7d32; font-size:14px; margin-left:10px;">판매자 센터</small></a>
</header>

<main class="container">
    <div class="view-container">
        <div class="img-area">
            <div class="seller-badge">대표 이미지</div>
            <img src="/timages/${view.i_timage}" alt="대표이미지">
            
            <div class="seller-badge" style="margin-top:20px;">상세 페이지 이미지</div>
            <img src="/dimages/${view.i_dimage}" alt="상세이미지" class="detail-img">
        </div>

        <div class="info-area">
            <h2 class="item-title">${view.i_name}</h2>
            <div class="item-price-large">
                <fmt:formatNumber value="${view.i_price}" pattern="#,###" />원
            </div>

            <div class="item-meta">
                <div><b>상품번호</b> ${view.i_no}</div>
                <div><b>현재옵션</b> ${view.i_option}</div>
            </div>

            <div class="item-ex">
                <h4 style="margin:0 0 10px 0; color:#333;">상품 정보 요약</h4>
                <p style="margin:0; line-height:1.6;">${view.i_ex}</p>
            </div>

            <div class="seller-btn-group">
                <a href="${pageContext.request.contextPath}/item/itemupdateForm?i_no=${view.i_no}" class="btn-seller-edit">상품 정보 수정</a>
                <a href="javascript:sellerDeleteCheck('${view.i_no}')" class="btn-seller-del">삭제</a>
            </div>
            
            <div style="margin-top:20px; text-align:center;">
                <a href="${pageContext.request.contextPath}/item/myitemlist" style="color:#888; font-size:14px;">내 상점 상품목록으로 돌아가기</a>
            </div>
        </div>
    </div>
</main>

<footer>
    <p><b>FARM PEOPLE - 판매자 전용 페이지</b></p>
    <p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
</footer>

</body>
</html>