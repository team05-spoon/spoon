<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정식 판매자 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/seller.css">
    <script src="${pageContext.request.contextPath}/js/seller.js"></script>
</head>
<body>

<div class="list-container">
    <h2>✅ 정식 판매자 관리 목록</h2>
    
    <table class="seller-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>판매 상호명</th>
                <th>대표명</th>
                <th>사업자번호</th>
                <th>권한</th>
                <th>권한 회수</th>

            </tr>
        </thead>
        <tbody>
            <c:forEach var="seller" items="${list}">
                <%-- 판매자 권한(SELLER)인 데이터만 노출 --%>
                <c:if test="${seller.s_temp == 'SELLER'}">
                    <tr>
                        <td>${seller.s_no}</td>
                        <td>${seller.s_bn}</td>
                        <td>${seller.s_name}</td>
                        <td>${seller.s_num}</td>
                        <td><span class="badge-seller">SELLER</span></td>
                        <td>
                            <a href="/seller/sellerupdateForm2?s_no=${seller.s_no}" 
                               name="revokeLink"
                               onclick="return checkRevoke(this)">회수하기</a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            
            <%-- 데이터가 없을 경우 처리 --%>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" style="text-align:center; padding:50px; color:#999;">
                        현재 등록된 정식 판매자가 없습니다.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="footer-actions">
        <a href="/" class="btn-home">← 메인으로 돌아가기</a>
    </div>
</div>

</body>
</html>