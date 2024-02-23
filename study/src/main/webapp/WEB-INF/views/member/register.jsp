<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<style type="text/css">
			@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
			* {font-family: "IBM Plex Sans KR", sans-serif; font-weight: 600;}
		</style>
		<title>회원가입</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				}
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if($("#userComn").val()==""){
					alert("회사명을 입력해주세요.");
					$("#userComn").focus();
					return false;
				}
				
				var idChkVal = $("#idChk").val();
				if(idChkVal == "N"){
					alert("중복확인 버튼을 눌러주세요.");
				}else if(idChkVal == "Y"){
					$("#regForm").submit();
				}
				
			});
		})
		
		function fn_idChk(){
			if($("#userId").val()!=""){
				$.ajax({
					url : "/member/idChk",
					type : "post",
					dataType : "json",
					data : {"userId" : $("#userId").val()},
					success : function(data){
						if(data == 1){
							alert("중복된 아이디입니다.");
						}else if(data == 0){
							$("#idChk").attr("value", "Y");
							alert("사용가능한 아이디입니다.");
						}
					}
				})
			}else{
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				return false;
			}
		}
	</script>
	<body>
		<nav class="navbar navbar-expand-md bg-white navbar-white container" style="height: 100px;">
			<a class="navbar-brand" href="${path}/"><img src="/resources/img/logo.png" width="50px;" height="50px;"/></a>
		</nav>
		<section id="container" class="container">
			<form action="/member/register" method="post" id="regForm">
				<div class="form-group">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="userId" name="userId" />
					<button class="idChk btn btn-primary" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
				</div>
				<div class="form-group">
					<label class="control-label" for="userPass">패스워드</label>
					<input class="form-control" type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="userName" name="userName" />
				</div>
				<div class="form-group">
					<label class="control-label" for="userComn">회사명</label>
					<input class="form-control" type="text" id="userName" name="userComn" />
				</div>
			</form>
				<div class="form-group">
					<button class="btn btn-success" type="button" id="submit">회원가입</button>
					<button class="cencle btn btn-danger" type="button">취소</button>
				</div>
		</section>
		
	</body>
	
</html>