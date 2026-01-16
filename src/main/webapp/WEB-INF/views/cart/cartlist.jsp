<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 장바구니</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap"
	rel="stylesheet">

<%-- 기존 CSS 파일 연결 유지 --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/cart.css">

<%-- 기존 JS 파일 연결 유지 --%>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</head>
<body>

	<header class="header-wrap">
		<a href="${pageContext.request.contextPath}/" class="logo">FARM
			PEOPLE</a>
	</header>

	<main class="container">
		<div class="cart-card">
			<h2>🛒 장바구니 목록</h2>

			<table class="cart-table">
				<thead>
					<tr>
						<th>상품명</th>
						<th>수량</th>
						<th>가격</th>
						<th>소계</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="totalPrice" value="0" />
					<c:set var="itemCount" value="0" />

					<c:choose>
						<c:when test="${not empty list}">
							<c:forEach var="cart" items="${list}">

								<c:set var="itemTotal" value="${cart.c_price * cart.c_count}" />
								<c:set var="totalPrice" value="${totalPrice + itemTotal}" />
								<c:set var="itemCount" value="${itemCount + 1}" />
								<tr>
									<td><a
										href="${pageContext.request.contextPath}/item/itemview?i_no=${cart.i_no}"
										class="prod-link"> ${cart.c_name} </a></td>


									<td>${cart.c_count}개</td>


									<td><fmt:formatNumber value="${cart.c_price}"
											pattern="#,###" />원</td>

									<%-- 소계 표시 --%>
									<td><fmt:formatNumber value="${itemTotal}" pattern="#,###" />원</td>

									<td>
										<form
											action="${pageContext.request.contextPath}/cart/cartdelete"
											method="post" onsubmit="return confirmDelete()">
											<input type="hidden" name="c_no" value="${cart.c_no}" />
											<button type="submit" class="btn-del">삭제</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</c:when>

						<c:otherwise>
							<tr>
								<td colspan="5" style="padding: 50px 0; color: #888;">장바구니가
									비어있습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>

					<tr class="total-row">
						<td colspan="3" style="text-align: right;"><strong>총
								합계</strong></td>
						<td colspan="2" class="total-price"><fmt:formatNumber
								value="${totalPrice}" pattern="#,###" />원</td>
					</tr>
				</tbody>
			</table>

			<div class="bottom-group">
				<a href="${pageContext.request.contextPath}/item/itemlist"
					class="btn-back">← 쇼핑 계속하기</a>

				<form
					action="${pageContext.request.contextPath}/order/orderwriteForm"
					method="post" onsubmit="return checkOrder(${itemCount})">
					<button type="submit" class="btn-order">주문하기</button>
				</form>
				<a href="/" class="btn-order">홈으로</a>
			</div>
		</div>
	</main>

	<footer>
		<p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
	</footer>

</body>
</html>