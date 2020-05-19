<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import = "shop.ShopBookDBBean" %>
<%@ page import = "shop.ShopBookDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book Shop Lists</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Colo Shop Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="styles/categories_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/categories_responsive.css">
</head>

<body>

<div class="super_container">

    <jsp:include page="header_navigation.jsp" flush="false" />
    <br/><br/><br/>

    <div class="container product_section_container">
        <div class="row">
            <div class="col product_section clearfix">
                <!-- Sidebar -->

                <div class="sidebar">
                    <div class="sidebar_section">
                        <div class="sidebar_title">
                            <h5>책 목록</h5>
                        </div>
                        <ul class="sidebar_categories">
                            <li><a href="../shopping/list.jsp?book_kind=all">전체</a></li>
                            <li><a href="../shopping/list.jsp?book_kind=100">신간</a></li>
                            <li><a href="../shopping/list.jsp?book_kind=200">베스트셀러</a></li>
                            <li><a href="../shopping/list.jsp?book_kind=300">국내도서</a></li>
                            <li><a href="../shopping/list.jsp?book_kind=400">해외도서</a></li>
                            <li><a href="../shopping/list.jsp?book_kind=500">EBOOK</a></li>
                            <li><a href="../shopping/list.jsp?book_kind=600">웹소설</a></li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->

                <div class="main_content">

                    <!-- Products -->

                    <div class="products_iso">
                        <div class="row">
                            <div class="col">

                                <!-- Product Sorting -->

                                <div class="product_sorting_container product_sorting_container_top">
                                    <ul class="product_sorting">
                                        <li>
                                            <span class="type_sorting_text">정렬</span>
                                            <i class="fa fa-angle-down"></i>
                                            <ul class="sorting_type">
                                                <li class="type_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'><span>정렬</span></li>
                                                <li class="type_sorting_btn" data-isotope-option='{ "sortBy": "price" }'><span>가격 정렬</span></li>
                                                <li class="type_sorting_btn" data-isotope-option='{ "sortBy": "name" }'><span>이름 정렬</span></li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="pages d-flex flex-row align-items-center">
                                        <div class="page_current">
                                            <span>1</span>
                                            <ul class="page_selection">
                                                <li><a href="#">1</a></li>
                                                <li><a href="#">2</a></li>
                                                <li><a href="#">3</a></li>
                                            </ul>
                                        </div>
                                        <div class="page_total"><span>of</span> 3</div>
                                        <div id="next_page" class="page_next"><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
                                    </div>

                                </div>

                                <!-- Product Grid -->

                                <div class="product-grid">
                                    <%
                                        String book_kind = request.getParameter("book_kind");
                                        List<ShopBookDataBean> bookLists = null;
                                        ShopBookDataBean bookList = null;
                                        String book_kindName ="";

                                        ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();

                                        bookLists = bookProcess.getBooks(book_kind);
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
                                        else if(book_kind.equals("all"))
                                            book_kindName="전체";

                                        for(int i=0; i<bookLists.size(); i++) {
                                            bookList = (ShopBookDataBean)bookLists.get(i);
                                    %>
                                    <div class="product-item men">
                                        <div class="product discount product_filter">
                                            <div class="product_image">
                                                <img src="../../imageFile/<%=bookList.getBook_image()%>" alt="" href="bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>" width="235" height="235">
                                            </div>
                                            <div class="favorite favorite_left"></div>
                                            <div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-<%=bookList.getDiscount_rate()%>%</span></div>
                                            <div class="product_info">
                                                <h6 class="product_name"><a href="bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>"><%=bookList.getBook_title() %></a></h6>
                                                <% if(bookList.getBook_count()==0){ %>
                                                <b>일시품절</b>
                                                <%}else{ %>
                                                <%} %>
                                                <div class="product_price">판매가 : <%=NumberFormat.getInstance().format((int)(bookList.getBook_price()*((double)(100-bookList.getDiscount_rate())/100)))%><br/><span>정가 : <%=NumberFormat.getInstance().format(bookList.getBook_price())%></span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                    <!-- Product 2 -->


                                </div>

                                <!-- Product Sorting -->

                                <div class="product_sorting_container product_sorting_container_bottom clearfix">
                                    <ul class="product_sorting">
                                        <li>
                                            <span>목록:</span>
                                            <span class="num_sorting_text">04</span>
                                            <i class="fa fa-angle-down"></i>
                                            <ul class="sorting_num">
                                                <li class="num_sorting_btn"><span>01</span></li>
                                                <li class="num_sorting_btn"><span>02</span></li>
                                                <li class="num_sorting_btn"><span>03</span></li>
                                                <li class="num_sorting_btn"><span>04</span></li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="pages d-flex flex-row align-items-center">
                                        <div class="page_current">
                                            <span>1</span>
                                            <ul class="page_selection">
                                                <li><a href="#">1</a></li>
                                                <li><a href="#">2</a></li>
                                                <li><a href="#">3</a></li>
                                            </ul>
                                        </div>
                                        <div class="page_total"><span>of</span> 3</div>
                                        <div id="next_page_1" class="page_next"><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
<script src="js/categories_custom.js"></script>
</body>

</html>
