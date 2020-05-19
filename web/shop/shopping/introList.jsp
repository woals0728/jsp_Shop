<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shop.ShopBookDBBean" %>
<%@ page import = "shop.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>


<html>
<head>
<title>Book Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<h3>신간소개</h3>
<%
  ShopBookDataBean bookLists[] = null;
  int number =0;
  String book_kindName="";
  
  ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
  for(int i=1; i<=6;i++){
	  bookLists = bookProcess.getBooks(i+"00",3);
     
     if(bookLists[0].getBook_kind().equals("100")){
	      book_kindName="신간";
     }else if(bookLists[0].getBook_kind().equals("200")){
	      book_kindName="베스트셀러";
     }else if(bookLists[0].getBook_kind().equals("300")){
	      book_kindName="국내도서";
     }else if(bookLists[0].getBook_kind().equals("400")){
         book_kindName="해외도서";
     }else if(bookLists[0].getBook_kind().equals("500")){
         book_kindName="EBOOK";
     }else if(bookLists[0].getBook_kind().equals("600")){
         book_kindName="웹소설";
     }
%>
  <br><font size="+1"><b><%=book_kindName%> 분류의 목록:
  <a href="list.jsp?book_kind=<%=bookLists[0].getBook_kind()%>">더보기</a>
  </b></font>
<%             
  for(int j=0;j<bookLists.length;j++){
%>
    <table > 
      <tr height="30">
        <td rowspan="4"  width="100">
          <a href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
             <img src="../../imageFile/<%=bookLists[j].getBook_image()%>"  
             border="0" width="60" height="90"></a></td> 
       <td width="350"><font size="+1"><b>
          <a href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
              <%=bookLists[j].getBook_title() %></a></b></font></td> 
       <td rowspan="4" width="100">
          <%if(bookLists[j].getBook_count()==0){ %>
              <b>일시품절</b>
          <%}  %>
       </td>
     </tr>        
     <tr height="30">
       <td width="350">출판사 : <%=bookLists[j].getPublishing_com()%></td> 
     </tr>
     <tr height="30">
       <td width="350">저자 : <%=bookLists[j].getAuthor()%></td>
     </tr>
     <tr height="30">
       <td width="350">정가 :<%=NumberFormat.getInstance().format(bookLists[j].getBook_price())%>원<br>
                판매가 : <b><font color="red">
       <%=NumberFormat.getInstance().format((int)(bookLists[j].getBook_price()*((double)(100-bookLists[j].getDiscount_rate())/100)))%>
            </font></b>원</td> 
     </tr> 
     </table>
     <br>
<%
  }
}
%>

</body>
</html>