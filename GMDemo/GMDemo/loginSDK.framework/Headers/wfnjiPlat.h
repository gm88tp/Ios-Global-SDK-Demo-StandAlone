//
//  wfnjiPlat.h
//
//  Created by wfnji on 16/8/15.
//  Copyright © 2016年 wfnji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wfnjiUserInfo.h"
#import "wfnjiLoginCallBack.h"
#import "wfnjiOrderModel.h"
#import "wfnjiPayCallBack.h"

/**
 游戏接入用到接口类
 */
@interface wfnjiPlat : NSObject

/*!
 单例,预留接口
 
 @return wfnjiPlat
 */
+(wfnjiPlat*)getInstance;

/**
 AppDelegate.h内的接口,主要用去.后台返回用
 
 @param application application
 */
+(void)applicationWillEnterForeground:(UIApplication *)application;

/**
 AppDelegate.h内的接口, 游戏从后台返回用
 
 
 */
+(void)applicationDidEnterBackground:(UIApplication *)application ;

/*
 
 要针对所有广告系列（包括使用通用链接的广告系列）将应用内事件作为转化衡量，
 您必须将以下代码段添加到应用的 application:continueUserActivity:restorationHandler 方法。
 */
+ (BOOL)application:(UIApplication *)application  continueUserActivity:(NSUserActivity *)userActivity;

/**
 AppDelegate.
 
 @param app app
 @param url url
 @param options options
 @return BOOL
 */
+(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;

/**
 AppDelegate.h内的接口
 
 @param application application
 @param url url
 @param sourceApplication sourceApplication
 @param annotation annotation
 @return BOOL
 */
+(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


/**
 AppDelegate.h内的接口
 
 @param app application
  需要调用一些事件激活
 */
+ (void)applicationDidBecomeActive:(UIApplication *)app;



/**
 必须最先接入的方法  平台初始化方法
老版本使用
gameid 游戏的id
 promote 渠道
 
 */
/* 废弃
 + (void) initSDK:(NSString*)gameid
      setPromote:(NSString*)promote
     application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 appsFlyerDevKey:(NSString *)devKey
      appleAppID:(NSString *)appID
     GGkClientID:(NSString *)kClientID
         Applede:(id) app  ;*/

/**
 必须最先接入的方法  平台初始化方法
 */
+ (void) initSDKapplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    Applede:(id) app;

/**
 必须接入的方法  登录
 
 @param mLoginCallBack 回调
 */
+ (void) login:(id<wfnjiLoginCallBack>)mLoginCallBack;


 

/**
 查看当前的登录状态
 
 @return true or false
 */
+ (BOOL) isLogin;

/**
 注销账号
 */
+ (void) logout;


/**
 获取用户信息
 
 @return 用户信息
 */
+(wfnjiUserInfo*)getUserInfo;

/**
 获取游戏用户的唯一ID
 
 @return uid
 */
+ (NSString*) getUid;


/**
 获取用户名
 
 @return Nickname
 */
+ (NSString*) getNickname;

/**
 获取Token
 
 @return Token
 */
+ (NSString*) getToken;


/**
 游戏中调用返回提示，部分SDK需要调用SDK的退出提示，暂时没用,预留接口
 */
+ (void) quit;

/**
 获取当前 SDK 的版本号
 
 @return SDK 版本号，
 */
+(NSString*)versions;

/**
 
 获取当前游戏的角色
 @param name     角色名字
 @param level    游戏等级
 @param serverID 区服
 @param status 状态值默认选择<3>: 1:创建角色 2:完成新手引导 3:等级升级 4：进入游戏
 @param vipLevel 游戏内角色vip等级
 */
+ (void)wfnjiRoleName:(NSString *)name
            gameLevel:(NSString *)level
             serverID:(NSString *)serverID
               roleID:(NSString *)roleID
               status:(NSString *)status
             vipLevel:(NSString *)vipLevel;

 


/**
 获取多语言
 调用此接口可以直接获取SDK资源文件中的多语言
 @param str 多语言文件中的key
 @return 该key的多语言文案
 */
+ (NSString *)setlaugulgString:(NSString *)str;


/**
 获取配置信息
 @param str  传入infoset.plist中的参数key
 @return 该参数的值
 */
+ (NSString*)getInfoString:(NSString*)str;


/*
 注册Google广告测试设备
 */
+(void)regisetAdGoogleDevice:(NSArray*)arr;


/*
加载等待loading页面
style 1 至 5
 */
+ (void)setLoadingImg:(UIImage *)image
                Color:(UIColor *)color
         loadingStyle:(NSInteger )style
              imgRect:(CGRect)rec;

/*
移除loading页面
 */
+ (void)removeLoadingImg;



+ (void)setCheckoutV:(int )status
         checkoutStr:(NSString * )str
        detaileTitle:(NSString *)detaileTitle;


+ (void)removeCheckoutVU;

/**
 数据打点方法
 @param eventName 事件名称
 @param info      参数，没有可传空
 */
+ (void)LogInfo:(NSString *)eventName EventDic:(NSDictionary *)info;


/**
 分享使用的方法
 
 @param sharename 分享名
 @param shareID 分享ID
 @param share_uname 角色名
 @param share_server 角色区服
 @param share_code 角色code

 */
+ (void)ShareInfoName:(NSString *)sharename
                  ShareInfoID:(NSString *)shareID
                   shareUname:(NSString *)share_uname
                  shareServer:(NSString *)share_server
                   shareCode :(NSString *)share_code;

/**
 分享使用的方法
 
 @param text 分享文本
 @param image 图片列表，可以传空，传一张
 @param link 分享链接
 @param type 分享类型：1 引文分享（链接），2 图片分享,3 使用SDK后台配置分享
 @param info SDK后台配置分享，需要传入参数格式如下：
            @{@"shareName":@"分享名称",
                @"shareID":@"分享ID",
             @"shareUName":@"角色名",
            @"shareServer":@"角色区服",
              @"shareCode":@"角色code"
 
             }
 */
+ (void)shareInfo:(NSString *)text image:(UIImage *)image link:(NSString *)link type:(NSString *)type otherInfo:(NSDictionary *)info;


/**
 返回渠道号
 */
+ (NSString *)returnChannelID;


/**
 调用广告
 @param type 0：激励广告；1：插页广告；2：横幅广告
 */
+ (void)choseADPlatForm:(NSInteger)type;


/**
 显示评价
 */
+ (void)showMarkView;



+ (void)showWinLog;

/*
 广告 ，分享 ，绑定 使用一个通知
 通知名：SDKCenterNotifition
 返回参数：status  0 广告失败
                 1 广告成功
                 2 分享失败
                 3 分享成功
                 4 绑定失败
                 5 绑定成功
                 6 未绑定
                 7 已绑定
                 8 绑定取消
                 9 取消广告
                 10 返回product多语言
                 11 返回product多语言失败
                 12 返回翻译
                 13 vip客服不显示
                 14 vip客服可显示
                 15 VIP客服关闭

 */


// 推送相关
+ (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken ;

// 推送相关
+ (void)application:(UIApplication *)application  didReceiveRemoteNotification:(NSDictionary *)userInfo;


/**
 弹出文字
 @param text 需要弹出的文案
 */
+ (void)toastInfo:(NSString *)text ;


/**
 返回设备号
 */
+ (NSString *) returnIDFV;

/**
 返回广告ID
 */
+ (NSString *) returnIDFA;


+ (NSString *)returnIDFVNomal;

/**
 返回时区
 */
+ (NSString *)returnTimeZome ;

/**
 返回语言码
 */
+ (NSString *)returnLanguageCode;

/**
 翻译
 @param text 需要翻译的文案
 @param identifier 文本标识符（透传字段）
 */
+ (void)translateText:(NSString *)text identifier:(NSString *)identifier;

/**
 返回当前的window
 */
+ (UIWindow *)currentWindow;

/**
 打开社交平台方法一
 @param code 2 Facebook,3 lobi,4 应用商店
 @param info 链接地址/包名/应用ID (无参数默认给个空字符)
 @param pageid 粉丝页ID(无参数默认给个空字符)
 */
+ (void) toastplatformCode:(NSString *)code Info:(NSString *)info  pageID:(NSString *)pageid;

/**
 打开社交平台方法二
 @param type 1：评价商店；2：三方平台+浏览器
 */
+ (void)showMarkViewType:(NSInteger)type;


/**
 广告剩余显示次数
 @param str 次数，没有限制可不用调用此方法
 */
+ (void)ADCounts:(NSString *)str;

/**
 客服入口
 */
+ (void)showCustomView;

/**
 获取内购列表
 */
+ (void)setPurchaseInfo;

/**
 支付
 @param payInfo 支付信息（wfnjiOrderModel类型对象）
 @param callBack 回调，设置代理
 */
+ (void) wfnjipay:(wfnjiOrderModel *)payInfo CallBack:(id<wfnjiPayCallBack>) callBack;

/**
 vip客服
 */
+ (void)VIPCustomService;

/**
 是否可以显示vip
 */
+ (void)isCanVip;

/**
 常见问题入口
 */
+ (void)showFAQView;

/**
 打开入口
 @param str 链接
 */
+ (void)showViewWithStr:(NSString *)str;

@end

