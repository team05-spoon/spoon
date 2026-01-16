<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 판매자 회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/seller.css">
    <script src="${pageContext.request.contextPath}/js/seller.js"></script>
</head>
<body>

<div class="info-container">
    <h2>🚜 판매자 회원가입</h2>
    <p style="color: #666; margin-bottom: 30px;">FARM PEOPLE의 파트너가 되어 신선한 농산물을 판매해보세요!</p>

    <form name="sellerwriteForm" method="post" action="/seller/sellerwrite" onsubmit="return validateWriteForm()">
        <input type="hidden" name="m_no" value="${member.m_no}">
        
        <div class="write-group">
            <label>대표자명</label>
            <input type="text" name="s_name" class="input-field" placeholder="성함을 입력하세요">
        </div>

        <div class="write-group">
            <label>사업장명 (상호명)</label>
            <input type="text" name="s_bn" class="input-field" placeholder="가게 또는 회사 이름을 입력하세요">
        </div>

        <div class="write-group">
            <label>사업자 등록번호</label>
            <input type="text" name="s_num" class="input-field" placeholder="000-00-00000">
        </div>

        <div class="action-group" style="margin-top: 30px;">
            <button type="submit" class="btn-edit">신청하기</button>
        </div>
        
        <div class="footer-link">
            <button type="reset" style="background:none; border:none; color:#999; cursor:pointer;">다시 작성</button>
            <a href="javascript:history.back();">이전으로 돌아가기</a>
        </div>
    </form>
</div>

</body>
</html>