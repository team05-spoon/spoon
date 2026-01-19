<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 공지 작성</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">

<script src="${pageContext.request.contextPath}/js/notice.js"></script>
</head>

<body>

<header class="header-wrap">
  <a href="${pageContext.request.contextPath}/" class="logo">
    <img src="${pageContext.request.contextPath}/images/farm.png" alt="FARM PEOPLE">
  </a>
</header>

<main class="container">
  <div class="write-card">
    <div class="page-header">
      <h2>공지사항 작성</h2>
      <p>관리자 전용 페이지입니다. 정확한 공지 내용을 입력해 주세요.</p>
    </div>
    
    <form name="noticeForm" action="${pageContext.request.contextPath}/notice/noticewrite" method="post" onsubmit="return check()">
      <div class="form-group">
        <label>공지 제목</label>
        <input type="text" name="n_title" maxlength="100" class="form-control" placeholder="공지사항 제목을 입력하세요" required>
      </div>

      <div class="form-group">
        <label>공지 내용</label>
        <textarea name="n_nb" class="form-control" placeholder="공지할 상세 내용을 입력해 주세요." required></textarea>
      </div>

      <div class="button-group">
        <a href="${pageContext.request.contextPath}/notice/noticelist" class="btn btn-list">목록으로</a>
        <button type="submit" class="btn btn-submit">공지 등록하기</button>
      </div>
    </form>
  </div>
</main>

<footer>
  <p><b>FARM PEOPLE - 흙수저들</b></p>
  <p>© 2026 FARM PEOPLE. All Rights Reserved.</p>
</footer>

<script>
    // 페이지 로드 시 이탈 방지 로직 실행
    window.onload = function() {
        initWriteForm();
    };
</script>

</body>
</html>