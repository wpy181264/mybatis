<%--
  Created by IntelliJ IDEA.
  User: 文沛阳
  Date: 2020/7/19
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src=<%=request.getContextPath()%>\res\js\jquery-1.12.4.js></script>
    <script type="text/javascript">
        function login() {
            $.get("<%=request.getContextPath()%>/user",
                $("#fm").serialize(),
                function (data) {

                })
            location.href = "<%=request.getContextPath()%>/user/toShow";
        }
    </script>
</head>
<body>
<form id="fm">
    用户名<input type="text" name="userName"/><br/>
    密码<input type="text" name="userPwd"/><br/>
    <input type="button" value="登录" onclick="login()"/>
</form>


</body>
</html>
