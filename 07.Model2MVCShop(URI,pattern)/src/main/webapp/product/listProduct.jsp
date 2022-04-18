<%@page import="java.awt.PageAttributes.OrientationRequestedType"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- 
	List<Product> list= (List<Product>)request.getAttribute("list");

	Map<String,Object> map=(Map<String,Object>)request.getAttribute("map");
	Search search=(Search)request.getAttribute("search");
	Page resultPage=(Page)request.getAttribute("resultPage");
	int currentPage=search.getCurrentPage();

	System.out.println("list Product.jsp의 currentPage   :"+ currentPage) ;

	String menu = request.getParameter("menu");
	if(menu == null){
		menu =(String)request.getAttribute("menu");
	}
	 String searchKeyword =CommonUtil.null2str(search.getSearchKeyword());
	 String searchCondition =CommonUtil.null2str(search.getSearchCondition()) ;

--%>  
    
    
<!DOCTYPE html>
<html>
<head>
 	
 
<c:if test="${menu=='search'}">
	<title>상품 검색</title>
</c:if>
<c:if test="${menu=='manage'}">
	<title>상품 관리</title>
</c:if>

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

<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">
<!-- menu를 manage로 보냄  -->

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
					
					  <c:if test="${menu=='search'}">
						  	 상품 검색
						  </c:if>
						<c:if test="${menu=='manage'}">
						  상품 관리 
						  </c:if>
						 
		 
					
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
				<select name="searchCondition"    class="ct_input_g" style="width:80px">
			 
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition =="0" ? "selected" : ""} > 상품번호</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition =="1" ? "selected" : ""} > 상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition =="2" ? "selected" : ""} > 상품가격</option>
		 
			
			
			
				</select>
		<input type="text" name="searchKeyword" value="${search.searchKeyword}"  class="ct_input_g" style="width:200px; height:19px" />
				
				
				
	</td>	
		
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList('1');">검색</a>
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
			<td colspan="11" >
	
	<%--	<td colspan="11" >전체  <%= total%> 건수, 현재 <%=currentPage %> 페이지</td> --%>
			전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
	 <c:if test="${menu eq 'manage'}"> <!--매ㅣ저일때 상태 보이게 하기   -->
		
		<td class="ct_line02"></td>
	
				<td class="ct_list_b">현재상태</td>	
		</c:if>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	

	
	 <c:set var="i" value="0" /> <!-- 값 세팅 --> 
	 <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
	
	<!--  System.out.println("list :::: "+list);
		int no=list.size();
		for(int i=0; i<list.size(); i++) {
			Product pv = (Product)list.get(i);
		
		-->
	<tr class="ct_list_pop">
		<td align="center">${i}</td>
		<td></td>
				<td align="left">
				
						
				<a href="${ menu == 'search' ? '/product/getProduct' : '/product/updateProductView'}?prodNo=${product.prodNo }&menu=${ menu }&tranCode=${product.proTranCode}">
							${ product.prodName }</a>
				</td>
		
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="center">${product.regDate}	</td>
		<td></td>	
			
		  <c:if test="${menu eq 'manage'}"> <!--매ㅣ저일때 상태 보이게 하기   -->
			 	<td align="left">
 				 		
				<c:if test = "${product.proTranCode eq'002'}">
				구매완료 &nbsp; &nbsp; 
						<a href="/updateProdcutTranCodeByProd.do?currentPage=${resultPage.currentPage}&prodNo=${product.prodNo}&tranCode=003&menu=manage">배송하기 </a>
				
				</c:if>
				<c:if test = "${ product.proTranCode eq '003'}">
				 	배송중 &nbsp; &nbsp; 
	 				
				</c:if>
				<c:if test ="${ product.proTranCode eq '004'}">
				 	배송완료 &nbsp; &nbsp; 
	 				
					</c:if>   


			</c:if>

		<td></td>		
	</tr>
	<tr>
	
</c:forEach>		
		
		
		
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>

	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
	<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// 		   
	<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
			◀ 이전
	<% }else{ %>
			<a href="javascript:fncGetUserList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
	<% } %>

	<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
			<a href="javascript:fncGetUserList('<%=i %>');"><%=i %></a>
	<% 	}  %>
	
	<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
			이후 ▶
	<% }else{ %>
			<a href="javascript:fncGetUserList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
	<% } %>
	 /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
	
		<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>