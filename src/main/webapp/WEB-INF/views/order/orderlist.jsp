<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 주문 내역 - FARM PEOPLE</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
</head>
<body style="background-color: #f4f7f6;">

<div class="order-container">
    <div style="margin-bottom: 30px; text-align: center;">
        <a href="${pageContext.request.contextPath}/" style="font-size:28px; font-weight:900; color:#2f7d32; text-decoration:none;">
           FARM PEOPLE
        </a>
    </div>

    <div class="order-section">
        <h3 class="order-section-title">🛒 나의 주문 내역</h3>
        
        <table class="order-product-table">
            <thead>
                <tr>
                    <th>주문번호</th>
                    <th>수령인</th>
                    <th>배송 주소</th>
                    <th style="text-align:right;">총 결제금액</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalAllPrice" value="0" />
                <c:forEach var="order" items="${list}">
                    <c:set var="itemTotal" value="${order.c_price * order.c_count}" />
                    <c:set var="totalAllPrice" value="${totalAllPrice + itemTotal}" />
                    
                    <tr class="order-row" onclick="location.href='${pageContext.request.contextPath}/order/orderview?o_no=${order.o_no}'">
                        <td>
                            <a href="${pageContext.request.contextPath}/order/orderview?o_no=${order.o_no}" class="order-no-link" onclick="event.stopPropagation();">
                                ${order.o_no}
                            </a>
                        </td>
                        <td><strong>${order.d_name}</strong></td>
                        <td>${order.d_addr}</td>
                        <td style="text-align:right; font-weight: 700;">
                            <fmt:formatNumber value="${itemTotal}" pattern="#,###" />원
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" style="text-align:center; padding:80px 0; color:#999; background:#fff;">
                            주문 내역이 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="order-summary-box">
        <p>총 주문 누적액 <strong><fmt:formatNumber value="${totalAllPrice}" pattern="#,###" />원</strong></p>
    </div>

    <div class="order-footer-actions">
        <a href="${pageContext.request.contextPath}/" class="btn-back-to-cart">← 메인으로 돌아가기</a>
    </div>
</div>

</body>
</html>