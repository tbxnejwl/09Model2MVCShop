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

��ǰ�� �����Ǿ����ϴ�.<br/>
<span>
<%-- <a href = "/product/listProduct?menu=${param.menu}&orderby=${param.orderby}">���ư���</a> --%>
���ư���
</span>

</form>

</body>
</html>