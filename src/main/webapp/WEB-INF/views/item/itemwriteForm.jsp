<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FARM PEOPLE - 상품 등록</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
    <script src="${pageContext.request.contextPath}/js/item.js"></script>
</head>
<body>

<header class="header-wrap">
    <a href="${pageContext.request.contextPath}/" class="logo">FARM PEOPLE <small>판매자 센터</small></a>
</header>

<main class="container">
    <div class="write-container">
        <div class="form-header">
            <h2>🌿 신규 상품 등록</h2>
            <p>신선한 농산물을 등록하여 고객들에게 소개해 보세요.</p>
        </div>

        <form name="itemWriteForm" action="/item/itemwrite" method="post" enctype="multipart/form-data" onsubmit="return validateItemForm()">
            <input type="hidden" name="s_no" value="${seller.s_no}">

            <div class="input-row">
                <label for="i_name">상품명</label>
                <input type="text" id="i_name" name="i_name" class="form-control" placeholder="상품 이름을 입력하세요">
            </div>

            <div class="input-row">
                <label for="i_price">상품 가격 (원)</label>
                <input type="text" id="i_price" name="i_price" class="form-control" placeholder="예: 15000">
            </div>

            <div class="input-row">
                <label>메인 이미지 (썸네일)</label>
                <div class="file-input-group">
                    <input type="file" name="i_tfile">
                </div>
            </div>

            <div class="input-row">
                <label>상세 페이지 이미지</label>
                <div class="file-input-group">
                    <input type="file" name="i_dfile">
                </div>
            </div>

            <div class="input-row">
                <label for="i_option">옵션 정보</label>
                <input type="text" id="i_option" name="i_option" class="form-control" placeholder="예: 5kg 1박스 / 10kg 1박스">
            </div>
			
			 <div class="input-row">
                <label for="i_option">카테고리</label>
                <select name="i_ctg">
                	<option value=" ">선택</option>
                	<option value="fruit">과일</option>
                	<option value="meat">육류</option>
                	<option value="seafood">수산물</option>
                	<option value="vegetable">야채</option>
                </select>
            </div>
			
			
            <div class="input-row">
                <label for="i_ex">상세 설명</label>
                <textarea id="i_ex" name="i_ex" class="form-control" rows="8" style="resize: none;" placeholder="상품에 대한 자세한 설명을 적어주세요"></textarea>
            </div>

            <div class="btn-submit-group">
                <button type="submit" class="btn-save">상품 등록하기</button>
                <button type="reset" class="btn-reset" onclick="return confirm('입력한 내용을 모두 지우시겠습니까?')">초기화</button>
            </div>
            
            <div style="text-align: center; margin-top: 20px;">
                <a href="javascript:history.back()" style="color: #999; text-decoration: none; font-size: 14px;">뒤로 가기</a>
            </div>
        </form>
    </div>
</main>

<footer>
    <p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
</footer>

</body>
</html>