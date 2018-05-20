<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>상품 목록조회</title>

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "td.ct_btn01:contains('구매')" ).on("click" , function() {
				//Debug..
				self.location = "/purchase/addPurchase?prodNo=${product.prodNo}"
			});
			
			 $( "td.ct_btn01:contains('이전')" ).on("click" , function() {
					//Debug..
				 history.go(-1);
				});
			 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
					//Debug..
					self.location = "/product/updateProduct?prodNo=${product.prodNo}&menu=manage"
				});
		});
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품상세조회</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${product.prodNo }</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품이미지<img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<img src = "/images/uploadFiles/${product.fileName}"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">제조일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">가격</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.price}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
				<select name="amount">
						<c:forEach begin="1" end="10" var="i">
							<option value="${i}">${i}</option>
						</c:forEach>
				</select>&nbsp;개</td>
			</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
		<c:if test="${user.role=='admin' }">
			<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" />
			</td>
			<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
			<%-- <a href="/product/updateProduct?prodNo=${product.prodNo}&menu=manage">
			수정
			</a> --%>
			수정
			</td>
			<td width="14" height="23">
			<img src="/images/ct_btnbg03.gif" width="14" height="23">
			</td>
			<td width="30"></td>

		</c:if>
		
		<c:if test="${empty user.role }">
		*구매를 원하시면 로그인 해주세요
		</c:if>															
		<c:if test="${param.menu=='search' && (!empty user.role || user.role=='admin') }">
			<c:choose>
			<c:when test="${product.proTranCode != '1'}">
			*판매된 상품은 구매하실 수 없습니다.
			</c:when>
			<c:otherwise>
			<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" />
			</td>
			<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
			<%-- <a href="/purchase/addPurchase?prodNo=${product.prodNo}">
			구매
			</a> --%>
			구매
			</td>
			<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
			<td width="30"></td>								
			</c:otherwise>
			</c:choose>
		</c:if>
			
		<td width="17" height="23">
			<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
		</td>
		<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
		<!-- <a href="javascript:history.go(-1)">이전</a> -->
		이전
		</td>
			<td width="14" height="23">
			<img src="/images/ct_btnbg03.gif" width="14" height="23">
		</td>
	</tr>
		</table>

		</td>
	</tr>
</table>
</form>

</body>
</html>