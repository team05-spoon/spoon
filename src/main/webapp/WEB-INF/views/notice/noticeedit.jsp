<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 공지 수정</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">

<script src="${pageContext.request.contextPath}/js/notice.js"></script>
</head>
<body>

<div class="container">
  <h2 style="font-weight:900; margin-bottom:30px; text-align:center;">✏️ 공지사항 수정</h2>
  
  <form name="noticeEditForm" action="${pageContext.request.contextPath}/notice/noticeedit" method="post" onsubmit="return noticeEditCheck()">
    <input type="hidden" name="n_no" value="${dto.n_no}"/>
    
    <div class="form-group">
      <label>공지 제목</label>
      <input name="n_title" class="form-control" value="${dto.n_title}" required />
    </div>
    
    <div class="form-group">
      <label>공지 내용</label>
      <textarea name="n_nb" class="form-control" required>${dto.n_nb}</textarea>
    </div>
    
    <button type="submit" class="btn-submit">수정 완료하기</button>
  </form>
  
  <p class="cancel-text">
    <a href="${pageContext.request.contextPath}/notice/noticelist">취소하기</a>
  </p>
</div>

</body>
</html>