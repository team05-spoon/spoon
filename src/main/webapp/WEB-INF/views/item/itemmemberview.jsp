<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - ${view.i_name}</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script src="${pageContext.request.contextPath}/js/item.js"></script>
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE</a>
</header>

<main class="container">
    <div class="product-top-area">
        <div class="img-area">
            <img src="/timages/${view.i_timage}" alt="대표이미지" class="main-img">
        </div>

        <div class="info-area">
            <div class="item-meta-top">상품번호: ${view.i_no}</div>
            <h2 class="item-title">${view.i_name}</h2>
            <div class="item-price-large">
                <fmt:formatNumber value="${view.i_price}" pattern="#,###" /><span>원</span>
            </div>
            
            <div class="item-simple-info">
                <div class="info-row"><b>배송비</b> <span>무료배송 (도서산간 제외)</span></div>
                <div class="info-row"><b>판매자</b> <span>FARM PEOPLE 파트너</span></div>
                <div class="info-row"><b>옵션</b> <span>${view.i_option}</span></div>
            </div>

            <button type="button" class="btn-detail-view" onclick="toggleDetail()">상품 상세내용 보기 ↓</button>
        </div>
    </div>

    <div class="order-section">
        <div class="order-box-wide">
            <form action="/cart/cartadd" method="post" onsubmit="return addCartCheck()">
                <input type="hidden" name="i_no" value="${view.i_no}" />
                <input type="hidden" name="c_name" value="${view.i_name}" />
                <input type="hidden" name="c_price" value="${view.i_price}" />

                <div class="order-flex">
                    <div class="qty-select-part">
                        <label for="quantity" class="qty-label">수량 선택</label>
                        <select name="c_count" id="quantity" onchange="updateTotalPrice(${view.i_price})">
                            <c:forEach var="i" begin="1" end="10">
                                <option value="${i}">${i}개</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="total-price-part">
                        <span class="total-label">최종 결제 금액</span>
                        <span id="total-display" class="total-price-num">
                            <fmt:formatNumber value="${view.i_price}" pattern="#,###" />원
                        </span>
                    </div>

                    <div class="btn-group-wide">
                        <button type="submit" class="btn-cart-main">장바구니 담기</button>
                        <a href="${pageContext.request.contextPath}/cart/cartlist" class="btn-goto-cart-main">장바구니 이동</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="detail-section" class="detail-description-area" style="display: none;">
    <div class="detail-tab-menu">
        <div class="active">상품상세정보</div>
    </div>
    
    <div class="detail-content-wrapper">
        <div class="detail-text-box">
            ${view.i_ex}
        </div>
        <c:if test="${not empty view.i_dimage}">
            <img src="/dimages/${view.i_dimage}" alt="상세이미지" class="full-detail-img">
        </c:if>
    </div>
</div>
        
        <div class="bottom-navigation">
            <a href="javascript:history.back()" class="nav-link">← 이전 페이지</a>
            <span class="divider">|</span>
            <a href="${pageContext.request.contextPath}/item/itemlist" class="nav-link">목록으로 돌아가기</a>
        </div>
    </div>
</main>

<footer>
    <p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
</footer>

<script>
    // 상세 보기 클릭 시 스무스 스크롤
    function scrollToDetail() {
        document.getElementById('detail-content').scrollIntoView({ behavior: 'smooth' });
    }
</script>

</body>
</html>
