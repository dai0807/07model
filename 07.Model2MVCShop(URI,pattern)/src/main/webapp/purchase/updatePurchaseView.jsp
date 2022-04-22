<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--
    /////////////////////////////////////////////////
      <%@ page import="com.model2.mvc.service.domain.Purchase" %>
    <%@ page import="com.model2.mvc.service.domain.User" %>
    
    <%@ page import="com.model2.mvc.common.*" %>

<%
Purchase purchase = (Purchase)request.getAttribute("purchase") ; 
String buyer_id = (String)request.getAttribute("buyer_id") ; 
	System.out.println("getpuchase에 왔나요 ");
	System.out.println("purchase  " + purchase );

  
%>
 --%>
<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>구매정보 수정</title>

<script type="text/javascript" src="../javascript/calendar.js">
</script>
<script type="text/javascript">
 
function fnUpdatePurchase() {
	document.updatePurchase.submit();
	document.detailForm.action();
}
 
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
		<!-- 	<c:set var="tran" value="${param.tranNo}" />  --> 

<form name="updatePurchase" method="post"	action="/purchase/updatePurchase?tranNo=${purchase.tranNo}">
 			   <input type="hidden" id="buyer_id" name="buyer_id" value="${buyer_id}"/>
 	
  <table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="300" class="ct_write">
			구매자 아이디 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" width="299">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${buyer_id} </td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption"		class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20">
							${ purchase.paymentOption}
				<option value="1" ${ purchase.paymentOption == "1" ? "selected" : "" }>현금구매</option> 
				<option value="2"${ purchase.paymentOption == "2" ? "selected" : "" }>신용구매</option> 
			</select>
		</td>
	</tr>
 <tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${purchase.receiverName }" />
		</td>
	</tr>
	
<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value=" ${purchase.receiverPhone}" />
		</td>
	</tr>
	<tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="dlvyAddr" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" 	value="${purchase.dlvyAddr }" />
		</td>
	</tr>
		<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input		type="text" name="dlvyRequest" 	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value="${purchase.dlvyRequest}"  />
		</td>
	</tr>
	 	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" name="dlvyDate" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20"/>
			<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
						onclick="show_calendar('document.updatePurchase.dlvyDate', document.updatePurchase.dlvyDate.value)"/>
		</td>
	</tr>
 	
	<tr>
</table>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
			<!-- 	 <td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					<input type="submit" value="수정"/>
				</td>	-->
				
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a href="javascript:fnUpdatePurchase();">수정</a>
					</td>
			
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<a href="javascript:history.go(-1)">취소</a>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>