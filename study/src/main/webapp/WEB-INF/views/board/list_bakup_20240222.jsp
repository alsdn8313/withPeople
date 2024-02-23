<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		
		<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->	
		<script src="http://code.jquery.com/jquery-latest.min.js"></script> <!-- 항상 최신버전의 JQuery를 사용가능하다. -->
		<title>게시판</title>
		<style type="text/css">
		@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
			 input {border: none;}
			 
			#Progress_Loading
			{
			 position: absolute;
			 left: 45%;
			 top: 40%;
			 background: #ffffff;
			}
			
			* {font-family: "IBM Plex Sans KR", sans-serif;}
			
			th {text-align : center;}
			td {text-align : center;}
		</style>
	</head>
	<script type="text/javascript">
		
		$(document).ready(function(){
			$('#Progress_Loading').hide();
		    var userId = "${member.userId}";
		    
			$("#btn").on("click", function(){
				//$("#display_1 td").empty();
				location.reload(true);
				if(document.getElementsByName("s_word").length > 0){
					
					var maskHeight = $(document).height();
				    var maskWidth  = window.document.body.clientWidth;         //화면에 출력할 마스크를 설정해줍니다.    
				    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
					
				  	//화면에 레이어 추가
				    $('body').append(mask)
					
				    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.    
				    $('#mask').css({            
				    	'width' : maskWidth,            
				    	'height': maskHeight,            
				    	'opacity' : '0.3'    
				    });       

				    $('#Progress_Loading').show();
				    //마스크 표시    
				    $('#mask').show();
				    deleteItem(userId);
					
					setTimeout(function () {
						
						$(".i_tr").empty();
						
						var key_word = document.getElementsByName("s_word");
						var s_price = document.getElementsByName("s_price");
						
				 		for(var i = 0; i < key_word.length; i++){
				 		//for(var i = 0; i < 20; i++){
				 			var data = "input=" + key_word[i].value;
				 			var price = s_price[i].value;
				 			//var data = "input=FANUC A06B-6081-H101";
				 			//getItem(data);
				 			
				 			
				 			$.ajax({
					 	        
				                url:"/board/search",
				                type:"get",
				                dataType: 'json',
				                async: false,
					 			data: data,
				                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				                //contentType: false,
				                processData: false,
				            	
				                success: function(data) {
				                    //resultHtml(data);
				                    for(var j = 0; j < data.items.length; j++){
					                	var items = data.items;
				                    	
					                	if(items[j].productType == "4" || items[j].productType == "5" || items[j].productType == "6"){
				                    	
						                    var productType = items[j].productType; 
						                    var v_title = items[j].title;
						                    var title = v_title.replace(/b|\/|<|>/g,"");
						                    var lprice = items[j].lprice;
						                    lprice = lprice.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',');
						                    var maker = items[j].maker;
						                    var brand = items[j].brand;
						                    var mall_nm = items[j].mallName;
											
						                    /* var html = "<tr align='center' style='border: 1px; border-color:black;' class='i_tr'>";
						         			html += "<td name='s_num' id='s_num' class='chk' style='width: 50; text-align: left;'>" + Number(i+1) + "</td>";
						         			html += "<td name='s_title' id='s_title' style='width: 800; text-align: left;'>" + title + "</td>";
						         			html += "<td name='s_lprice' id='s_lprice' style='width: 100; text-align: right;'>" + lprice + "</td>";
						         			html += "</tr>"; */
						        	 	
						        	 		//html += "</table>";
						        	 		
						        	 		//$("#display_1").append(html);
						        	 		insertItem(i,title,lprice,maker,brand,price,mall_nm,userId);
						        	 		return;
				                    	}
				                    }
				        	 		
				        	 		
				                },
				                
				                error: function() {
				                    alert("에러 발생");
				                }
				          		
				            });//ajax end
				            
						} //for end	
						
						// 로딩바를 해제한다.
	        			$('#Progress_Loading').hide();  
	        			$('#mask').hide();
				 		window.open("/board/listExcel?userId="+userId, "_blank", "width=2200, height=1200");
						
			 		},0); //settimeout end
				}else{
					alert("조회할 데이터가 없습니다.");
					return;
				}
			}); //onclick end
			
			/* $("#excelDown").on("click", function(){
				
				var regForm = $("form[name='frm'] .chk").length;
				
				if(regForm == 0){
					alert("조회된 데이터가 없습니다.");	
					return;
				}else{
					window.location = "/board/excelDown";
				}
				
			}); */
			
		});
	 	
		function insertItem(s_num, s_item, s_lprice, s_maker, s_brand, s_price, s_mall_nm, userId) {
			
			s_num = Number(s_num + 1);
			
			data = "s_num="+s_num+"&s_item="+s_item+"&s_lprice="+s_lprice+"&s_maker="+s_maker+"&s_brand="+s_brand+"&s_price="+s_price+"&s_mall_nm="+s_mall_nm+"&userId="+userId;
			
			$.ajax({
			    url: "/board/insertItem",
			    type: "get",
			    data: data,
			});
			
		}
		
		function deleteItem(userId) {
			
			$.ajax({
			    url: "/board/deleteItem?userId="+userId,
			    type: "get",
			});
			
		}
		
	 	
	</script>
	
	<body>
		<div id ="Progress_Loading"><!-- 로딩바 -->
		<img src="/resources/img/viewLoading_2.gif"/>
		</div>
	
		<div>
			<nav class="navbar navbar-expand-md bg-white navbar-white container" style="height: 100px;">
			<img src="/resources/img/logo.png" width="50px;" height="50px;"/>
			<ul class="navbar-nav">
				<c:choose>
					<c:when test="${member.userId == null}">
					 <li class="nav-item"><a class="nav-link text-dark" href="${path}/" style="font-weight: 600;">로그인</a></li>
					</c:when>
					<c:otherwise>
					<li class="nav-item"><a class="nav-link text-dark" href="#" style="font-weight: 600;">${member.userId} 님이 로그인 중입니다.</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="${path}/member/logout" style="font-weight: 600; margin-left: 750">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
			</nav>
			<br/>
			<%-- <hr />
			<div class="container">
				<%@include file="nav.jsp" %>
			</div>	
			<br/>	
			<br/>	
			<hr />
			<br/> --%>
			
			<div class="container">
				<button type="button" id="btn" class="btn btn-info">최저가 조회</button> 
			</div>
			
			<c:forEach items="${listAll}" var="list">
				<input type="hidden" name="s_price" value="${list.price_two}" />
				<input type="hidden" name="s_word" value="${list.key_word}" />
			</c:forEach>
			
			<section class="container" style="margin-top: 10px;">
				<form role="form" method="get">
					<table class="table table-hover">
						<tr><th>번호</th><th>상품번호</th><th>상품명</th><th>가격_1</th><th>가격_2</th><th>수량</th><th>검색어</th><!-- <th>등록일</th> --></tr>

					<c:forEach items="${list}" var="list">
						<%-- <tr>
							<td><input name="bno" 			value="${list.bno}"  		style="width: 30px;" readonly="readonly"/></td>
							<td><input name="i_no" 			value="${list.i_no}"  		style="width: 60px;" readonly="readonly"/></td>
							<td><input name="item_nm" 		value="${list.item_nm}" 	style="width: 500px;" readonly="readonly"/></td>
							<td><input name="price_one" 	value="${list.price_one}"  	style="width: 100px;" readonly="readonly"/></td>
							<td><input name="price_two" 	value="${list.price_two}" 	style="width: 100px;" readonly="readonly"/></td>
							<td><input name="item_count" 	value="${list.item_count}" 	style="width: 50px;" readonly="readonly"/></td>
							<td><input name="key_word" 		value="${list.key_word}" 	style="width: 300px;" readonly="readonly"/></td>
							<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd" /></td>
						</tr> --%>
						<colgroup>
						    <col style="width:5%">
						    <col style="width:10%">
						    <col style="width:40%">
						    <col style="width:10%">
						    <col style="width:10%">
						    <col style="width:5%">
						    <col style="width:30%">
						 </colgroup>
						<tr>
							<td><c:out value="${list.bno}" /></td>
							<td><c:out value="${list.i_no}" /></td>
							<td><c:out value="${list.item_nm}" /></td>
							<td><c:out value="${list.price_one}" /></td>
							<td><c:out value="${list.price_two}" /></td>
							<td><c:out value="${list.item_count}" /></td>
							<td><c:out value="${list.key_word}" /></td>
						</tr>
					</c:forEach>

				</table>
				
				<div class="search row">
					<div class="col-xs-2 col-sm-2">
					    <select name="searchType" class="form-control">
					      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
					      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>상품명</option>
					      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>검색어</option>
					      <%-- <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>?????</option>
					      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>?????</option> --%>
					    </select>
					</div>
					
					<div class="col-xs-10 col-sm-10">
						<div class="input-group">
					    	<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
					    	<span class="input-group-btn">
					    		<button id="searchBtn" type="button" class="btn btn-secondary">검색</button>
					    	</span>
					    </div>
					</div>
					
				    <script>
				      $(function(){
				        $('#searchBtn').click(function() {
				          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) + "&userId=${member.userId}";
				        });
				      });   
				    </script>
			  </div>
				
				<div class="container">
				  <ul class="pagination justify-content-center" style="margin:20px 0">
				    <c:if test="${pageMaker.prev}">
				    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}&userId=${member.userId}">이전</a></li>
				    </c:if> 
				
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				    	<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : '' }"/> class="page-item">
				    	<a class="page-link" href="list${pageMaker.makeSearch(idx)}&userId=${member.userId}">${idx}</a></li>
				    </c:forEach>
				
				    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}&userId=${member.userId}">다음</a></li>
				    </c:if> 
				  </ul>
				</div>
				</form>
			</section>
		</div>
		
		
		<!--<br/><br/>
		<hr/>
		<br/>
		<div>
		<section id="search">
		<button type="button" id="btn" class="btn btn-default">조회</button> 
		 <button type="button" id="excelDown" class="btn btn-default">엑셀다운로드</button>
			<br/><br/>
			<div id="display">
				<form name="frm" method="post">
				<table border="1"  style="border-collapse: collapse" id="display_1" class="table table-hover">
				<tr id = "display_2">
					<th style="width: 50px; border-color: black; text-align: center;">번호</th>
					<th style="width: 800px; border-color: black; text-align: center;">제품명</th>
					<th style="width: 100px; border-color: black; text-align: right;">가격</th>
				</tr>
				</table>
				</form>
			</div>
		</section>
		</div> -->			
	</body>
	
	<!-- <script>
	  var pageNum = 1 ;  //현재 페이지 번호
	  var totalPageCnt = 0 ; //전체 페이지 수
	  var totalCnt = 0;  //전체 글 수
	  var listCnt = 10;  //한 화면에 보여질 리스트 수
	  var pageSet = 10;  // 페이징 부부의 카운트 수
	  var searchString = ""; //검색
	$(function(){
	   searchList();  //목록 조회 함수 호출
	});
 
  	//정보 조회
	searchList = function(){
	  var startNum = (pageNum -1) * listCnt;  //현재 페이지 번호를 가지고 시작 위치를 구한다.    
	  var parameter = {
	    "SearchType" : $("#searchType").val() + ""
	    ,"SearchString" : $("#searchString").val() + ""
	    ,"startNum" : startNum + ""
	    ,"endNum" : listCnt + ""        
	    }
	  util.data.getDatafromUrl("/process/p_list.jsp", parameter, searchListCallback); //호출 주소는 적당히 알아서...
	  }
	   
	searchListCallback = function(resultData){
	    $("#listCont").empty(); //리스트 내용을 지움
	    if (resultData.list != null){
	      totalCnt = resultData.Cnt;
	      util.list.setListContent(resultData,"#listCont", "#listTmpl");  //util.list.setListContent(데이터, 대상 오브젝트, 템플릿스크립트 오브젝트);                   
	    }
	    util.list.paging("#paging", pageNum, listCnt, resultData.Cnt , "searchList()", "pageNum"); //페이징 처리
	  }
   
</script> -->
	
</html>
