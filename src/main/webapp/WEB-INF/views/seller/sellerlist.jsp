<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매자 승인 관리</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/seller.css">
    <script src="${pageContext.request.contextPath}/js/seller.js"></script>
</head>
<body>

    <div class="list-container">
        <h2>🚜 판매자 가입 승인 대기 목록</h2>

        <table>
            <thead>
                <tr>
                    <th>판매자 번호</th>
                    <th>판매 상호명</th>
                    <th>대표명</th>
                    <th>사업자번호</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="seller" items="${list}">
                    <%-- 승인 대기 중인(USER 권한) 판매자만 출력 --%>
                    <c:if test="${seller.s_temp == 'USER'}">
                        <tr>
                            <td>${seller.s_no}</td>
                            <td>${seller.s_bn}</td>
                            <td>${seller.s_name}</td>
                            <td>${seller.s_num}</td>
                            <td>
                                <%-- 승인은 바로 진행 --%>
                                <a href="/seller/sellerupdateForm2?s_no=${seller.s_no}" 
                                   class="btn-action btn-approve">승인</a>
                                   
                                <%-- 반려만 확인창 띄움 --%>
                                <a href="/seller/sellerdelete?s_no=${seller.s_no}" 
                                   class="btn-action btn-reject" 
                                   onclick="return confirmDelete()">반려</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                
                <%-- 목록이 없을 때 처리 --%>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5" style="text-align:center; padding: 40px; color:#999;">
                            승인 대기 중인 판매자가 없습니다.
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