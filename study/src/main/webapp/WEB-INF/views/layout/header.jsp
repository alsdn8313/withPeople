<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<title>로그인페이지</title>
<script>
    $(document).ready(function(){
        $("#btnLogin").click(function(){
            // 태크.val() : 태그에 입력된 값
            // 태크.val("값") : 태그의 값을 변경 
            var userId = $("#userId").val();
            var userPw = $("#userPass").val();
            if(userId == ""){
                alert("아이디를 입력하세요.");
                $("#userId").focus(); // 입력포커스 이동
                return; // 함수 종료
            }
            if(userPw == ""){
                alert("아이디를 입력하세요.");
                $("#userPass").focus();
                return;
            }
            // 폼 내부의 데이터를 전송할 주소
            document.form1.action="${path}/member/login"
            // 제출
            document.form1.submit();
        });
        
        $("#registerBtn").on("click", function(){
			location.href="member/register";
		});
        $("#memberUpdateBtn").on("click", function(){
			location.href="member/memberUpdateView";
		});
    });
</script>
</head>
<body>
<%@ include file="menu.jsp" %>
<h2></h2>
	<div class="container" style="padding-left: 0px; padding-right: 0px;">
	    <form name="form1" method="post">
	            <c:choose>
	            <c:when test="${member.userId == null}">
		            <div class="form-group">
		                <label>아이디</label><input name="userId" id="userId" class="form-control">
		            </div>
		            <div class="form-group">
		                <label for="userPass">비밀번호</label>
		                <input type="password" name="userPass" id="userPass" class="form-control">
		            </div>
	                    <button type="button" id="btnLogin" class="btn btn-primary">로그인</button>
	                    <!-- <button id="registerBtn" type="button" class="btn btn-primary">회원가입</button> -->
		                <c:if test="${msg == false}">
	                    <div style="color: red">
	                        아이디 또는 비밀번호가 일치하지 않습니다.
                   		</div>
	    	            </c:if>
    	        </c:when>
    	        <c:otherwise>
		        <c:if test="${member.userId != null }">
				    <div class="jumbotron text-center container" >
			    	<h2 class="navbar-brand" >${member.userName}(${member.userId})님 환영합니다.</h2>
			   		</div>
			    </c:if>
		    	</c:otherwise>
    	        </c:choose>
	    </form>
    </div>
</body>
</html>