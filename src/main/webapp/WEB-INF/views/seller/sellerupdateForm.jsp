<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매자 정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/seller.css">
    <script src="${pageContext.request.contextPath}/js/seller.js"></script>
</head>
<body>

<div class="info-container">
    <h3>🛠️ 판매자 정보 수정</h3>
    
    <form name="seller" method="post" action="/seller/sellerupdate" onsubmit="return validateSellerForm()">
        <input type="hidden" name="s_no" value="${update.s_no}">
        
        <table class="info-table">
            <tr>
                <th>대표명</th>
                <td><input type="text" name="s_name" value="${update.s_name}" class="input-field"></td>
            </tr>
            <tr>
                <th>사업장명</th>
                <td><input type="text" name="s_bn" value="${update.s_bn}" class="input-field"></td>
            </tr>
            <tr>
                <th>사업자번호</th>
                <td>
                    <%-- 오타 수정: s_bn -> s_num --%>
                    <input type="text" name="s_num" value="${update.s_num}" class="input-field">
                </td>
            </tr>
            <tr>
                <th>유저 권한</th>
                <td>
                    <input type="hidden" name="s_temp" value="${update.s_temp}">
                    <span class="badge-seller">${update.s_temp}</span>
                </td>
            </tr>
        </table>

        <div class="action-group">
            <button type="submit" class="btn-edit">수정 완료</button>
            <button type="button" class="btn-revoke" onclick="history.back()">취소하기</button>
        </div>
    </form>
</div>

</body>
</html>