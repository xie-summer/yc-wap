<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/5
  Time: 下午12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String jump = (String) request.getAttribute("jump");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="safe.checkphone.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>

</head>
<body>
    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:"><i class="icon iconfont left" id="leftRe">&#xe626;</i></a>
            <li><spring:message code="safe.checkphone.title"/></li>
        </ul>

    </nav>

    <!--订单内容-->
    <section class="index-wrapper ">
        <div class="set-password">
            <div class="set-phone">
                <p><spring:message code="safe.checkphone.psd_p"/></p>
                <p class="word" id="phone">138****1234</p>
            </div>
            <div class="set-int">
                <ul>
                    <li>
                        <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="safe.checkphone.small_input"/>"></p>
                        <p class="yzm"><input id="getnumber" onclick="getnumberonclick()" type="button" class="btn bnt-yzm" value="<spring:message code="safe.checkphone.yzm_input"/>"></p>
                        <label id="phonetips"><spring:message code="safe.checkphone.code_label"/></label>
                    </li>
                    <li><a class="btn submit-btn btn-blue" href="#" onclick="confirmBtn()"><spring:message code="safe.checkphone.nextbtn"/></a></li>
                </ul>
            </div>
        </div>
    </section>

    <!--底部-->
    <section class="footer-big">
        <section class="terminal">
            <ul>
                <li class="none">
                    <p><img src="<%=path%>/ui/images/icon-1.png"/></p>

                    <p><spring:message code="all.project.public.icon-1"/></p>
                </li>
                <li class="tow current">
                    <p><img src="<%=path%>/ui/images/icon-2.png"/></p>

                    <p><spring:message code="all.project.public.icon-2"/></p>
                </li>
                <li class="three none-ml">
                    <p><img src="<%=path%>/ui/images/icon-3.png"/></p>

                    <p><spring:message code="all.project.public.icon-3"/></p>
                </li>
            </ul>
        </section>
        <footer class="footer">
            <ul>
                <li><a hrel="#"><spring:message code="all.project.public.footer.about"/></a>|<a hrel="#"><spring:message code="all.project.public.footer.find"/></a>|<a hrel="#"><spring:message code="all.project.public.footer.idea"/></a>|<a hrel="#"><spring:message code="all.project.public.footer.language"/></a></li>
                <li class="ash"><spring:message code="all.project.public.footer.title"/></li>
            </ul>
        </footer>
    </section>
</body>
</html>
<script>
    $(document).ready(function() {
        $("#leftRe").click(function() {
            window.history.go(-1);
        });
    });
    function confirmBtn() {
//        校验验证码为空
        var code = $("#codeid").val();
        if (code == "" || code == null){
            $("#phonetips").html("请输入短信验证码");
            $("#phonetips").css("display","block");
            return;
        }else {
            $("#phonetips").css("display","none");
        }

        //跳转
        var s = "${jump}";
        if (s=="psd"){
            var tourl = "<%=path%>/safe/installpsd";
            window.location.href=tourl;
        }else if(s == "mail") {
            var tourl = "<%=path%>/safe/changemail?mailTitle=<spring:message code="safe.checkphone.change_jump"/>";
            window.location.href=tourl;
        }else if(s == "phone") {
            var tourl = "<%=path%>/safe/changephone?phoneTitle=<spring:message code="safe.checkphone.change_jump"/>";
            window.location.href=tourl;
        }

    }
    function getnumberonclick(){
//        var phone = $("#phone");
//        getTestCode("123123123");
        //倒计时
        countDown(60);
    }
    function getTestCode(phone) {

        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {
                telPhone: phone
            },
            success: function (data) {
                if (data.status == 1) {
                    if (data.result == "true") {
                        $("#phonetips").html("请验证码发送成功");
                        $("#phonetips").css("display", "block");
                        countDown(60);
                    } else {
                        $("#phonetips").html("短信验证码错误");
                        $("#phonetips").css("display", "block");
                    }
                } else {
                    $("#phonetips").html("短信验证码错误");
                    $("#phonetips").css("display", "block");
                }
            },
            error: function () {
                $("#phonetips").html("网络请求超时，请稍候再试");
                $("#phonetips").css("display", "block");
            }
        });
    }
    var wait = 60;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").val("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
//            $("#getnumber").attr("class","");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        }else {
            var txtStr = '重新获取(' + wait + ')';
            $("#getnumber").val(txtStr);
//            $("#getnumber").attr("class","ash-cl");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }
</script>