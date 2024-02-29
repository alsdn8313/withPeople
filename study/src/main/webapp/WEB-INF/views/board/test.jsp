<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<style>
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
	
	<style>
    .container-able,
    .container-disable {
      display : inline-block;
      height : 150px;
      width : 150px;
      text-align : center;
      line-height: 150px;
      margin : 10px;
      cursor : pointer;
    }
    
    /* 클릭 영역 */
    .container-disable { 
      /* 클릭 불가능 none */
      pointer-events : none;
      background-color: lightsalmon;
    }
    
    /* 클릭 불가 영역 */
    .container-able {
      /* 클릭 가능 auto (기본설정)*/
      pointer-events : auto;
      background-color: lightgreen;
      
    }
	</style>
</head>
<script>
$(document).ready(function() {
    /* $(document).ajaxStart(function () {
        $('#loading').show(); // ajax 시작 -> 로딩바 표출
    });

    $(document).ajaxStop(function () {
        $('#loading').hide(); // ajax 끝 -> 로딩바 히든
    }); */
	$('#btn').click(function(){
		/* $.ajax({
	          type: 'POST',
	          contentType: 'application/json; charset=utf-8',
	          url: '/board/search', // ajax URL
	          dataType: 'json',
	          success: function (result) {
	            alert('test');  // 로딩을 보기 위한 alert창
	          }
	      }); */
	      
	      alert("클릭");
	      
			var stopFunc = function(e) { e.preventDefault(); e.stopPropagation(); return false; };
			var all = document.querySelectorAll('*');
			for (var i = 0; i < all.length; i++) {
				var el = all[i];
				if (el.addEventListener) {
					el.addEventListener('click', stopFunc, true);
				}
			}
			 
	});
    
    $('#btn2').click(function(){
    	var stopFunc = function(e) { e.preventDefault(); e.stopPropagation(); return false; };
    	var all = document.querySelectorAll('*');
    	for (var idx in all) {
    		var el = all[idx];
    		if (el.removeEventListener) {
    			el.removeEventListener('click', stopFunc, false); // stopFunc이 동일하게 구현되어있다는 가정하에
    		}
    	}
		
		alert("해제");
		
    });
});


</script>
<body>
테스트 페이지 <br>

<button name="btn" class="btn" id="btn">로딩버튼</button>
<button name="btn2" class="btn" id="btn2">로딩버튼2</button>

<div id="loading" style="display: none; ">
    <div id="loading_bar">
        <!-- 로딩바의 경로를 img 태그안에 지정해준다. -->
        <img src="/resources/img/viewLoading.gif">
        <p style="font-size: x-large; font-weight: bold;">로딩 중 입니다 ...</p>
    </div>
</div>
 <div class="container-able">
    클릭 영역
  </div>
  <div class="container-disable">
    클릭 금지 영역
  </div>

</body>
</html>


