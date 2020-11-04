<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src=<%=request.getContextPath()%>\res\js\jquery-1.12.4.js></script>
    <script type="text/javascript">
        function selec() {
            uId = $('input[name="uId"]:checked');
            var pid = [];
            $.each(uId, function () {
                pid.push($(this).val());
            })
            return pid;
        }

        $(function () {
            $("#pageNo").val(1);
            show();
        })

        function sel() {
            $("#pageNo").val(1);
            show();
        }

        function show() {
            $.post("<%=request.getContextPath()%>/user/list",
                $("#fm").serialize(),
                function (data) {
                    var html = "";
                    var pageHtml = "";
                    for (var i = 0; i < data.data.records.length; i++) {
                        var u = data.data.records[i];
                        html += "<tr>"
                        html += "<td><input type='checkbox' value='" + u.id + "' name='uId'></td>"
                        html += "<td>" + u.userName + "</td>"
                        html += "<td>" + u.userPwd + "</td>"
                        html += "<td>" + u.userAge + "</td>"
                        if (u.userSex == 1) {
                            html += "<td>男</td>";
                        } else {
                            html += "<td>女</td>";
                        }
                        html += "<td>" + u.userPho + "</td>"
                        html += "<td>" + u.userEmail + "</td>"
                        if (u.userHobby == 1) {
                            html += "<td>足球</td>"
                        } else if (u.userHobby == 2) {
                            html += "<td>篮球</td>"
                        } else {
                            html += "<td>棒球</td>"
                        }
                        html += "<td><input type = 'button' value = '删除' onclick='del(" + u.id + ")'/></td>"
                        html += "<td><input type = 'button' value = '修改' onclick='upd(" + u.id + ")'/></td>"
                        html += "</tr>"
                    }
                    $("#tbd").html(html);
                    pageHtml += "<input type = 'button' value = '上一页' onclick = page(0," + data.data.pages + ")>"
                    pageHtml += "<input type = 'button' value = '下一页' onclick = page(1," + data.data.pages + ")>"
                    $("#pageDiv").html(pageHtml);
                });
        }

        //分页
        function page(s, pages) {
            var pa = $("#page").val();
            if (s == 0) {
                if ((parseInt(pa) - 1) < 1) {
                    alert('已到首页');
                    return;
                }
                $("#page").val(parseInt(pa) - 1);
            }
            if (s == 1) {
                if (parseInt(pa) + 1 > pages) {
                    alert('没有下一页了');
                    return;
                }
                $("#page").val(parseInt(pa) + 1);
            }
            show();
        }

        function add() {
            location.href = "<%=request.getContextPath()%>/user/toAdd";
        }

        function adds() {
            location.href = "<%=request.getContextPath()%>/user/toAdds";
        }

        function upd(id) {
            location.href = "<%=request.getContextPath()%>/user/toUpdate/" + id;
        }

        function del(id) {
            $.post("<%=request.getContextPath()%>/user/delete/" + id,
                function (data) {
                    if (data.code != 200) {
                        alert(data.msg);
                        return;
                    }
                    location.href = "<%=request.getContextPath()%>/show.jsp";
                });
        }

        function dels() {
            var ids = selec();
            if (ids.length < 1) {
                alert("请至少选择一个进行删除");
                return;
            }
            $.post("<%=request.getContextPath()%>/user/deleteIds/" + ids,
                function (data) {
                    if (data.code != 200) {
                        alert(data.msg)
                        return;
                    }
                    alert("删除成功")
                    location.href = "<%=request.getContextPath()%>/show.jsp";
                })
        }
    </script>
</head>
<body>
<input type="button" value="新增" onclick="add()">
<input type="button" value="批量新增" onclick="adds()">
<input type="button" value="批量删除" onclick="dels()"/>
<form id="fm">
    <input type="hidden" value='1' name="pageNo" id="page"/>
    男<input type="radio" name="userSex" value="1"/>
    女<input type="radio" name="userSex" value="2"/><br/>
    根据用户名查询<input type="text" name="userName"/><br/>
    根据爱好查询

    足球<input type="checkbox" name="userHobby" value="1">
    篮球<input type="checkbox" name="userHobby" value="2">
    棒球<input type="checkbox" name="userHobby" value="3">
    <input type="button" value="查询" onclick="show()"/>
</form>
<table>
    <tr>
        <th>id</th>
        <th>用户名</th>
        <th>密码</th>
        <th>年龄</th>
        <th>性别</th>
        <th>手机号</th>
        <th>邮箱</th>
        <th>爱好</th>
        <th>操作</th>
    </tr>
    <tbody id="tbd">

    </tbody>
</table>
<div id="pageDiv"></div>
</body>
</html>
