<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.spoon.dto.NoticeDTO" %>
<%@ page import="com.spoon.dto.memberDTO" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
    NoticeDTO dto = (NoticeDTO) request.getAttribute("dto");
    memberDTO loginMember = (memberDTO) session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FARM PEOPLE - 공지사항 상세</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">

<script src="${pageContext.request.contextPath}/js/notice.js"></script>
</head>
<body>

<div class="container">
  <div class="detail-header">
    <span style="color:#2f7d32; font-weight:bold;">[NOTICE]</span>
    <h2><%= dto.getN_title() %></h2>
    <div class="info">작성일: <%= sdf.format(dto.getN_date()) %></div>
  </div>
  
  <div class="content"><%= dto.getN_nb() %></div>
  
  <div class="btn-group">
    <a href="<%= request.getContextPath() %>/notice/noticelist" class="btn btn-list">목록으로</a>
    
    <%-- 관리자 권한 체크 --%>
    <% if(loginMember != null && "ADMIN".equals(loginMember.getM_temp())) { %>
      <a href="<%= request.getContextPath() %>/notice/noticeedit?n_no=<%= dto.getN_no() %>" class="btn btn-edit">수정</a>
      
      <%-- 외부 JS의 noticeDelCheck() 호출 --%>
      <form action="<%= request.getContextPath() %>/notice/noticedelete" method="post" 
            style="display:inline;" onsubmit="return noticeDelCheck()">
        <input type="hidden" name="n_no" value="<%= dto.getN_no() %>" />
        <button type="submit" class="btn btn-delete">삭제</button>
      </form>
    <% } %>
  </div>
</div>

</body>
</html>