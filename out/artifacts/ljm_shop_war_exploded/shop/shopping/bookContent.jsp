<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import = "shop.ShopBookDBBean" %>
<%@ page import = "shop.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<%
    String book_kind = request.getParameter("book_kind");
    String book_id = request.getParameter("book_id");
    String id = "";
    int buy_price=0;
    try{
        if(session.getAttribute("id")==null)
            id="not";
        else
            id= (String)session.getAttribute("id");
    }catch(Exception e){}
%>
<html lang="en">
<head>
    <title>bookContent</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Colo Shop Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" href="plugins/themify-icons/themify-icons.css">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="styles/single_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/single_responsive.css">
</head>

<body>
<%
    ShopBookDataBean bookList = null;
    String book_kindName="";

    ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();

    bookList = bookProcess.getBook(Integer.parseInt(book_id));

    if(book_kind.equals("100"))
        book_kindName="신간";
    else if(book_kind.equals("200"))
        book_kindName="베스트셀러";
    else if(book_kind.equals("300"))
        book_kindName="국내도서";
    else if(book_kind.equals("400"))
        book_kindName="해외도서";
    else if(book_kind.equals("500"))
        book_kindName="EBOOK";
    else if(book_kind.equals("600"))
        book_kindName="웹소설";

%>

<div class="super_container">

    <!-- Header -->
    <jsp:include page="header_navigation.jsp" flush="false" />
    <br/><br/><br/>

    <div class="container single_product_container">


        <form name = "inform" method = "post" action = "cartInsert.jsp">
        <div class="row">
            <div class="col-lg-7">
                <div class="single_product_pics">
                    <div class="row">
                        <div class="col-lg-3 thumbnails_col order-lg-1 order-2">
                            <div class="single_product_thumbnails">
                                <ul>
                                    <li><img src="../../imageFile/<%=bookList.getBook_image()%>" alt="" data-image="../../imageFile/<%=bookList.getBook_image()%>" width="136" height="136"></li>
                                    <li class="active"><img src="../../imageFile/<%=bookList.getBook_image()%>" alt="" data-image="../../imageFile/<%=bookList.getBook_image()%>" width="136" height="136"></li>
                                    <li><img src="../../imageFile/<%=bookList.getBook_image()%>" alt="" data-image="../../imageFile/<%=bookList.getBook_image()%>" width="136" height="136"></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-9 image_col order-lg-2 order-1">
                            <div class="single_product_image">
                                <div class="single_product_image_background" style="background-image:url(../../imageFile/<%=bookList.getBook_image()%>)"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="product_details">
                    <div class="product_details_title">
                        <h2><%=bookList.getBook_title() %></h2>
                        <p><%=bookList.getBook_content()%></p>
                        <p>저자 : <%=bookList.getAuthor()%></p>
                        <p>출판사 : <%=bookList.getPublishing_com()%></p>
                        <p>출판일 : <%=bookList.getPublishing_date()%></p>
                    </div>
                    <div class="free_delivery d-flex flex-row align-items-center justify-content-center">
                        <span class="ti-truck"></span><span>무료 배송</span>
                    </div>
                    <div class="original_price"><%=NumberFormat.getInstance().format(bookList.getBook_price())%>원</div>
                    <%buy_price = (int)(bookList.getBook_price()*((double)(100-bookList.getDiscount_rate())/100)) ;%>
                    <div class="product_price"><%=NumberFormat.getInstance().format((int)(buy_price))%>원</div>
                    <div class="quantity d-flex flex-column flex-sm-row align-items-sm-center">
                        <span>수량: <input type="text" size="5"name="buy_count" value="1">&nbsp;&nbsp;</span>



                        <%
                            if(id.equals("not")) {
                                if(bookList.getBook_count()==0) {
                                    %>
                        <b>일시품절</b>
                        <%
                                }
                            }else{
                                if(bookList.getBook_count()==0) {
                                    %>
                        <b>일시품절</b>
                        <% }else{%>

                        <input type="hidden" name="book_id" value="<%=book_id %>">
                        <input type="hidden" name="book_image" value="<%=bookList.getBook_image()%>">
                        <input type="hidden" name="book_title" value="<%=bookList.getBook_title() %>">
                        <input type="hidden" name="buy_price" value="<%=buy_price %>">
                        <input type="hidden" name="book_kind" value="<%=book_kind %>">
                        <input type="submit" value="장바구니에 담기" class="red_button">
                               <% }
                                }
                        %>
                    </div>
                </div>
            </div>

        </div>
        </form>

    </div>

    <!-- Tabs -->



    <!-- Footer -->

    <br/><br/><br/><br/>
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="footer_nav_container">
                        <div class="cr" align="right">©2019 부산경상대학교 201606023 이재민</div>
                    </div>
                </div>
            </div>
        </div>
    </footer>

</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="js/single_custom.js"></script>
</body>

</html>
