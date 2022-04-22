<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
 
<title> 판매 목록조회  </title>
 


<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
<%-- 자바 스크립트 너무 싫습니다. 당신은 저한테 왜 이런 시련을 주시는 것인 지요
커런트 페이지 들어오고 , 커런트 페이지 id를 가진 태그에 들어가서 id의 "currentPage"에 value으로 놓기 


  --%>


 
function fncGetList(currentPage){
	document.getElementById("currentPage").value = currentPage;
	document.detailForm.submit();
}
 
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/purchase/listSale" method="post">
 
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">판매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	<td align="right">
		<tr>
			<td colspan="11" >전체  
			전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
	</tr>	
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">제품 번호 </td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">제품 이름 </td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>	
		<td class="ct_line02"></td>
 	
	</tr>
		<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	
	 <c:set var="i" value="0" /> <!-- 값 세팅 --> 
 	 
	 <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
							<%--
					 int no=list.size();
							for(int i=0; i<list.size(); i++) {
					          Purchase purchase = (Purchase)list.get(i) ;
							 --%>
			 <tr class="ct_list_pop">
			<td align="center" > ${i}</td>
 		 
 	 			
			<td></td>
					<td align="left">
						<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">  ${purchase.buyer.userId} </a></td>
			<td></td>
				 	<td align="left"> ${purchase.purchaseProd.prodNo }    </td>
			 <td></td>
 			 
						<td align="left"> ${purchase.purchaseProd.prodName }  </td>
			 <td></td>
			
						<td align="left"> ${purchase.receiverPhone}  </td>
			<td></td>
		
				 	<c:if test = "${ purchase.tranCode eq'000'}">
							<td align="left">  구매가능 &nbsp; &nbsp; </td>
		 				
					</c:if>		 			
					 <c:if test = "${ purchase.tranCode eq'002'}">
							<td align="left"> 구매완료 &nbsp; &nbsp; </td>
		 				
					</c:if>
					<c:if test ="${ purchase.tranCode eq'003'}">
					 	<td align="left"> 	배송중 &nbsp; &nbsp; </td>
		 				
					</c:if>
					<c:if test ="${ purchase.tranCode eq'004'}">
					 	<td align="left"> 	배송완료 &nbsp; &nbsp; </td>
		 				
					</c:if>  
	 
			<td></td>	
		</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
</c:forEach>		
 
  
	
		
		<td align="right" width="70">
		
		</td>
	 
</table>

 
 

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   		<jsp:include page="../common/pageNavigator.jsp"/>	
		 	
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>