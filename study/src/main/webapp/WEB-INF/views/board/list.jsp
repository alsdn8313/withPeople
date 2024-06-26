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
		<style>
			@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
			 input {border: none;}
			 
			
			* {font-family: "IBM Plex Sans KR", sans-serif;}
			
			th {text-align : center;}
			td {text-align : center;}
			
			#loading {
			    width: 100%;
			    height: 100%;
			    top: 0;
			    left: 0;
			    position: fixed;
			    display: block;
			    background: #ededed;
			    opacity: 0.7;
			    z-index: 99;
			    text-align: center;
			}
			#loading > #loading_bar {
			    position: absolute;
			    top: 50%;
			    left: 50%;
			    z-index: 100;
			    transform : translate(-50%, -50%);
			}
			

		</style>
	</head>
	<script type="text/javascript">
		
		$(document).ready(function(){
		    var userId = "${member.userId}";
		    
			$("#btn").on("click", function(){
				//$("#display_1 td").empty();
				if(confirm("조회 하시겠습니까?")){
					$("#loading").show();
					stopClick();
				}
				
				if(document.getElementsByName("s_word").length > 0){
					//location.reload(true);
					//stopClick();
				    deleteItem(userId);
				    
					setTimeout(function () {
						
						//$(".i_tr").empty();
						
						var key_word = document.getElementsByName("s_word");
						var key_items = document.getElementsByName("s_item");
						var s_price = document.getElementsByName("s_price");
						
				 		for(var i = 0; i < key_word.length; i++){
				 		//for(var i = 0; i < 1; i++){
				 			var data_key = key_word[i].value;
				 			data_key = data_key.replace('[','');
				 			data_key = data_key.replace(']','');
				 			var data = "input=" + data_key + "&userId=" + userId;
				 			//var data = "input=GAS SH-3500[3]&userId="+userId;
				 			var price = s_price[i].value;
				 			var key_item = key_items[i].value;
				 			price = price.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',');
				 			//getItem(data);
				 			$.ajax({
					 	        
				                url:"/board/search",
				                type:"get",
				                dataType: 'json',
				                async: false,
					 			data: data,
				                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				                contentType: false,
				                processData: false,
				            	
				                success: function(data) {
				                    //resultHtml(data);
				                    if(data.items.length > 0){
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
							        	 		
							        	 		insertItem(i,title,lprice,maker,brand,price,mall_nm,userId, key_item);
					                    	}else{
					                    		insertItem(i,title,lprice,maker,brand,price,mall_nm,userId, key_item);
					                    	}
						                	return;
					                    }
				                    }else{
				                    	insertItem(i,title,lprice,maker,brand,price,mall_nm,userId, key_item);
				                    }
				        	 		
				                },
				                
				                error: function(e) {
				                    //alert("에러 발생");
				                    console.log(e);
				                    insertItemError(i,key_item[i].value,key_word[i].value,userId);
				                    return;
				                }
				          		
				            });//ajax end
				            
						} //for end	
						
						$('#loading').hide();
						location.reload();
				 		window.open("/board/listExcel?userId="+userId, "_blank", "width=2200, height=1200");
						//startClick();
						
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
	 	
		function insertItem(s_num, s_item, s_lprice, s_maker, s_brand, s_price, s_mall_nm, userId, key_item) {
			
			s_num = Number(s_num + 1);
			
			data = "s_num="+s_num+"&s_item="+s_item+"&s_lprice="+s_lprice+"&s_maker="+s_maker+"&s_brand="+s_brand+"&s_price="+s_price+"&s_mall_nm="+s_mall_nm+"&userId="+userId+"&key_item="+key_item;
			
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
		
		
		
		function stopClick() {
			var stopFunc = function(e) { e.preventDefault(); e.stopPropagation(); return false; };
			var all = document.querySelectorAll('*');
			for (var i = 0; i < all.length; i++) {
				var el = all[i];
				if (el.addEventListener) {
					el.addEventListener('click', stopFunc, true);
				}
			}
		}
		
		/* function startClick() {
			//var stopFunc = function(e) { e.preventDefault(); e.stopPropagation(); return false; };
			var all = document.querySelectorAll('*');
			for (var i = 0; i < all.length; i++) {
				var el = all[i];
				el.removeEventListener('click', stopClick, true);
			}
		} */
	 	
		function uploadView() {
			window.open("/board/uploadView?userId=${member.userId}", "_blank", "width=700, height=300");
		}
		
		
		function insertItemError(e_num, e_item, e_key, userId) {
			
			e_num = Number(e_num + 1);
			
			data = "e_num="+e_num+"&e_item="+e_item+"&e_key="+e_key+"&userId="+userId;
			
			$.ajax({
			    url: "/board/insertItemError",
			    type: "get",
			    data: data,
			});
			
		}
		
		
	</script>
	
	<body>
		<div id="loading" style="display: none; ">
		    <div id="loading_bar">
		        <!-- 로딩바의 경로를 img 태그안에 지정해준다. -->
		        <img src="/resources/img/viewLoading.gif">
		        <p style="font-size: x-large; font-weight: bold;">조회 중 입니다 ...</p>
		    </div>
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
          		<input type="button" id="uploadView" value="엑셀파일 업로드" onclick="uploadView();" class="btn btn-info" />
				<button type="button" id="btn" class="btn btn-info">최저가 조회</button>
            	<!-- <a href="${path}/document/applicant_excelUpload_form.xlsx" class="btn btn btn-primary btn-lg">양식파일 다운로드</a> -->
				<input type="text" id="uploadView" style="margin-left: 900" value="${pageMaker.totalCount} 건" />
			</div>
						
			<c:forEach items="${listAll}" var="list">
				<input type="hidden" name="s_price" value="${list.price_two}" />
				<input type="hidden" name="s_item" value="${list.item_nm}" />
				<input type="hidden" name="s_word" value="${list.key_word}" />
			</c:forEach>
			
			<section class="container" style="margin-top: 10px;">
				<form role="form" method="get">
					<table class="table table-hover">
						<tr><th>번호</th><th>상품번호</th><th>상품명</th><!-- <th>가격_1</th> --><th>가격</th><th>수량</th><th>검색어</th><!-- <th>등록일</th> --></tr>

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
						    <col style="width:50%">
						    <%-- <col style="width:10%"> --%>
						    <col style="width:10%">
						    <col style="width:5%">
						    <col style="width:30%">
						 </colgroup>
						<tr>
							<td><c:out value="${list.b_no}" /></td>
							<td><c:out value="${list.i_no}" /></td>
							<td><c:out value="${list.item_nm}" /></td>
							<%-- <td><c:out value="${list.price_one}" /></td> --%>
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
				          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) + "&userId=${member.userId}&gubun=${member.gubun}";
				        });
				      });   
				    </script>
			  </div>
				
				<div class="container">
				  <ul class="pagination justify-content-center" style="margin:20px 0">
				    <c:if test="${pageMaker.prev}">
				    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}&userId=${member.userId}&gubun=${member.gubun}">이전</a></li>
				    </c:if> 
				
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				    	<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : '' }"/> class="page-item">
				    	<a class="page-link" href="list${pageMaker.makeSearch(idx)}&userId=${member.userId}&gubun=${member.gubun}">${idx}</a></li>
				    </c:forEach>
				
				    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}&userId=${member.userId}&gubun=${member.gubun}">다음</a></li>
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
