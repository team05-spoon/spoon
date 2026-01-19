<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.spoon.dto.memberDTO" %>
<%
    memberDTO loginMember = (memberDTO) session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 공지사항</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">

<script src="${pageContext.request.contextPath}/js/notice.js"></script>
</head>
<body>

<header class="header-wrap">
  <a href="${pageContext.request.contextPath}/" class="logo">
    <img src="${pageContext.request.contextPath}/images/farm.png" alt="LOGO">
  </a>
</header>

<main class="container">
  <div class="notice-header">
    <h2>📢 공지사항</h2>
    <% if(loginMember != null && "ADMIN".equals(loginMember.getM_temp())) { %>
      <a href="${pageContext.request.contextPath}/notice/noticewriteForm" class="btn-admin">✍️ 공지 등록</a>
    <% } %>
  </div>

  <table class="notice-table">
    <thead>
      <tr>
        <th width="10%">번호</th>
        <th width="65%">제목</th>
        <th width="25%">등록일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="row" items="${list}">
        <tr>
          <td>${row.n_no}</td>
          <td class="title-cell">
            <span class="notice-badge">공지</span>
            <a href="${pageContext.request.contextPath}/notice/noticedetail?n_no=${row.n_no}">${row.n_title}</a>
          </td>
          <td style="color:#888;">
            <fmt:formatDate value="${row.n_date}" pattern="yyyy-MM-dd"/>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</main>

<footer>© 2026 FARM PEOPLE. All Rights Reserved.</footer>

<script>
    // 페이지 로드 시 목록 이벤트 연결
    window.onload = function() {
        initNoticeList();
    };
</script>

</body>
</html>