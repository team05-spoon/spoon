<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 글 수정</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">
<script src="${pageContext.request.contextPath}/js/board.js"></script>
</head>
<body>

<main class="container">
  <h2 style="color:#2f7d32; font-weight:900;">게시글 수정</h2>
  
  <form name="editForm" action="${pageContext.request.contextPath}/board/edit" method="post" onsubmit="return editCheck()">
    <input type="hidden" name="b_no" value="${dto.b_no}"/>
    
    <div class="form-group">
      <label>제목</label>
      <input name="b_title" class="form-control" value="${dto.b_title}" maxlength="100" required />
    </div>
    
    <div class="form-group">
      <label>작성자</label>
      <p class="writer-box">${dto.b_write}</p>
    </div>
    
    <div class="form-group">
      <label>내용</label>
      <textarea name="b_memo" class="form-control" required>${dto.b_memo}</textarea>
    </div>
    
    <button type="submit" class="btn-submit">수정 완료</button>
  </form>
  
  <a href="${pageContext.request.contextPath}/board/boarddetail?b_no=${dto.b_no}" class="cancel-link">취소하고 돌아가기</a>
</main>

</body>
</html>