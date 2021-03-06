//
//  ViewController.m
//  GMDemo
//
//  Created by rosehyird on 2020/4/29.
//  Copyright © 2020 rosehyird. All rights reserved.
//

#import "ViewController.h"
#import <loginSDK/wfnjiPlat.h>
@interface ViewController ()<wfnjiLoginCallBack,wfnjiPayCallBack>
@property (weak, nonatomic) IBOutlet UITextField *eventTF;
@property (weak, nonatomic) IBOutlet UITextField *textTF;
@property (weak, nonatomic) IBOutlet UILabel *translatedLb;
@property (weak, nonatomic) IBOutlet UILabel *loginInfoLB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置SDK 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifitionCenter:)  name:@"SDKCenterNotifition" object:nil];
}

- (void)notifitionCenter:(NSNotification *)notification {
    NSDictionary * Info = (NSDictionary *)notification.object;
       
    if([[Info objectForKey:@"status"] isEqualToString:@"0"]){
           //广告失败
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"9"]) {
           //取消广告
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"1"]) {
           //广告成功
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"2"]) {
           //分享失败
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"3"]) {
           //分享成功
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"10"]) {
           //返回商品信息成功
        //商品信息
        [Info objectForKey:@"product"];
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"11"]) {
           //返回商品信息失败
    }else  if([[Info objectForKey:@"status"] isEqualToString:@"12"]) {
           //返回翻译
        //可以根据code的值，当值为1时，表示获取到翻译。翻译内容是translate的值
           if([[Info objectForKey:@"code"]isEqualToString:@"1"]){
                NSString *str = [Info objectForKey:@"translate"];
               self.translatedLb.text = str;
           }
    }else if ([[Info objectForKey:@"status"] isEqualToString:@"13"]) {
        //vip客服不可显示
    }else if ([[Info objectForKey:@"status"] isEqualToString:@"14"]) {
        //vip客服可显示
    }else if ([[Info objectForKey:@"status"] isEqualToString:@"15"]) {
        //vip客服关闭
    }
}

#pragma mark - wfnjiLoginCallBack,wfnjiPayCallBack
-(void)onFinish:(wfnjiStatus)code   Data:(NSDictionary*)Data {
    NSLog(@"回调状态值：%ld",(long)code);
    
    
    NSLog(@"回调：%@",Data);
    if(code==LOGIN_SUCCESS){
        NSString *str = [NSString stringWithFormat:@"logined:%@,uid:%@",Data[@"deviceId"],Data[@"uid"]];
        self.loginInfoLB.text = str;
        //登录成功
    }
    else if(code== LOGOUT_SUCCESS){
        //登出成功
    }else if (code ==PAY_SUCCESS){
        //支付成功
    } else if (code== PAY_FAILED){
        //支付失败
    } else if (code==PAY_CANCEL){
        //支付取消
    } else if (code==PAY_UNKNOWN){
        //支付未知
    }
}

- (IBAction)login:(id)sender {
    //登录，回调在onFinish:Data:
    [wfnjiPlat login:self];
}

- (IBAction)logout:(id)sender {
    //登出，回调在onFinish:Data:
    [wfnjiPlat logout];
}

- (IBAction)pay:(id)sender {
    wfnjiOrderModel* mPayInfo = [[wfnjiOrderModel alloc] init];
    /** 商品id */
    mPayInfo.productID=@"商品id";
    /** Y 商品名 */
    mPayInfo.productName=@"商品名称";
    /** Y 商品价格 */
    mPayInfo.productPrice=@"价格";
    /** 商品描述（不传则使用productName） */
    mPayInfo.productDes=@"商品描述";
    /** 游戏传入的有关用户的区id，服务器id，角色id,订单等，属于透传数据功能 */
    mPayInfo.gameReceipts=@"透传数据";
    /** Y 游戏角色id */
    mPayInfo.roleID=@"";
    /** Y 游戏角色名 */
    mPayInfo.roleName=@"";
    /** 游戏角色等级 */
    mPayInfo.roleLevel=@"";
    /** Y Vip等级 */
    mPayInfo.vipLevel=@"";
    /** Y 帮派、公会等 */
    mPayInfo.partyName=@"";
    /** Y 服务器id，若无填“1” */
    mPayInfo.zoneID=@"";
    /** Y 服务器名 */
    mPayInfo.zoneName=@"";
    /** N 扩展字段 */
    mPayInfo.text=@"";
    /**
     回调地址 可传可不传，不传使用默认
     */
     mPayInfo. notifyURL = @"1234567890-123456789";
    
    [wfnjiPlat wfnjipay:mPayInfo CallBack:self];
    
}
- (IBAction)share:(id)sender {
    //分享有两种接入方式，如下所示，可以按需接入
    //分享方法1：此方法cp接入ShareInfoName和ShareInfoID必须和我们后台配置相符合
    [wfnjiPlat ShareInfoName:@"请传入分享信息"
                 ShareInfoID:@"分享id"
                  shareUname:@"角色名称"
                 shareServer:@"角色区服"
                   shareCode:@"角色code"
     ];
    
    //分享方法2：
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
    
    //示例：图片分享
    [wfnjiPlat shareInfo:@"请输入需要分享文案"
                   image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20180210%2F23%2F1518276333-RXexUJcntC.jpg&refer=http%3A%2F%2Fimage.biaobaiju.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614306450&t=e1c9d6c5223192f3f335c377048882bf"]] ]
                    link:@"此处示例图片分享，链接可以传空"
                    type:@"2"
               otherInfo:@{}];
}
- (IBAction)ad:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"广告" message:@"请选择广告类型" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ad1 = [UIAlertAction actionWithTitle:@"激励视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wfnjiPlat choseADPlatForm:0];
    }];
        
    UIAlertAction *ad2 = [UIAlertAction actionWithTitle:@"插页广告" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wfnjiPlat choseADPlatForm:1];
    }];
    UIAlertAction *ad3 = [UIAlertAction actionWithTitle:@"横幅广告" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wfnjiPlat choseADPlatForm:2];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }];
    [alert addAction:ad1];
    [alert addAction:ad2];
    [alert addAction:ad3];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)custom:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"客服相关" message:@"请选择相应客服" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *custom = [UIAlertAction actionWithTitle:@"客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wfnjiPlat showCustomView];
    }];
        
    UIAlertAction *canVip = [UIAlertAction actionWithTitle:@"是否可以显示vip客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //此接口用于判断是否可以显示vip客服，结果在通知中返回
        [wfnjiPlat isCanVip];
    }];
    UIAlertAction *vipCust = [UIAlertAction actionWithTitle:@"vip客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //此接口用于显示vip客服，会返回相关结果在通知中返回（可显示，不可显示，显示成功用户关闭）
        [wfnjiPlat VIPCustomService];
    }];
    UIAlertAction *faq = [UIAlertAction actionWithTitle:@"常见问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //此接口用于显示vip客服，会返回相关结果在通知中返回（可显示，不可显示，显示成功用户关闭）
        [wfnjiPlat showFAQView];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }];
    [alert addAction:custom];
    [alert addAction:canVip];
    [alert addAction:vipCust];
    [alert addAction:faq];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)role:(id)sender {
    /**
    
    获取当前游戏的角色
    角色名字：name
    游戏等级：level
    区服:   serverID
    状态值默认选择<3>:status 1:创建角色 2:完成新手引导 3:等级升级 4：进入游戏
    */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上报角色打点" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ad1 = [UIAlertAction actionWithTitle:@"新手引导" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //新手引导
        [wfnjiPlat wfnjiRoleName:@"a" gameLevel:@"1" serverID:@"1" roleID:@"1" status:@"2" vipLevel:@""];
    }];
        
    UIAlertAction *ad2 = [UIAlertAction actionWithTitle:@"角色等级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //角色等级
        [wfnjiPlat wfnjiRoleName:@"b" gameLevel:@"" serverID:@"1" roleID:@"2" status:@"3" vipLevel:@""];
    }];
    
    UIAlertAction *ad3 = [UIAlertAction actionWithTitle:@"创建角色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //创建角色
        [wfnjiPlat wfnjiRoleName:@"b" gameLevel:@"" serverID:@"1" roleID:@"2" status:@"1" vipLevel:@""];
    }];
    
    UIAlertAction *ad4 = [UIAlertAction actionWithTitle:@"进入游戏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //进入游戏
        [wfnjiPlat wfnjiRoleName:@"b" gameLevel:@"" serverID:@"1" roleID:@"2" status:@"4" vipLevel:@""];
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }];
    [alert addAction:ad1];
    [alert addAction:ad2];
    [alert addAction:ad3];
    [alert addAction:ad4];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)upEvent:(id)sender {
    [wfnjiPlat LogInfo:self.eventTF.text EventDic:nil];
   
}

- (IBAction)social:(id)sender {
    //打开社交有两种调用，cp可根据自己需要调用，详见接入文档
    //方法一：
    /**
     *param:
     *      code:2--facebook, 3--lobi, 4--appstore
     *      info：链接地址/包名/应用ID(无参数默认给个空字符)
     *      pageId：粉丝页ID（无参数默认给个空字符）
     **/
    [wfnjiPlat toastplatformCode:@"2" Info:@"" pageID:@""];
    
    //方法二：
    /**
    *param:
    *      type:1--应用商店, 2--三方平台
    **/
    [wfnjiPlat showMarkViewType:1];
}

- (IBAction)tran:(id)sender {
    /**
     *param
     *     text:需要翻译的文本（必传）
     *     identifier：文本标识符（可不传）
     **/
    [wfnjiPlat translateText:self.textTF.text identifier:@"2"];
}

- (IBAction)tools:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"工具型接口" message:@"请选择需求自行接入相关接口" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *custom = [UIAlertAction actionWithTitle:@"获取当前手机系统语言和地区" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       NSString *str = [wfnjiPlat returnLanguageCode];
        //此接口是弹出相应文字,将获取到的手机系统语言和地区弹出做示例
        [wfnjiPlat toastInfo:str];
        
    }];
        
    UIAlertAction *canVip = [UIAlertAction actionWithTitle:@"获取SDK版本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = [wfnjiPlat versions];
        //此接口是弹出相应文字,将SDK版本弹出做示例
        [wfnjiPlat toastInfo:str];
    }];
    UIAlertAction *vipCust = [UIAlertAction actionWithTitle:@"获取手机所在时区" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = [wfnjiPlat returnTimeZome];
        //此接口是弹出相应文字,将获取手机所在时区弹出做示例
        [wfnjiPlat toastInfo:str];
    }];
    UIAlertAction *openurl = [UIAlertAction actionWithTitle:@"打开webview" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wfnjiPlat showViewWithStr:@"https://www.baidu.com"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }];
    [alert addAction:custom];
    [alert addAction:canVip];
    [alert addAction:vipCust];
    [alert addAction:cancel];
    [alert addAction:openurl];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
