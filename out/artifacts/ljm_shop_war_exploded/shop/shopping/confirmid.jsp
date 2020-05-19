<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %>
<%@ page import ="shop.ShopBookDBBean" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
    <title>ID 중복확인</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    ShopBookDBBean sign = ShopBookDBBean.getInstance();
    int check = sign.confirmId(id);

    if(check == 1) {%>
    <b><font color = "red"><%=id%></font>는 이미 사용중인 아이디입니다.</b>
    <form name = "checkForm" method="post" action = "confirmid.jsp" onsubmit="return Check()">
        <b>다른 아이디를 입력하세요.</b><br /><br />
        <input type="text" name="id"/>
        <input type="submit" value="ID중복확인"/>
    </form>
    <%
        } else {
    %><center>
    <b>입력하신<font color="red"><%=id%></font>는 사용하실 수 있는 ID입니다. </b><br/><br/>
    <b>사용하시겠습니까?</b><br/><br/>
    <input type="button" value="확인" onclick="setid()">
    <input type="button" value="취소" onclick="window.close()">
</center>
<%}%>

<script language="javascript">
    function setid() {
        opener.document.userinput.id.value="<%=id%>";
        self.close();
    }
    function Check() {
        var form = document.checkForm;
        if(!form.id.value) {
            alert("아이디를 입력하세요.");
            return false;
        }
    }
</script>

</body>
</html>
