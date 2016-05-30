package com.newenv.lpzd.util;


public interface AppConstants {
	public static final String CURRENT_USER = "currentUser";
	
	/** Comma **/
	public static final String COMMA = ",";
	
	/** Semicolon **/
	public static final String SEMICOLON = ";";
	
	/** Semicolon **/
	public static final String COLON = ":";
	
	/** Blank space **/
	public static final String BLANK_SPACE = "  "; 
	
	/** underline **/
	public static final String UNDERLINE = "_"; 
	
	/** underline **/
	public static final String DOT = "."; 
	
	/** back slash space **/
	public static final String BACK_SLASH = "/";
	
	public static final String LEFT_PARENTHESIS = "(";
	
	public static final String RIGHT_PARENTHESIS = ")";
	
	public static final String QUESTION_MARK = "?";
	
	public static final String SINGLE_QUOTE = "'";
	
	public static final String COMMA_SINGLE_QUOTE = "','";
	
	/** status category **/
	public static final String STATUS_CATEGORY = "status_category";
	
	/** the category of date dictionary **/
	public static final String LOCALE_CATEGORY = "locale_category";
	
	/** active **/
	public static final String STATUS_CATEGORY_ACTIVE = "T";
	
	/** inactive **/
	public static final String STATUS_CATEGORY_INACTIVE = "F";
	
	public static final String SYNCHRONIZE_PERMISSION = "permission";
	
	public static final String SYNCHRONIZE_MESSAGE = "message";

	public static final String BMS_STATUS_CATEGORY_ACTIVE = "1";
	public static final String BMS_STATUS_CATEGORY_INACTIVE = "0";
	
	public static final String CURRENT_TITLE="CurrentTitle";
	public static final byte MENU_STATUS_ACTIVE=new Byte((byte)1);
	public static final byte MENU_STATUS_INACTIVE=new Byte((byte)0);

	public static final String VERIFY_CODE = "verifyCode";

	public static final String TITLE_THAT_CHECKS_BELOW_FRONT_SHOP = "76,78,82,83,84";
	
	public static final String APPLIANCE_ID="ApplianceID";
	public static final String BROWSER_VERSION = "Version";
	public static final String CLIENT_TYPE="ClientType";
	public static final String MAC="Mac";
	public static final String CLIENT_IP = "ClientIP";
	
	//Message actions
	public static final String GUEST_DISPATCH="分派";
	public static final String GUEST_RECOMMEND="推荐";
	public static final String GUEST_ACCEPT="接收";
	public static final String GUEST_JUSHOU="拒收";
	public static final String GUEST="客源";
	public static final String HOST="房源";
	public static final String HOST_DISPATCH="分派";
	public static final String HOST_AUTOLOCKS="自动解锁成功";
	public static final String HOST_AUTOLOCKF="自动解锁失败";
	public static final String HOST_RECOMMEND="推荐";
	public static final String HOST_CHANGE="转盘";
	public static final String HOST_FOLLOW="跟进提醒";
	public static final String HOST_HOUSE="房源无效";
	public static final String HOST_KEY="钥匙无效";
	public static final String HOST_SHOW="房勘无效";
	public static final String HOST_SOLE="独家无效";
	public static final String HOST_EXCLUSIVE="限时独家委托";
	public static final String REALTER_DICTIONARY = "楼盘字典库";
	public static final String REALTER_APPROVE = "审批通过";
	
	public static final String HOUSE_REALTER_APPROVE="房源审批通过";
	public static final String KEY_REALTER_APPROVE="钥匙审批通过";
	public static final String SOLE_REALTER_APPROVE="独家审批通过";
	public static final String SHOW_REALTER_APPROVE="房勘审批通过";
	
	public static final String REALTER_REJECT = "申请驳回";

	public static final String HOUSE_REALTER_REJECT="房源申请驳回";
	public static final String KEY_REALTER_REJECT="钥匙申请驳回";
	public static final String SOLE_REALTER_REJECT="独家申请驳回";
	public static final String SHOW_REALTER_REJECT="房勘申请驳回";
	
	public static final String REALTER_COLLECT_APPROVE = "采盘通过";

	public static final String REALTER_COLLECT_REJECT = "采盘驳回";
	
	public static final String HOUSE_EXCLUSIVE_DELEGATION_PASS = "限时独家委托审核通过";
    public static final String HOUSE_EXCLUSIVE_DELEGATION_REJECT = "限时独家委托审核驳回";
    public static final String HOUSE_EXCLUSIVE_DELEGATION_EXPIRING = "限时独家委托即将到期";
    
    public static final String HOUSE_FOCUS = "房源聚焦";
    public static final String HOUSE_CHECK = "房源审核";

	public static final boolean CHECK_VERIFY_CODE = true;
	public static final boolean USE_BROWSER_SHELL = true;

	public static final String BMS_LOG_BEAN = "BMSLOGBEAN";

	public static final String OPENID = "openId";
}
