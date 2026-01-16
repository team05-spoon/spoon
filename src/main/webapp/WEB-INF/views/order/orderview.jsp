<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 내역 - FARM PEOPLE</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
</head>
<body style="background-color: #f4f7f6;">

<div class="order-view-container">
    
    <div class="order-success-header">
        <div class="check-icon">✓</div>
        <h2 style="font-weight:900; color:#2f7d32; margin-top:0;">주문이 완료되었습니다!</h2>
        <p style="color:#666;">FARM PEOPLE을 이용해 주셔서 감사합니다.</p>
    </div>

    <div class="info-card">
        <h3>📍 배송 정보</h3>
        <table class="order-table">
            <tr>
                <th width="30%">주문자명</th>
                <td>${order.o_name}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>${order.o_tel}</td>
            </tr>
            <tr>
                <th>주문자 주소</th>
                <td>${order.o_addr}</td>
            </tr>
            <tr>
                <td colspan="2"><hr style="border:0; border-top:1px solid #eee; margin:10px 0;"></td>
            </tr>
            <tr>
                <th>수령인</th>
                <td>${order.d_name}</td>
            </tr>
            <tr>
                <th>배송지 연락처</th>
                <td>${order.d_tel}</td>
            </tr>
            <tr>
                <th>배송지 주소</th>
                <td>${order.d_addr}</td>
            </tr>
        </table>
    </div>

    <div class="info-card">
        <h3>📦 주문 상품 상세</h3>
        <table class="order-table" style="margin-bottom: 20px;">
            <thead>
                <tr style="border-bottom: 2px solid #f0f0f0;">
                    <th style="padding-bottom:10px;">상품명</th>
                    <th style="text-align:center; padding-bottom:10px;">수량</th>
                    <th style="text-align:right; padding-bottom:10px;">단가</th>
                    <th style="text-align:right; padding-bottom:10px;">소계</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="font-weight:700; padding:20px 0;">${item.i_name}</td>
                    <td style="text-align:center;">${order.c_count} 개</td>
                    <td style="text-align:right;"><fmt:formatNumber value="${order.c_price}" pattern="#,###" />원</td>
                    <td style="text-align:right; font-weight:700; color:#2f7d32;">
                        <fmt:formatNumber value="${order.c_price * order.c_count}" pattern="#,###" />원
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="total-payment">
            <span style="font-weight:700; font-size:18px;">최종 결제 금액</span>
            <span class="total-price"><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</span>
        </div>
    </div>

    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/order/orderlist" class="btn-outline">주문 목록 보기</a>
        <a href="${pageContext.request.contextPath}/" class="btn-primary" style="font-weight:700;">홈으로 가기</a>
    </div>

</div>

</body>
</html>