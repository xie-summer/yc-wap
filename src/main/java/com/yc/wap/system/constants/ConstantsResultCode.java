package com.yc.wap.system.constants;

/**
 * Created by Nozomi on 11/8/2016.
 */
public class ConstantsResultCode {
    public static final String SUCCESS = "000000";
    public static final String NODATA = "000001";//成功，但是无数据
    public static final String NULL = "888888";//参数有null
    public static final String ERROR = "999999";//后场服务系统错误
    public static final String CUST_HAVED = "101003";//后场服务系统错误
    public static final String CUST_NOTFOUND = "101000";//客户不存在
    public static final String USER_OWNFEE = "108006";//用户欠费
    public static final String SERVERPHONE_NOTFOUND = "102003";
    public static final String CUST_INFO_NOTFOUND = "101001";
    public static final String ACCT_INFO_NOTFOUND = "101010";
    public static final String WEIXIN_SUCCESS = "SUCCESS";
    public static final String WEIXIN_FAILDE = "FAILED";

    public static final String NOACCOUNT = "0001";//账户没有账本
    public static final String FUNDSUCCESS = "0000";

    public static final String PAYSUCCESS = "success";
    public static final String INSUFFICIENT = "300002";//余额不足
    public static final String NOACCOUNTS = "100001";//账户不存在
    public static final String NOACCOUNTBOOK = "300001";//账本不存在
    public static final String NOPASSWORD = "000005";//没有输入密码
    public static final String WRONGPASSWORD = "000006";//密码错误
    public static final String SETPASSWORD = "000007";//没有设置支付密码
}
