<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 글쓰기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">

<script src="${pageContext.request.contextPath}/js/board.js"></script>
</head>
<body>

<header class="header-wrap">
  <a href="${pageContext.request.contextPath}/" class="logo">
    <img src="${pageContext.request.contextPath}/images/farm.png" alt="LOGO">
  </a>
</header>

<main class="container">
  <div class="write-card">
    <h2 style="color:#2f7d32; font-weight:900;">새 글 작성</h2>
    
    <form name="boardForm" action="${pageContext.request.contextPath}/board/boardwriteForm" method="post" onsubmit="return boardCheck()">
      <div class="form-group">
        <label>제목</label>
        <input name="b_title" class="form-control" placeholder="제목을 입력하세요" maxlength="100" required />
      </div>
      <div class="form-group">
        <label>내용</label>
        <textarea name="b_memo" class="form-control" placeholder="내용을 입력하세요" required></textarea>
      </div>
      <button type="submit" class="btn-submit">등록하기</button>
    </form>
    
    <a href="${pageContext.request.contextPath}/board/boardlist" class="back-link">목록으로 돌아가기</a>
  </div>
</main>

</body>
</html>