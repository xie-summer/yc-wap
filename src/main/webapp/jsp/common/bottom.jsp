<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/8/2016
  Time: 7:41 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@page import="java.util.regex.Matcher" %>
<%@page import="java.util.regex.Pattern" %>
<%@ page import="com.ai.paas.ipaas.i18n.ResWebBundle" %>
<%!
    private String androidReg = "\\bandroid|Nexus\\b";
    private String iosReg = "ip(hone|od|ad)";

    private Pattern androidPat = Pattern.compile(androidReg, Pattern.CASE_INSENSITIVE);
    private Pattern iosPat = Pattern.compile(iosReg, Pattern.CASE_INSENSITIVE);

    private boolean Android(String userAgent) {
        if (null == userAgent) {
            userAgent = "";
        }
        Matcher matcherAndroid = androidPat.matcher(userAgent);
        return matcherAndroid.find();
    }

    private boolean IOS(String userAgent) {
        if (null == userAgent) {
            userAgent = "";
        }
        Matcher matcherIOS = iosPat.matcher(userAgent);
        return matcherIOS.find();
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String userAgent = request.getHeader("USER-AGENT").toLowerCase();
    String AppUrl;
    String Classes = request.getParameter("class");
    System.out.println("userAgent: " + userAgent);

    if (IOS(userAgent)) {
        AppUrl = "https://itunes.apple.com/cn/app/zhao-fan-yi-findyee/id1017302386?mt=8";
        request.setAttribute("uploadShow", "none");
    } else {
        AppUrl = "http://android.myapp.com/myapp/detail.htm?apkName=cn.com.gtcom.ydt";
        request.setAttribute("uploadShow", "show");
    }

    if (Classes != null && !Classes.equals("")) {
        request.setAttribute("Classes", Classes);
    } else {
        request.setAttribute("Classes", "footer-big");
    }
    request.setAttribute("AppUrl", AppUrl);
    request.setAttribute("WapUrl", "http://m.yeecloud.com");
    request.setAttribute("PcUrl", "http://www.yeecloud.com/");
    ResWebBundle rb = new ResWebBundle();
    System.out.print("DefaultLocale: " + rb.getDefaultLocale().toString());
%>
<html>
<head>
</head>
<body>
<section id="_bottom" class="${Classes}">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" onclick="window.location.href='${AppUrl}'"/></p>
                <p><spring:message code="all.project.public.icon-1"/></p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" onclick="window.location.href='${WapUrl}'"/></p>
                <p><spring:message code="all.project.public.icon-2"/></p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" onclick="window.location.href='${PcUrl}'"/></p>
                <p><spring:message code="all.project.public.icon-3"/></p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a href="javascript:window.location.href='<%=path%>/aboutus'"><spring:message
                    code="all.project.public.footer.about"/></a>|
                <a href="javascript:window.location.href='<%=path%>/tident'"><spring:message
                        code="all.project.public.footer.find"/></a>|
                <a href="javascript:window.location.href='<%=path%>/feedback'"><spring:message
                        code="all.project.public.footer.idea"/></a>|
                <a href="javascript:void(0)"
                   onclick="if('<%=rb.getDefaultLocale().toString()%>' == 'en_US'){changeLang('zh_CN')}else {changeLang('en_US')}"><spring:message
                        code="all.project.public.footer.language"/></a></li>
            <li class="ash"><spring:message code="all.project.public.footer.title"/></li>
            <%--若多语言不可用，就改控制器进入jsp--%>
            <li class="ash">京ICP备13002826号-7</li>
        </ul>
    </footer>
</section>
</body>
</html>
<script>
    $(function () {
        console.log("${rb.getDefaultLocale()}");
    })
    function changeLang(localeEl) {
        // var toLang = localeEl.value;
        var toLang = localeEl;
        if (window.console) {
            console.log("the new lange is " + toLang);
        }
        var nowUrl = window.location.href;
        var lInd = nowUrl.indexOf("lang=");
        //已存在
        if (lInd > 0) {
            var i = nowUrl.indexOf("&", lInd);
            var endStr = i > 0 ? nowUrl.substring(i) : "";
            nowUrl = nowUrl.substring(0, lInd) + "lang=" + toLang + endStr;
        }//不存在
        else if (nowUrl.indexOf("?") > 0) {
            nowUrl = nowUrl + "&lang=" + toLang;
        } else {
            nowUrl = nowUrl + "?lang=" + toLang;
        }

        window.location.replace(nowUrl);//刷新当前页面
    }
</script>
