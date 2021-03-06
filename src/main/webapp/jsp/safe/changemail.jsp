<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/4
  Time: 下午5:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String mailTitle = (String) request.getAttribute("mailTitle");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="safe.changemail.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
    <div class="wrapper-big"><!--包含除底部外的所有层-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:"><i class="icon iconfont left" id="leftRe">&#xe626;</i></a>
                <li>${mailTitle}<spring:message code="safe.changemail.navli"/></li>
            </ul>

        </nav>
        <!--订单内容-->
        <section class="index-wrapper ">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="mail" type="text" class="input input-large" placeholder="<spring:message code="safe.changemail.navli"/>"></p>
                            <label id="mailLabel"></label>
                        </li>
                        <li>
                            <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="safe.changemail.small_input"/>" autocomplete="off"></p>

                            <p class="yzm"><a id="getnumber" onclick="javascript:getnumberonclick()" class="btn bnt-yzm"><spring:message code="safe.changemail.bntyzm_input"/></a></p>
                            <label id="phonetips"></label>
                        </li>
                        <li><a class="btn submit-btn btn-blue" href="javascript:void(0)" onclick="confirmBtn()"><spring:message code="safe.changemail.nextbtn"/></a></li>
                    </ul>
                </div>
            </div>
        </section>
    </div>

    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

    <%--loading--%>
    <jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function() {
        $("#codeid").val("");
        $("#getnumber").attr("class","btn bnt-yzm");
        $("#getnumber").removeAttr("disabled");
        $("#getnumber").attr("onclick", "getnumberonclick()");
        $("#getnumber").html("<spring:message code="safe.changemail.yzm_input"/>");//改变按钮中value的值

        $("#leftRe").click(function() {
            window.history.go(-1);
        });
        Loading.HideLoading();
    });
    function confirmBtn() {
        var mail = $("#mail").val();
        if (mail == "" || mail == null){
            $("#mailLabel").html("<spring:message code="safe.changemail.shuruyouxiang"/>");
            $("#mailLabel").css("display","block");
            return;
        }else {
            $("#mailLabel").css("display","none");
        }
        var t = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if (!t.test(mail)){
            $("#mailLabel").html("<spring:message code="safe.changemail.rightMail"/>");
            $("#mailLabel").css("display","block");
            return;
        }else {
            $("#mailLabel").css("display","none");
        }
        var code = $("#codeid").val();
        if (code == "" || code == null){
            $("#phonetips").html("<spring:message code="safe.changemail.mailCode"/>");
            $("#phonetips").css("display","block");
            return;
        }else {
            $("#phonetips").css("display","none");
        }
        Loading.ShowLoading();
        checkMail(mail,code);


    }
    function checkMail(mail,code){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/editmail",
            modal: true,
            timeout: 30000,
            data: {
                uid: "${UID}",
                code:code,
                mail:mail
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    var tourl = "<%=path%>/safe/safesuccess?name=<spring:message code="safe.changemail.bangdingmail"/>";
                    window.location.href=tourl;
                    Loading.HideLoading();
                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");
                    $("#mail").attr("disabled",false);
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#phonetips").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#phonetips").css("display", "block");
                $("#mail").attr("disabled",false);
                Loading.HideLoading();
            }
        });
    }
    function getnumberonclick(){
        var mail = $("#mail").val();
        if (mail == "" || mail == null){
            $("#mailLabel").html("<spring:message code="safe.changemail.shuruyouxiang"/>");
            $("#mailLabel").css("display","block");
            return;
        }else {
            $("#mailLabel").css("display","none");
        }
        var t = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if (!t.test(mail)){
            $("#mailLabel").html("<spring:message code="safe.changemail.rightMail"/>");
            $("#mailLabel").css("display","block");
            return;
        }else {
            $("#mailLabel").css("display","none");
        }
        Loading.ShowLoading();
        checkAvailable(mail);

    }
    //检测是否可用
    function checkAvailable(mail){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkPhoneOrEmail",
            modal: true,
            timeout: 30000,
            data: {
                checkType: "mail",
                checkVal:mail,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#mailLabel").css("display", "none");
                    getTestCode(mail);
                } else {
                    $("#mailLabel").html(data.msg);
                    $("#mailLabel").css("display", "block");
                    Loading.HideLoading();
                }
            },
            error: function () {

                $("#mailLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#mailLabel").css("display", "block");
                Loading.HideLoading();
            }
        });
    }
    //    发送验证码
    function getTestCode(mail) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 5,
                info:mail,
                uid:"${UID}"
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    $("#mail").attr("disabled","true");
                    wait = 120;
                    countDown();
                    Loading.HideLoading();
                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");

                    Loading.HideLoading();
                }
            },
            error: function () {

                $("#phonetips").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#phonetips").css("display", "block");
                Loading.HideLoading();
            }
        });
    }
    //    倒计时
    var wait = 120;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("<spring:message code="safe.changemail.yzm_input"/>");//改变按钮中value的值
            $("#getnumber").attr("class","btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 120;
        }else {
            <%--var txtStr = '<spring:message code="safe.changemail.chongxinhuoqu"/>(' + wait + ')';--%>
            var txtStr = wait+ '<spring:message code="safe.changemail.chongxinhuoqu"/>';
            $("#getnumber").html(txtStr);
            $("#getnumber").attr("class","btn bnt-yzm-gray");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }
</script>