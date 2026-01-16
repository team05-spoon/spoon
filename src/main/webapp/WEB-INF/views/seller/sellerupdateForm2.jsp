<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매자 승인 처리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/seller.css">
    <script src="${pageContext.request.contextPath}/js/seller.js"></script>
</head>
<body>

<div class="info-container">
    <h3>🚜 판매자 신청 승인</h3>
    
    <form name="approveFrm" method="post" action="/seller/sellerupdate" onsubmit="return confirmApprove()">
        <input type="hidden" name="s_no" value="${update.s_no}">
        
        <table class="info-table">
            <tr>
                <th>대표명</th>
                <td>
                    ${update.s_name}
                    <input type="hidden" name="s_name" value="${update.s_name}">
                </td>
            </tr>
            <tr>
                <th>사업장명</th>
                <td>
                    ${update.s_bn}
                    <input type="hidden" name="s_bn" value="${update.s_bn}">
                </td>
            </tr>
            <tr>
                <th>사업자번호</th>
                <td>
                    ${update.s_num}
                    <input type="hidden" name="s_num" value="${update.s_num}">
                </td>
            </tr>
            <tr>
                <th>권한 설정</th>
                <td>
                    <select name="s_temp" class="input-field" style="width: 100%;">
                        <option value="USER" ${update.s_temp == 'USER' ? 'selected' : ''}>일반 유저(USER)</option>
                        <option value="SELLER" ${update.s_temp == 'SELLER' ? 'selected' : ''}>판매자(SELLER)</option>
                    </select>
                </td>
            </tr>
        </table>

        <div class="action-group">
            <button type="submit" class="btn-edit">승인 완료</button>
            <button type="button" class="btn-revoke" onclick="location.href='/seller/sellerlist'">취소하기</button>
        </div>
    </form>
</div>

</body>
</html>