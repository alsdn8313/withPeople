<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>	
	 	<title>게시판</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	</script>
	<body>
	
		<div id="root">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			<hr />
			
			<section id="container">
				<form name="writeForm" method="post" action="/board/write">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="i_no">상품번호 : &nbsp;</label><input type="text" id="i_no" name="i_no" class="chk" title="상품번호를 입력하세요."/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="item_nm">상품명 : &nbsp;&nbsp;&nbsp;&nbsp;</label><input id="item_nm" name="item_nm" class="chk" title="상품명을 입력하세요."></input>
								</td>
							</tr>
							<tr>
								<td>
									<label for="price_one">가격_1 : &nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" id="price_one" name="price_one" class="chk" title="가격_1을 입력하세요."/>
								</td>
							<tr>
							<tr>
								<td>
									<label for="price_two">가격_2 : &nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" id="price_two" name="price_two" class="chk" title="가격_2를 입력하세요."/>
								</td>
							<tr>
							<tr>
								<td>
									<label for="item_count">수량 : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" id="item_count" name="item_count" class="chk" title="수량 입력하세요."/>
								</td>
							<tr>
							<tr>
								<td>
									<label for="key_word">검색어 : &nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" id="key_word" name="key_word" class="chk" title="검색어를 입력하세요."/>
								</td>
							<tr>
								<td>						
									<button class="write_btn" type="submit">작성</button>
								</td>
							</tr>			
						</tbody>			
					</table>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>
