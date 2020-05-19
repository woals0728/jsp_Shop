<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shop.ShopBookDBBean" %>
<%@ page import = "shop.ShopBookDataBean" %>
<%@ page import = "java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>

<html lang = kr>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Book Shopping Mall">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Book Shopping Mall</title>
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


    <div class="main_slider" style="background-image:url(images/slider_1.jpg)">
        <div class="container fill_height">
            <div class="row align-items-center fill_height">
                <div class="col">
                    <div class="main_slider_content">
                        <h6>2019 COLLECTION</h6>
                        <h1>BOOK SHOPPING MALL</h1>
                        <div class="red_button shop_now_button"><a href="../shopping/list.jsp?book_kind=all">SHOP NOW</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="banner">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="banner_item align-items-center" style="background-image:url(../../imageFile/1.jpg)">
                        <div class="banner_category">
                            <a href="list.jsp?book_kind=100">신간</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="banner_item align-items-center" style="background-image:url(../../imageFile/4.jpg)">
                        <div class="banner_category">
                            <a href="list.jsp?book_kind=200">베스트셀러</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="banner_item align-items-center" style="background-image:url(../../imageFile/7.jpg)">
                        <div class="banner_category">
                            <a href="list.jsp?book_kind=300">국내도서</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="banner_item align-items-center" style="background-image:url(../../imageFile/10.jpg)">
                        <div class="banner_category">
                            <a href="list.jsp?book_kind=400">해외도서</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="banner_item align-items-center" style="background-image:url(../../imageFile/13.jpg)">
                        <div class="banner_category">
                            <a href="list.jsp?book_kind=500">EBOOK</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="banner_item align-items-center" style="background-image:url(../../imageFile/16.jpg)">
                        <div class="banner_category">
                            <a href="list.jsp?book_kind=600">웹소설</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="new_arrivals">
        <div class="container">
            <div class="row">
                <div class="col text-center">
                    <div class="section_title new_arrivals_title">
                        <h2>신간</h2>
                    </div>
                </div>
            </div>
            <div class="row align-items-center">
                <div class="col text-center">
                    <div class="new_arrivals_sorting">
                        <ul class="arrivals_grid_sorting clearfix button-group filters-button-group">
                            <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center active is-checked" data-filter="*">전체</li>
                            <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".국내도서">국내도서</li>
                            <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".해외도서">해외도서</li>
                            <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".EBOOK">EBOOK</li>
                            <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".웹소설">웹소설</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col">

                    <div class="product-grid" data-isotope='{ "itemSelector": ".product-item", "layoutMode": "fitRows" }'>

                        <%
                            ShopBookDataBean bookLists[] = null;
                            String book_kindName="";

                            ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
                            for(int i=1; i<=6; i++) {
                                bookLists = bookProcess.getBooks(i + "00", 3);

                                if (bookLists[0].getBook_kind().equals("100")) {
                                    book_kindName = "신간";
                                } else if (bookLists[0].getBook_kind().equals("200")) {
                                    book_kindName = "베스트셀러";
                                } else if (bookLists[0].getBook_kind().equals("300")) {
                                    book_kindName = "국내도서";
                                } else if (bookLists[0].getBook_kind().equals("400")) {
                                    book_kindName = "해외도서";
                                } else if (bookLists[0].getBook_kind().equals("500")) {
                                    book_kindName = "EBOOK";
                                } else if (bookLists[0].getBook_kind().equals("600")) {
                                    book_kindName = "웹소설";
                                }


                            for(int j=0;j<bookLists.length;j++) {


                        %>
                        <!-- Product 1 -->

                        <div class="product-item <%=book_kindName%>">
                            <div class="product discount product_filter">
                                <div class="product_image">
                                    <a href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
                                        <img src="../../imageFile/<%=bookLists[j].getBook_image()%>" width="235" height="235"></a>
                                </div>
                                
                                <div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-<%=bookLists[j].getDiscount_rate()%>%</span></div>
                                <div class="product_info">
                                    <h6 class="product_name"><a href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
                                        <%=bookLists[j].getBook_title() %></a></h6>
                                    <%if(bookLists[j].getBook_count()==0){ %>
                                    <b>일시품절</b>
                                    <%} %>
                                    <div class="product_price">판매가 :<%=NumberFormat.getInstance().format((int)(bookLists[j].getBook_price()*((double)(100-bookLists[j].getDiscount_rate())/100)))%>원<span>정가 :<%=NumberFormat.getInstance().format(bookLists[j].getBook_price())%>원<br></span></div>
                                </div>

                            </div>






                    </div>
                        <%
                                }
                            }
                        %>
                        </div>

            </div>

        </div>
    </div>

        <div class="best_sellers">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <div class="section_title new_arrivals_title">
                            <h2>베스트셀러</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="product_slider_container">
                            <div class="owl-carousel owl-theme product_slider owl-loaded owl-drag">

                                <!-- Slide 1 -->

                                <%
                                    for(int i=1; i<=6; i++) {
                                        bookLists = bookProcess.getBooks(i + "00", 3);

                                        if (bookLists[0].getBook_kind().equals("100")) {
                                            book_kindName = "신간";
                                        } else if (bookLists[0].getBook_kind().equals("200")) {
                                            book_kindName = "베스트셀러";
                                        } else if (bookLists[0].getBook_kind().equals("300")) {
                                            book_kindName = "국내도서";
                                        } else if (bookLists[0].getBook_kind().equals("400")) {
                                            book_kindName = "해외도서";
                                        } else if (bookLists[0].getBook_kind().equals("500")) {
                                            book_kindName = "EBOOK";
                                        } else if (bookLists[0].getBook_kind().equals("600")) {
                                            book_kindName = "웹소설";
                                        }

                                    for(int j=0;j<bookLists.length;j++) {


                                %>

                                <div class="owl-item product_slider_item">
                                    <div class="product-item <%=book_kindName%>">
                                        <div class="product discount">
                                            <div class="product_image">
                                                <img src="../../imageFile/<%=bookLists[j].getBook_image()%>" width="235" height="235">
                                            </div>
                                            <div class="favorite favorite_left"></div>
                                            <div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-<%=bookLists[j].getDiscount_rate()%>%</span></div>
                                            <div class="product_info">
                                                <h6 class="product_name"><a href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>"><%=bookLists[j].getBook_title() %></a></h6>
                                                <%if(bookLists[j].getBook_count()==0){ %>
                                                <b>일시품절</b>
                                                <%} %>
                                                <div class="product_price">판매가 :<%=NumberFormat.getInstance().format((int)(bookLists[j].getBook_price()*((double)(100-bookLists[j].getDiscount_rate())/100)))%>원<span>정가 :<%=NumberFormat.getInstance().format(bookLists[j].getBook_price())%>원</span></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                            <%
                                                    }
                                                }
                                            %>

                            </div>

                            <!-- Slider Navigation -->

                            <div class="product_slider_nav_left product_slider_nav d-flex align-items-center justify-content-center flex-column">
                                <i class="fa fa-chevron-left" aria-hidden="true"></i>
                            </div>
                            <div class="product_slider_nav_right product_slider_nav d-flex align-items-center justify-content-center flex-column">
                                <i class="fa fa-chevron-right" aria-hidden="true"></i>
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