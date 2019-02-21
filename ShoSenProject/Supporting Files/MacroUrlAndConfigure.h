//
//  MacroUrlAndConfigure.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#ifndef MacroUrlAndConfigure_h
#define MacroUrlAndConfigure_h



#define BaseUrl     @"https://39.104.62.133:8092"
#define OrderBaseUrl     @"http://39.104.62.133:9527"

//#define BaseUrl     @"http://192.168.1.203:8080"
//#define OrderBaseUrl     @"http://192.168.1.203:8080"


#define LoginUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/login/validate"]
#define LoginCodeUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/login/code"]
#define UserBookUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/book"]
#define UserBookDetailUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/bookDetail"]
#define UserBookListUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/bookList"]
#define UserBookCancelUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/cancelBook"]
#define UserBookDeleteUrl    [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/delBook"]
#define BaseConfigUrl          [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/configBean"]
#define BaseRemainOwner         [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/remainOwner"]
#define BaseDictionary  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/dictionary"]
#define UserInfoUpdateUrl  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/editUser"]
#define UserAlipayBookUrl [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/appAliPayBook"]
#define UserWechatBookUrl [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/appWxPayBook"]
#define UserInfoUrl [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/selectUserByPhone"]
#define UserLogout  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/login/logout"]
#define UserRewardList  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/rewardList"]
#define UserRewardTotal  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/rewardTotal"]
#define UserUpdateAddInfo  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/selectUserByPhone"]
#define UserBindWechatUrl  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/weChat/register"]
#define UserLoginWechatUrl  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/weChat/login"]
#define UserLoginWechatBindUrl  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/weChat/loginRegister"]

#define UserRewardList  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/rewardList"]
#define UserRewardTotal  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/rewardTotal"]
#define UserWechaUnlock  [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/weChatUnLock"]
#define UserCircleMessageList [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/selectMess"]//消息列表
#define UserCircleMessageComm [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/selectComm"]//评论列表
#define UserCircleAddComment [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/addComment"]//添加平路
#define UserCircleDelComment [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/delComment"]//删除评论
#define UserCircleDelMess [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/delMess"]//删除朋友圈消息
#define UserCircleAddMess [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/addMess"]//发布朋友圈消息
#define UserCircleFollowList [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/followList"]//关注列表
#define UserCircleDelFollow [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/delFollow"]//取消关注
#define UserCircleAddFollow [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/addFollow"]//取消关注
#define UserCircleUploadImageView [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/upload"]//上传图片
#define UserCircleUploadImageViewArray [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/uploadFiles"]//上传多张图片

#define UserCircleGetCountByUserId [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/getCountByUserId"]//获取圈子的个人信息
#define UserCircleFriendInvitation [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/friendInvi"]//好友的推荐列表
#define UserCircleSlefFollow [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/selfFollow"]//个人关注列表
#define UserCircleSlefMessage [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/selfMess"]//个人消息列表
#define UserCircleHotTop [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/hotTop"]//热门话题
#define UserCircleBannerList [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/bannerList"]//轮播图列表
#define UserCircleUpdateCommentMark [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/updateCommentMark"]//评论点赞
#define UserCircleUpdateMessMark [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/updateMessMark"]//朋友圈点赞
#define UserCircleMyReMesss [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/myReMesss"]//我的消息列表
#define UserCircleMoreFollow [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/moreFollow"]//更多关注
#define UserCircleReportAndBlacklist [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/defriendAndComplain"]//举报拉黑
#define UserCircleCancelBlacklist [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/cancelDefriend"]//取消拉黑
#define UserCircleSelectFans [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/selectFans"]//粉丝列表
#define UserCircleNoticeMess [NSString stringWithFormat:@"%@%@",BaseUrl,@"/circle/noticeMess"]//消息通知列表
#define UserBaseSignLogin [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/signLogin"]//签到
#define UserBaseSubjectAns [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/subjectAns"]//问卷调查
#define UserBaseNewss [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/news"]//咨询列表

#define UserBaseDictionary [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/dictionary"]//获奖列表
#define UserGameRewardList [NSString stringWithFormat:@"%@%@",BaseUrl,@"/game/rewardList"]//我的奖品列表
#define UserGamerewardRecord [NSString stringWithFormat:@"%@%@",BaseUrl,@"/game/rewardRecord"]//中奖名单接
#define UserLocationData [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/posiKeyVal"]//位置信息
#define SendMessageCode [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/posiSms"]//发送位置信息
#define LoveChariSum [NSString stringWithFormat:@"%@%@",BaseUrl,@"/chari/sum"]//慈善总额
#define LoveDetailList [NSString stringWithFormat:@"%@%@",BaseUrl,@"/book/charitable"]//慈善总额

#define kShopGoodsListUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/home/index"] //商品列表
#define kShopGoodsDetailUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/goods/detail"] //商品详情
#define kShopCarGoodsNumUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/goodscount"] //购物车数量
#define kShopAddCarUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/add"] //购物车数量
#define kShopCarUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/index"] //购物车
#define kShopCartUpdateUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/update"] //购物车加减号/wx/cart/update
#define kShopCartDeleteUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/delete"] //删除
#define kShopLocationListUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/address/list"] //地址列表
#define kShopAddLocationUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/address/save"] //新增修改地址
#define kShopDeleteLocationUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/address/delete"] //删除地址
#define kShopBuyUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/checkout"] //立即购买、去结算
#define kShopSubmitOrderUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/submit"] //新增修改地址
#define kShopCartCheckedrUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/checked"] //预下单
#define kShopOrderSubmitUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/submit"] //生成订单
#define kShopOrderListUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/list"] //订单列表
#define kSearchShopOrderListUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/findList"] //搜查订单列表
#define kShopcCancelOrdeUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/cancel"] //取消订单
#define kShopcOrderDetailUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/detail"] //订单详情
#define kShopcOrderConfirmReceiveUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/confirm"] //确认收货
#define kShopcOrderDeleteUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/delete"] //删除订单
#define kShopFastAddUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/cart/fastadd"] //立即购买
#define kShopPayOrderUrl [NSString stringWithFormat:@"%@%@",OrderBaseUrl,@"/wx/order/prepay"] //下单


#define kMoneyListUrl [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/moneyList"] //余额明细列表
#define kXProListUrl [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/xProList"] //积分明细列表
#define kBuyCarYesOrNo [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/isBookPay"] //是否购买过车辆
#define kActiveBBS [NSString stringWithFormat:@"%@%@",BaseUrl,@"/base/socialPass"] //是否激活社区
#define kChangePassword [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/updatePass"] //更新平台管理密码
#define kChargeMoney [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/charge"] //充值
#define kAliReChargeMoney [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/aliPayCharge"] //支付宝充值
#define kWechatReChargeMoney [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/wxPayCharge"] //微信充值



#define KConfigNoticeKey @"ConfigNotice"
#define KConfigRemainNumKey @"ConfigRemainNum"
#define KIsReview @"isReview"
#define KLocationData @"LocationData"
#define cellContentHeight 140
#define KrefreshFinder @"REFRESHFINDER"
#define KrefreshCircle @"REFRESHCIRCLE"




static  NSString * const UMengKey = @"5bbc7844f1f5564f9e000075";
//ShareSDK
static NSString *const kShareSDKAppKey = @"1afc5dbca127b";
static NSString *const kSaareSDKSecret =@"5bfaa12b4aa99b6c3399d9fb42365505";
//Bugly
static NSString *const  kBuglyKey = @"50234d22f3";
//JPush
static NSString *const  kPushAppKey = @"79446fb98e29ac9cb5fbd8ee";
static NSString *const  kPushChannel = @"appStore";
static NSString *const  kPushProduction = @"0";
//微博
static NSString *kWeiboAppKey = @"1356884224";
static NSString *kWeiboAppSecret = @"be014d0579f01766a146f65cffe404f9";
static NSString *kWeiboResirectURI = @"http://m.qschou.com/page/aid?from=app";
// 微信 真实的
static NSString *kWechatAppID = @"wx482945bce5f90e1b";
static NSString *kXiaoChengXuAppID = @"wx9c2fc0f1871851d1";
static NSString *kWechatAppSecret = @"c77f05ea6aadcb1833f2adb7e1ffe271";
//支付宝
static NSString *kAlipaySchemes = @"zhifubao2018012602082501";
//QQ开放平台
static NSString *kQQConnectAppKey = @"1105311506";
static NSString *kQQConnectAppSecret = @"a4KttsALp5yqNEji";
//JSPatch
static NSString *KJSPatchAppKey = @"91c064e59a6d59fa";

//#else  /*! 线上环境APPKey */
//
////友盟统计
//static  NSString * const UMengKey = @"5bbc7844f1f5564f9e000075";
////ShareSDK
//static NSString *const kShareSDKAppKey = @"1afc5dbca127b";
//static NSString *const kSaareSDKSecret =@"5bfaa12b4aa99b6c3399d9fb42365505";
////Bugly
//static NSString *const  kBuglyKey = @"9145c0a0ab";
////JPush   线上 ：64bf653603c2241f474b148f
//static NSString *const  kPushAppKey = @"64bf653603c2241f474b148f";
//static NSString *const  kPushChannel = @"appStore";
//static NSString *const  kPushProduction = @"0";
////微博
//static NSString *kWeiboAppKey = @"1356884224";
//static NSString *kWeiboAppSecret = @"be014d0579f01766a146f65cffe404f9";
//static NSString *kWeiboResirectURI = @"http://m.qschou.com/page/aid?from=app";
//// 微信 真实的
//static NSString *kWechatAppID = @"wx482945bce5f90e1b";
//static NSString *kWechatAppSecret = @"c77f05ea6aadcb1833f2adb7e1ffe271";
////QQ开放平台
//static NSString *kQQConnectAppKey = @"1105311506";
//static NSString *kQQConnectAppSecret = @"a4KttsALp5yqNEji";
////JSPatch
//static NSString *KJSPatchAppKey = @"91c064e59a6d59fa";
////支付宝
//static NSString *kAlipaySchemes = @"2018012602082501";
//#endif


#endif /* MacroUrlAndConfigure_h */
