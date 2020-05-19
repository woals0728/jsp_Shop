<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shop.CartDataBean" %>
<%@ page import = "shop.ShopBookDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>
<%
   String account = request.getParameter("account");
   String deliveryName = request.getParameter("deliveryName");
   String deliveryTel = request.getParameter("deliveryTel");
   String deliveryAddess = request.getParameter("deliveryAddess");
   String buyer = (String)session.getAttribute("id");
   
   ShopBookDBBean cartProcess = ShopBookDBBean.getInstance();
   List<CartDataBean> cartLists = cartProcess.getCart(buyer);
   
   ShopBookDBBean buyProcess = ShopBookDBBean.getInstance();
   
   buyProcess.insertBuy(cartLists,buyer,account, 
		   deliveryName, deliveryTel, deliveryAddess);
   
   response.sendRedirect("buyList.jsp");
%>