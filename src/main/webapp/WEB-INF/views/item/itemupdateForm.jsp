<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 상품 수정</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script src="${pageContext.request.contextPath}/js/item.js"></script>
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE <small>판매자 센터</small></a>
</header>

<main class="container">
    <div class="update-card">
        <h2 class="form-title">✏️ 상품 정보 수정</h2>
        
        <form name="itemUpdateForm" action="/item/itemupdate" method="post" enctype="multipart/form-data" onsubmit="return itemUpdateCheck()">
            <input type="hidden" name="i_no" value="${update.i_no}">

            <div class="item-form-group">
                <label>상품명</label>
                <div class="read-only-text">${update.i_name}</div>
            </div>

            <div class="item-form-group">
                <label>가격 (원)</label>
                <input type="text" name="i_price" class="form-control" value="${update.i_price}" required>
            </div>

            <div class="item-form-group">
                <label>대표 이미지</label>
                <input type="text" name="i_timage" class="form-control" value="${update.i_timage}" readonly style="background:#f9f9f9; color:#999; font-size:13px;">
                <input type="file" name="i_tfile" class="form-control" style="margin-top:5px;">
                <p class="file-info">* 새로운 파일을 선택하면 기존 이미지가 교체됩니다.</p>
            </div>

            <div class="item-form-group">
                <label>상세 이미지</label>
                <input type="text" name="i_dimage" class="form-control" value="${update.i_dimage}" readonly style="background:#f9f9f9; color:#999; font-size:13px;">
                <input type="file" name="i_dfile" class="form-control" style="margin-top:5px;">
                <p class="file-info">* 상세 페이지에 들어갈 이미지를 선택해 주세요.</p>
            </div>

            <div class="item-form-group">
                <label>옵션 정보</label>
                <input type="text" name="i_option" class="form-control" value="${update.i_option}">
            </div>
            
            <div class="item-form-group">
                <label>카테고리</label>
                <select name="i_ctg" class="form-control" value="${update.i_ctg}">
                <option value=" ">선택</option>
                	<option value="fruit">과일</option>
                	<option value="meat">육류</option>
                	<option value="seafood">수산물</option>
                	<option value="vegetable">야채</option>
                </select>
            </div>

            <div class="item-form-group">
                <label>상품 상세 설명</label>
                <textarea name="i_ex" class="form-control" style="height:150px; resize:none;">${update.i_ex}</textarea>
            </div>

            <div style="margin-top:40px;">
                <button type="submit" class="btn-update-submit">수정 완료하기</button>
                <button type="button" class="btn-cancel" onclick="history.back()">취소하고 돌아가기</button>
            </div>
        </form>
    </div>
</main>

<footer>
    <p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
</footer>

</body>
</html>