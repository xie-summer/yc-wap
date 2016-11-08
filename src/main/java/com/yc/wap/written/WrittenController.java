package com.yc.wap.written;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.common.api.sysduad.interfaces.IQuerySysDuadSV;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListReq;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListRes;
import com.ai.yc.common.api.syspurpose.interfaces.IQuerySysPurposeSV;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Locale;

/**
 * Created by Nozomi on 11/3/2016.
 */
@Controller
@RequestMapping(value = "written")
public class WrittenController extends BaseController{
    private Log log = LogFactory.getLog(WrittenController.class);

    private IQuerySysDuadSV iQuerySysDuadSV = DubboConsumerFactory.getService(IQuerySysDuadSV.class);
    private IQuerySysPurposeSV iQuerySysPurposeSV = DubboConsumerFactory.getService(IQuerySysPurposeSV.class);

    @RequestMapping(value = "")
    public String content() {
        log.info("WrittenControllerInvoked");
        Locale local = rb.getDefaultLocale();
        String country = local.getCountry();
        List DualList = GetDualList(country, Constants.OrderType.DOC);
        return "written/content";
    }

    public List GetDualList(String country, String OrderType) {
        QuerySysDuadListReq req = new QuerySysDuadListReq();
        req.setLanguage(country);
        req.setOrderType(OrderType);
        QuerySysDuadListRes resp = iQuerySysDuadSV.querySysDuadList(req);
        log.info("Get DualList Return: " + resp.getDuads().toString());
        return resp.getDuads();
    }


    @RequestMapping(value = "onContentSubmit")
    @ResponseBody
    public Object onContentSubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "contact")
    public String contact() {
        return "written/contact";
    }

    @RequestMapping(value = "confirm")
    public String confirm() {
        return "written/confirm";
    }

    @RequestMapping(value = "onConfirmSubmit")
    @ResponseBody
    public Object onConfirmSubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "newContact")
    public String newContact() {
        return "written/newcontact";
    }

    @RequestMapping(value = "onNewContactSubmit")
    @ResponseBody
    public Object onNewContactSubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "payment")
    public String payment() {
        return "written/payment";
    }
}
