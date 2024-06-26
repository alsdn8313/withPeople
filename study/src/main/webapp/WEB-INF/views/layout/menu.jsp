<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style type="text/css">
		@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
		* {font-family: "IBM Plex Sans KR", sans-serif;}
</style>
<nav class="navbar navbar-expand-md bg-white navbar-white container" style="height: 100px;">
	<a class="navbar-brand" href="${path}/"><img src="/resources/img/logo.png" width="50px;" height="50px;"/></a>
	<%-- <a class="navbar-brand" href="${path}/"><img src="/resources/img/logo.png" width="50px;" height="50px;"/>the lowest price comparison system</a> --%>
	<ul class="navbar-nav">
		<%-- <c:choose>
		    <c:when test="${member.userId == null}">
		        <li class="nav-item"><a class="nav-link text-dark" href="${path}">로그인</a></li>
		    </c:when>
		    <c:otherwise>
		        <a class="navbar-brand">${member.userName}님이 로그인중입니다.</a>
		        <li class="nav-item"><a class="nav-link text-dark" href="${path}/member/logout">로그아웃</a></li>
		    </c:otherwise>
		</c:choose> --%>
		<c:if test="${member.userId != null}">
			<li class="nav-item"><a class="nav-link text-dark" href="${path}/member/logout">로그아웃</a></li>
		</c:if>
		<c:choose>
		    <c:when test="${member.userId == null}">
		        <li class="nav-item"><a class="nav-link text-dark" id="registerBtn" type="button">회원가입</a></li>
		    </c:when>
		    <c:otherwise>
		        <%-- <a class="navbar-brand">${member.userName}님이 로그인중입니다.</a> --%>
		        <li class="nav-item"><a class="nav-link text-dark" href="${path}/member/memberUpdateView">회원정보수정</a></li>
		    </c:otherwise>
		</c:choose>
	</ul>
</nav>    
