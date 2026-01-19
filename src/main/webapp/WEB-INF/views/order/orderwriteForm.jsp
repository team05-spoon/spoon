<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 주문서 작성</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
    <script src="${pageContext.request.contextPath}/js/order.js"></script>
</head>
<body style="background-color: #f4f7f6;">

<div class="order-container">
    <form action="${pageContext.request.contextPath}/order/orderwrite" method="post" onsubmit="return validateOrderForm()">
        
        <div class="order-section">
            <h3 class="order-section-title">👤 주문자 정보</h3>
            <div class="order-form-grid">
                <div class="order-input-group">
                    <label for="o_name">이름</label>
                    <input type="text" id="o_name" name="o_name" value="${member.m_name}" required>
                </div>
                <div class="order-input-group">
                    <label for="o_tel">전화번호</label>
                    <input type="text" id="o_tel" name="o_tel" value="${member.m_tel}">
                </div>
            </div>
            <div class="order-input-group" style="margin-bottom:30px;">
                <label for="o_addr">주소</label>
                <input type="text" id="o_addr" name="o_addr" value="${member.m_addr}">
            </div>
        </div>

        <div class="order-section">
            <h3 class="order-section-title">
                🚚 배송지 정보
                <label style="font-size:13px; color:#666; font-weight:400; cursor:pointer;">
                    <input type="checkbox" id="sameAsCustomer" onclick="copyCustomerInfo()"> 주문자 정보와 동일
                </label>
            </h3>
            <div class="order-form-grid">
                <div class="order-input-group">
                    <label for="d_name">받는 분 이름</label>
                    <input type="text" id="d_name" name="d_name">
                </div>
                <div class="order-input-group">
                    <label for="d_tel">연락처</label>
                    <input type="text" id="d_tel" name="d_tel">
                </div>
            </div>
			 <div class="order-input-group">
			    <label for="d_addr">배송 주소</label>
			    <div style="display: flex; gap: 5px; margin-bottom: 5px;">
			        <input type="text" id="zipNo" name="zipNo" placeholder="우편번호" readonly 
			               style="width: 80px; background-color: #f9f9f9;">
			        
			        <button type="button" onclick="goPopup()" 
			                style="padding: 0 15px; background-color: #fff; border: 1px solid #ccc; cursor: pointer; font-size: 13px; font-weight: bold;">
			            주소 검색
			        </button>
			    </div>
    <input type="text" id="d_addr" name="d_addr" placeholder="주소 검색 버튼을 눌러주세요" readonly 
           style="width: 100%; background-color: #f9f9f9;">
</div>
        </div>

        <div class="order-section" style="margin-top:40px;">
            <h3 class="order-section-title">🛒 주문 상품</h3>
            <table class="order-product-table">
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th style="text-align:center;">수량</th>
                        <th style="text-align:right;">가격</th>
                    </tr>
                </thead>
                <tbody>
<c:forEach var="item" items="${cartList}">
    <tr>
        <td>${item.c_name}</td>
        <%-- 수량 자리에 가격 변수(c_price)를 넣고, 가격 자리에 수량 변수(c_count)를 넣음 --%>
        <td style="text-align:center;">${item.c_count}개</td>
        <td style="text-align:right;">
            <fmt:formatNumber value="${item.c_price}" pattern="#,###" />원
        </td>
        
        <%-- DB 전송용 hidden 값들도 반대로 매핑되어 있다면 수정 필요 --%>
        <input type="hidden" name="i_no" value="${item.i_no}" />
        <input type="hidden" name="c_count" value="${item.c_count}" /> <%-- 수량 데이터 --%>
        <input type="hidden" name="c_price" value="${item.c_price}" /> <%-- 가격 데이터 --%>
    </tr>
</c:forEach>
                </tbody>
            </table>
        </div>

        <div class="order-summary-box">
            <p>최종 결제 금액 <strong><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</strong></p>
        </div>

        <button type="submit" class="btn-pay-now">결제하기</button>
    </form>
    <div class="order-footer-actions">
        <a href="${pageContext.request.contextPath}/cart/cartlist" class="btn-back-to-cart">
            ← 장바구니로 돌아가기
        </a>
    </div>
</div>
</body>
</html>