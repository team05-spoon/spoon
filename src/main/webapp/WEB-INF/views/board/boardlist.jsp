<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="ko_KR"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 자유 게시판</title>
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
  <div class="board-header">
    <div class="board-title"><h2>자유 게시판</h2></div>
    <a href="${pageContext.request.contextPath}/board/boardwrite" class="btn-write">✍️ 글쓰기</a>
  </div>
  
  <table class="board-table">
    <thead>
      <tr>
        <th width="10%">번호</th>
        <th width="50%">제목</th>
        <th width="15%">작성자</th>
        <th width="25%">등록일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="row" items="${list}">
        <tr>
          <td>${row.b_no}</td>
          <td class="title-cell">
            <a href="${pageContext.request.contextPath}/board/boarddetail?b_no=${row.b_no}">${row.b_title}</a>
          </td>
          <td><b>${row.b_write}</b></td>
          <td style="color:#888;">
            <fmt:formatDate value="${row.b_date}" pattern="yyyy-MM-dd (E)"/>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <a href="/" class="btn-write">홈으로</a>
</main>

<footer>© 2026 FARM PEOPLE. All Rights Reserved.</footer>

<script>
    // 페이지 로드 후 board.js의 목록 클릭 초기화 함수 실행
    window.onload = function() {
        initBoardList();
    };
</script>

</body>
</html> 