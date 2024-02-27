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
		</style>
	</head> 
<script>
	
function _onSubmit(){
	
	if($("#file").val() == ""){
        alert("파일을 업로드해주세요.");
        $("#file").focus();
        return false;
    }
	
	var form = $('#inputForm')[0];
	var data = new FormData(form);
	
	    $.ajax({
	        enctype: 'multipart/form-data',
	        type: 'POST',
	        url: '/board/readExcel?userId=${member.userId}',
	        processData: false,   
	        contentType: false,
	        cache: false,
	        async: false,
	        data: data,
	        success: function(data) {
	        },
	        error: function(e) {
	            console.log(e);
	            alert('파일업로드 실패');
	        },
	        complete : function() {
	        	opener.location.reload();
	        	window.close();
	        }    
	    });
}
</script>
 
<div id="container">
    <form id="inputForm" method="post"  <%-- action="${path}/board/readExcel?userId=${member.userId}"--%>    enctype="multipart/form-data" class="form-horizontal">
        <div class="panel">
            <div class="panel-body">
            <h4 class="mt0"><i class="fa fa-cube" aria-hidden="true"></i>EXCEL 업로드</h4>
                <div class="table-responsive">
                <!-- <p> 양식파일을 다운로드 하시고 파일내에 있는 모든 항목들을 채워서 업로드하셔야 정상적으로 등록됩니다.</p> -->
                <table id="datatable-scroller" class="table table-bordered tbl_Form">
                        <colgroup>
                            <col width="250px" />
                            <col />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="active" style="text-align:right"><label class="control-label" for="">파일 업로드</label></th>
                                <td>
                                    <input type="file" name="file" id="file" accept=".xlsx, .xls"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="pull-right">
            <input type="submit" value="엑셀파일 업로드" class="btn btn btn-primary btn-lg" onclick="_onSubmit()"/>
            <a href="${path}/document/applicant_excelUpload_form.xlsx" class="btn btn btn-primary btn-lg">양식파일 다운로드</a>
        </div>
    </form>
</div>