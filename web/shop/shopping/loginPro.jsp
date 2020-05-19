<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.ShopBookDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");

	ShopBookDBBean manager = ShopBookDBBean.getInstance();
    int check= manager.userCheck(id,passwd);

	if(check==1){
		session.setAttribute("id",id);
		%>
			<script>
				const User_value = "<%=id%>";
				console.log(User_value);
				alert(User_value+"님, 반갑습니다.");
				location.href='shopMain.jsp';
			</script>
		<%
		}else if(check==0){
	%>
    <script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}else{ %>

	<script>
	  alert("아이디가 맞지 않습니다..");
	  history.go(-1);
	</script>
<%}
%>