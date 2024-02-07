<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script><!-- 항상 최신버전의 JQuery를 사용가능하다. -->
		<title>게시판</title>
		<style type="text/css">
			 li {list-style: none;  padding: 6px; float: left;}
			 input {border: none;}
			 
			 .col-md-offset-3 {margin-left: 650px;}
			
		</style>
	</head>
	<script type="text/javascript">
		
		$(document).ready(function(){
			
			$("#excelDown").on("click", function(){
				
				var regForm = $("form[name='frm'] .chk").length;
				
				if(regForm == 0){
					alert("조회된 데이터가 없습니다.");	
					return;
				}else{
					window.location = "/board/excelDown";
				}
				
			});
			
		});
	 	
	</script>
	
	<body>
		
	
		<div>
			<header>
				<h1>게시판</h1>
			</header>
			<br/>
			<div>
			<button type="button" id="excelDown" class="btn btn-default">엑셀다운로드</button>
			</div>
			<br/>
			<section>
				<form role="form" method="get" name="frm">
					<table class="table table-hover">
						<tr><th>번호</th><th>제품명</th><!--<th>제조사</th><th>브랜드</th>--><th>기존가격</th><th>판매처</th><th>최저가격</th></tr>
						<c:forEach items="${list}" var="list">
						<tr>
							<td><input name="s_num" 		value="${list.s_num}"  		style="width: 40px;" readonly="readonly" class='chk'/></td>
							<td><input name="s_item" 		value="${list.s_item}"  	style="width: 500px;" readonly="readonly"/></td>
							<%-- <td><input name="s_maker" 		value="${list.s_maker}"  	style="width: 100px;" readonly="readonly"/></td>
							<td><input name="s_brand" 		value="${list.s_brand}"  	style="width: 100px;" readonly="readonly"/></td> --%>
							<td><input name="s_brand" 		value="${list.s_price}"  	style="width: 100px;" readonly="readonly"/></td>
							<td><input name="s_mall_nm" 	value="${list.s_mall_nm}"  	style="width: 200px;" readonly="readonly"/></td>
							<td><input name="s_lprice" 		value="${list.s_lprice}" 	style="width: 100px;" readonly="readonly"/></td>
						</tr>
						</c:forEach>
				</table>
				
				<div class="search row">
					<div class="col-xs-2 col-sm-2">
					    <select name="searchType" class="form-control">
					      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>상품명</option>
					    </select>
					</div>
					
					<div class="col-xs-10 col-sm-10">
						<div class="input-group">
					    	<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
					    	<span class="input-group-btn">
					    		<button id="searchBtn" type="button" class="btn btn-default">검색</button>
					    	</span>
					    </div>

					</div>
					
				    <script>
				      $(function(){
				        $('#searchBtn').click(function() {
				          self.location = "listExcel" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
				        });
				      });   
				    </script>
			  </div>
				
				<div class="col-md-offset-3">
				  <ul class="pagination">
				    <c:if test="${pageMaker.prev}">
				    	<li><a href="listExcel${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
				    </c:if> 
				
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				    	<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : '' }"/>>
				    	<a href="listExcel${pageMaker.makeSearch(idx)}">${idx}</a></li>
				    </c:forEach>
				
				    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    	<li><a href="listExcel${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
				    </c:if> 
				  </ul>
				</div>
				</form>
			</section>
		</div>
	</body>
	
	
</html>
