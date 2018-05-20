<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<html>
<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('span').click(function(){
			self.location = "/product/listProduct?menu=${param.menu}&orderby=${param.orderby}"
		});
	});
</script>

</head>

<body>

<form id="deleteProduct" method="post" >

상품이 삭제되었습니다.<br/>
<span>
<%-- <a href = "/product/listProduct?menu=${param.menu}&orderby=${param.orderby}">돌아가기</a> --%>
돌아가기
</span>

</form>

</body>
</html>