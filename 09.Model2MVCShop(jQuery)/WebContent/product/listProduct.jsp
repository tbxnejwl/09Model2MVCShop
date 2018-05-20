<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title></title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();	
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}&orderby=${param.orderby}").submit();
	}
	
	$(function(){
		
		$(".regdate").on("click", function(){
			self.location = "/product/listProduct?menu=search&orderby=regdate"
		});
		
		$(".lowprice").on("click", function(){
			self.location = "/product/listProduct?menu=search&orderby=lowprice"
		});
		
		$(".highprice").on("click", function(){
			self.location = "/product/listProduct?menu=search&orderby=highprice"
		});
			
		$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			fncGetList(1);
		});		
		
		//$(".ct_list_pop :nth-child(3n+2)" ).css("background-color" , "whitesmoke");
	});
	

 	$(function(){

		$(".ct_list_pop td:nth-child(4)").on("click", function(){
			var index = $($(".ct_list_pop td:nth-child(4)")).index(this);
			var prodNo = $($("input[name=prodNo]")[index]).val();
			self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=${param.menu}"					
		 	});
		
		$(".ct_list_pop td:nth-child(4)").on("click", function(){
			var index = $($(".ct_list_pop td:nth-child(4)")).index(this);
			var prodNo = $($("input[name=prodNo]")[index]).val();
			self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}"
			});
		$(".ct_list_pop td:nth-child(11)").on("click", function(){
			var index = $($(".ct_list_pop td:nth-child(11)")).index(this);
			var prodNo = $($("input[name=prodNo]")[index]).val();
			self.location = "/product/deleteProduct?prodNo="+prodNo+"&menu=${param.menu}"
			});
		
		$(".ct_list_pop td:nth-child(10)").on("click", function(){
			var index = $($(".ct_list_pop td:nth-child(10)")).index(this);
			var prodNo = $($("input[name=prodNo]")[index]).val();
			var proTranCode = $($("input[name=proTranCode]")[index]).val();
			self.location = "/purchase/updateTranCode?prodNo="+prodNo+"&tranCode="+proTranCode
			});
		
	}); 

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<c:if test="${param.menu == 'search' }">
						상품 목록조회
					</c:if>
					<c:if test="${param.menu == 'manage' }">
						상품 관리
					</c:if>					
					</td>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>

		<td align="right">
			<!-- <a href="/product/listProduct?menu=search&orderby=regdate">신상품순</a> -->
			<span class="regdate">신상품순</span>
			|
			<!-- <a href="/product/listProduct?menu=search&orderby=lowprice">낮은가격순</a> -->
			<span class="lowprice">낮은가격순</span>
			|
			<!-- <a href="/product/listProduct?menu=search&orderby=highprice">높은가격순</a> -->
			<span class="highprice">높은가격순</span>
			
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			</select>

			<input type="text" name="searchKeyword" value="${search.searchKeyword}" class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetList('1');">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>		
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>
		
		<c:if test="${user.role.equals('admin') && param.menu=='manage'}">
			<td class="ct_list_b">제품삭제</td>
			<td class="ct_line02"></td>
		</c:if>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${ list }">
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			
			<td>
			<div style="width: 90px; height: 90px; overflow: hidden">
			<img src = "/images/uploadFiles/${product.fileName}" style="max-width: 100%; height: 100%;"/>
			</div>
			</td>
			
				
			<c:if test="${param.menu == 'manage' }" >		
				 <td align="left"><%--<a href="/product/updateProduct?prodNo=${product.prodNo}&menu=manage">${product.prodName}</a> --%>
				${product.prodName}
				<input type="hidden" name="prodNo" value="${product.prodNo }"/>
				</td>
			</c:if>
			<c:if test="${param.menu == 'search' }">				
			<td align="left"><%-- <a href="/product/getProduct?prodNo=${product.prodNo}&menu=search">${product.prodName}</a> --%>
			${product.prodName}
			<input type="hidden" name="prodNo" value="${product.prodNo }"/>
			</td>
			</c:if>
			<td></td>
			
			<td align="left">${product.price}</td>
			<td></td>
			
			<td align="left">${product.regDate}</td>
			<td></td>
			
			<c:choose>
	
			<c:when test="${user.role.equals('admin') }">
				<c:if test="${product.proTranCode == '1' }" >
					<td align="left">판매중</td>
				</c:if>
				<c:if test="${product.proTranCode == '2'  && param.menu == 'search' }" >
					<td align="left">구매완료</td>
				</c:if>
				<c:if test="${product.proTranCode == '2'  && param.menu == 'manage' }" >					
					<td align="left">구매완료
					
					<input type="hidden" name="prodNo" value="${product.prodNo }"/>
					<input type="hidden" name="proTranCode" value="${product.proTranCode}"/>
					<%-- <a href="/purchase/updateTranCode?prodNo=${product.prodNo}&tranCode=${product.proTranCode}">배송하기</a> --%>
					배송하기
				</td>
				</c:if>
				<c:if test="${product.proTranCode == '3' }" >
					<td align="left">배송중</td>
				</c:if>
				<c:if test="${product.proTranCode == '4' }" >
					<td align="left">배송완료</td>
				</c:if>
			</c:when>
			
			<c:when test=" ${user.role.equals('user') }" >
				<c:if test="${product.proTranCode == '1' }" >
					<td align="left">판매중</td>
				</c:if>
				<c:if test="${product.proTranCode == '2' }" >
					<td align="left">재고없음</td>
				</c:if>
				<c:if test="${product.proTranCode == '3' }" >
					<td align="left">재고없음</td>
				</c:if>
				<c:if test="${product.proTranCode == '4' }" >
					<td align="left">재고없음</td>
				</c:if>			
			</c:when>
			
			<c:otherwise>
				<c:if test="${product.proTranCode == '1' }" >
					<td align="left">판매중</td>
				</c:if>
				<c:if test="${product.proTranCode == '2' }" >
					<td align="left">재고없음</td>
				</c:if>
				<c:if test="${product.proTranCode == '3' }" >
					<td align="left">재고없음</td>
				</c:if>
				<c:if test="${product.proTranCode == '4' }" >
					<td align="left">재고없음</td>
				</c:if>		
			</c:otherwise>
		</c:choose>
												
		
		<c:if test="${user.role.equals('admin') && param.menu=='manage'}">
		<td align="left">
		<input type="hidden" name="prodNo" value="${product.prodNo }"/>
		<%-- <a href="/product/deleteProduct?prodNo=${product.prodNo}&menu=manage">제품삭제</td> --%>
		제품삭제
		<td></td>
		</c:if>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">

		<input type="hidden" id="currentPage" name="currentPage" value="0"/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		
					
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
