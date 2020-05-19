<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="utf-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Book Shopping Mall">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="http://l.bsks.ac.kr/~p201887082/DiliManage/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="login.css">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/responsive.css">
</head>

<body>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <%
                try{
                    if(session.getAttribute("id")==null){%>
            <div class="modal-body">
                <div class="text">
                    <h3 class="login-p">LOGIN</h3>
                    <p class="login-p2">회원님의 아이디와 비밀번호를 입력해주세요.</p>
                    <form name="login-form" method="post" action="loginPro.jsp">
                        <div class="userid" align="center"><input type="text" name="id" placeholder="ID" class="id-input" maxlength="50" size="45" required/> </div>
                        <div class="userpass" align="center"><input type="text" name="passwd" placeholder="PASSWORD" class="pass-input" maxlength="16" size="45" required/> </div>
                        <div class="login-btn" align="center"><input type="submit" value="LOGIN" class="red_button shop_now_button" /></div>
                    </form>

                    <%}
                    }catch(NullPointerException e){
                        e.printStackTrace();
                    }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="text">
                    <h3 class="login-p">회원가입</h3>
                    <script type="text/javascript">
                        function openConfirmid(inputid) {
                            if(inputid.id.value == "") {
                                alert("아이디를 입력하세요");
                                return;
                            }

                            var popupX = (window.screen.width / 2) - (200 / 2);
                            var popupY = (window.screen.height / 2) - (300 / 2);
                            url = "confirmid.jsp?id=" + inputid.id.value;
                            window.open(url, "confirm",  "resizable = no, scrollbars = no, width=500, height=300, left=" + popupX + ", top=" + popupY);
                        }

                    </script>
                    <form name="userinput" method="post" action="joinAction.jsp" onsubmit="return checkIt()">
                        <div class="userid" align="center"><input type="text" name="id" placeholder="ID(최대 50자)" class="login-input" maxlength="50" size = "36" required/>
                            <input type="button" class="red_button" value="중복확인" name="confirm_id" onclick="openConfirmid(this.form)"> </div>
                        <div class="userpass" align="center"><input type="text" name="passwd" placeholder="PASSWORD(최대 16자)" class="login-input" size="45" maxlength="16" required/> </div>
                        <div class="username" align="center"><input type="text" name="name" placeholder="이름" class="login-input" size="45" required/> </div>
                        <div class="usertell" align="center"><input type="text" name="address" placeholder="주소" class="login-input" size="45" required/> </div>
                        <div class="useraddr" align="center"><input type="text" name="tel" placeholder="전화번호" class="login-input" size="45" maxlength="13" required/> </div>
                        <div class="btn-box" align="center">
                            <input type="submit" value="회원가입" class="red_button shop_now_button" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="text">
                    <h3 class="login-p">회원정보 수정</h3>
                    <form name="join-form" method="post" action="updateMember.jsp">
                        <div class="userid" align="center"><input type="text" name="id" placeholder="ID(최대 10자)" class="login-input" maxlength="50" size="45" required/> </div>
                        <div class="userpass" align="center"><input type="text" name="passwd" placeholder="PASSWORD(최대 16자)" class="login-input" maxlength="16" size="45" required/> </div>
                        <div class="username" align="center"><input type="text" name="name" placeholder="이름" class="login-input" size="45" required/> </div>
                        <div class="usertell" align="center"><input type="text" name="address" placeholder="주소" class="login-input" maxlength="13" size="45" required/> </div>
                        <div class="useraddr" align="center"><input type="text" name="tel" placeholder="전화번호(-포함하여 작성)" class="login-input" size="45" required/> </div>
                                    <div class="btn-box" align="center">
                                        <input type="submit" value="수정" class="red_button shop_now_button" size="10"/>
                                        <input type="button" value="취소" class="red_button shop_now_button" data-dismiss="modal" aria-label="Close" size="10"/>
                                    </div>


                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<header class="header trans_300">
<div class="top_nav">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="top_nav_left" href="../manager/managerMain.jsp">JSP 쇼핑몰</div>
            </div>
            <div class="col-md-6 text-right">
                <div class="top_nav_right">
                    <ul class="top_nav_menu">

                        <!-- Currency / Language / My Account -->

                        <li class="account">
                            <a href="#">
                                My Account
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="account_selection">
                                <%if(session.getAttribute("id")==null){%>
                                <li><a data-toggle="modal" href="#myModal"><i class="fa fa-sign-in" aria-hidden="true"></i>로그인</a></li>
                                <li><a data-toggle="modal" href="#myModal2"><i class="fa fa-user-plus" aria-hidden="true"></i>회원가입</a></li>
                                <%}else{%>
                                <li><a data-toggle="modal" href="#myModal3"><i class="fa fa-sign-in" aria-hidden="true"></i>정보수정</a></li>
                                <li><a href="#" onclick="javascript:window.location='../shopping/logout.jsp'"><i class="fa fa-user-plus" aria-hidden="true"></i>로그아웃</a></li>
                                <%}%>

                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="main_nav_container">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-right">
                <div class="logo_container">
                    <a href="shopMain.jsp">Book<span>Shop</span></a>
                </div>
                <nav class="navbar">
                    <ul class="navbar_menu">
                        <li><a href="../shopping/list.jsp?book_kind=all">전체</a></li>
                        <li><a href="../shopping/list.jsp?book_kind=100">신간</a></li>
                        <li><a href="../shopping/list.jsp?book_kind=200">베스트셀러</a></li>
                        <li><a href="../shopping/list.jsp?book_kind=300">국내도서</a></li>
                        <li><a href="../shopping/list.jsp?book_kind=400">외국도서</a></li>
                        <li><a href="../shopping/list.jsp?book_kind=500">eBook</a></li>
                        <li><a href="../shopping/list.jsp?book_kind=600">웹소설</a></li>
                    </ul>
                    <ul class="navbar_user">
                        <li class="checkout">
                            <a href="../shopping/cartList.jsp?book_kind=all">
                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                            </a>
                        </li>
                    </ul>
                    <div class="hamburger_container">
                        <i class="fa fa-bars" aria-hidden="true"></i>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</div>
</header>
<div class="fs_menu_overlay"></div>
<div class="hamburger_menu">
    <div class="hamburger_close"><i class="fa fa-times" aria-hidden="true"></i></div>
    <div class="hamburger_menu_content text-right">
        <ul class="menu_top_nav">

            <li class="menu_item has-children">
                <a href="#">
                    My Account
                    <i class="fa fa-angle-down"></i>
                </a>
                <ul class="menu_selection">
                    <li><a data-toggle="modal" href="#myModal"><i class="fa fa-sign-in" aria-hidden="true"></i>로그인</a></li>
                    <li><a data-toggle="modal" href="#myModal2"><i class="fa fa-user-plus" aria-hidden="true"></i>회원가입</a></li>
                </ul>
            </li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=all">전체</a></li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=100">신간</a></li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=200">베스트셀러</a></li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=300">국내도서</a></li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=400">해외도서</a></li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=500">EBOOK</a></li>
            <li class="menu_item"><a href="../shopping/list.jsp?book_kind=600">웹소설</a></li>
        </ul>
    </div>
</div>



<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="js/custom.js"></script>
<script src="http://l.bsks.ac.kr/~p201887082/DiliManage/js/jq.js"></script>
<script src="http://l.bsks.ac.kr/~p201887082/DiliManage/js/bootstrap.js"></script>
<script src="js/modal_clear.js"></script>
</body>
</html>
