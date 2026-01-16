<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="ko_KR"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 상세 보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">

<script src="${pageContext.request.contextPath}/js/board.js"></script>
</head>
<body>

<div class="container">
  <div class="detail-header">
    <h2>${dto.b_title}</h2>
    <div class="info">
      <span><b>작성자:</b> ${dto.b_write}</span>
      <span><b>날짜:</b> <fmt:formatDate value="${dto.b_date}" pattern="yyyy-MM-dd (E)"/></span>
    </div>
  </div>
  
  <div class="content">${dto.b_memo}</div>
  
  <div class="btn-group">
    <a href="${pageContext.request.contextPath}/board/boardlist" class="btn btn-list">목록</a>
    <a href="${pageContext.request.contextPath}/board/boardedit?b_no=${dto.b_no}" class="btn btn-edit">수정</a>
    
    <form name="delForm" action="${pageContext.request.contextPath}/board/boarddelete" method="post" onsubmit="return delCheck()">
      <input type="hidden" name="b_no" value="${dto.b_no}">
      <button type="submit" class="btn btn-delete">삭제</button>
    </form>
  </div>
</div>

</body>
</html>