<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<html>
<head>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('span').click(function(){
			self.location = "/purchase/listPurchase"
		});
	});
</script>
</head>

<body>

<form name="deletePurchase" method="post">

���Ű���Ұ� �Ǿ����ϴ�.<br/>
<span>
���ư���
</span>
<!-- <a href = "/purchase/listPurchase">���ư���</a> -->


</form>

</body>
</html>