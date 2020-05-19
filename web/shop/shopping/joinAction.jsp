<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="shop.ShopBookDBBean"%>
<%@ page import="shop.CustomerDataBean"%>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="member" scope="page" class="shop.CustomerDataBean"/>

<%
    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String tel = request.getParameter("tel");

    member.setId(id);
    member.setPasswd(passwd);
    member.setName(name);
    member.setAddress(address);
    member.setTel(tel);

    ShopBookDBBean join = ShopBookDBBean.getInstance();
    join.insertMember(member);
%>
    <script>
        alert("<%=id%>님 가입을 축하드립니다.");
        location.href= "shopMain.jsp";
    </script>

