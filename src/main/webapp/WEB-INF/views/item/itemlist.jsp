<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 상품 목록</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
    <script src="${pageContext.request.contextPath}/js/item.js"></script>
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE</a>
</header>

<main class="container">
    <h2 class="page-title">🌿 신선한 농산물 목록</h2>

    <div class="item-grid">
        <c:forEach var="item" items="${list}">
			<div class="item-card">
				<div class="item-img-box">
					<img src="/timages/${item.i_timage}" alt="${item.i_name}" onerror="handleImageError(this)">
					</div>
						<div class="item-info">
							<a href="itemmemberview?i_no=${item.i_no}" class="item-name-link">
								<span class="item-name">${item.i_name}</span>
								<span>${item.i_ctg}</span>
							</a>
						<div class="item-price">
						<fmt:formatNumber value="${item.i_price}" pattern="#,###" /><span>원</span>
					</div>
				</div>
			</div>
        </c:forEach>
    </div>
</main>

<script>
    window.onload = function() {
        if (typeof initItemCard === 'function') {
            initItemCard();
        }
    };
</script>

</body>
</html>