//
//  OLiAppDelegate.m
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiAppDelegate.h"
#import "OLiHomeBoard.h"
#import "OLiLoginBoard.h"
#import "OLiIndexBoard.h"
#import "TalkingData.h"
#import "TalkingDataSMS.h"
#import "UMSocial.h"
#import "OLiMeBoard.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialAlipayShareHandler.h"

#define kTalkingDataKey @"A41B884029285A99D0DFF86B7C9F9B87"
#define kChannelIdKey   @"AppStore"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

#import "UMessage.h"
#import "ATAppUpdater.h"

@interface OLiAppDelegate ()

@end

@implementation OLiAppDelegate

+ (OLiAppDelegate *)appDelegate {
    return (OLiAppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:OLiLoginBoard.new];
//    self.window.rootViewController = [OLiIndexBoard new];
    
    [self customizeAppearance];
    
    [self setupTalkingData];
    [self setupUMShare];
    [self setup3DTouch];
    
    
    [self setupUMPush:launchOptions];
    [self showPushMessage:launchOptions];
    
    
    [[ATAppUpdater sharedUpdater] forceOpenNewAppVersion:YES];
    
    return YES;
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)changeVC2Login {
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:OLiLoginBoard.new];
}

- (void)customizeAppearance {
    // 设置导航条背景 和顶部文字样式
//    UIImage *navBg = [[UIImage imageNamed:@"navigationbar_background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    UIImage *navBg = [self imageFromColor:[UIColor whiteColor] height:64];
    [[UINavigationBar appearance] setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor blackColor],NSForegroundColorAttributeName,
//      [UIFont systemFontOfSize:18],NSFontAttributeName, nil]
//     ];
    
//    UIImage *tabbarBg = [[UIImage imageNamed:@"tabbar_background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    UIImage *tabbarBg = [self imageFromColor:[UIColor whiteColor] height:49];
    [[UITabBar appearance] setBackgroundImage:tabbarBg];
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
}

//通过颜色来生成一个纯色图片
- (UIImage *)imageFromColor:(UIColor *)color height:(CGFloat)height{
    
    CGRect rect = CGRectMake(0, 0, self.window.frame.size.width,height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)setupUMShare{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:kUmengAppKey];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
    
//    // 打开新浪微博的SSO开关
//    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 设置支付宝分享的appId
    [UMSocialAlipayShareHandler setAlipayShareAppId:@"2015111700822536"];
    
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline,UMShareToWechatFavorite]];
}

- (void)setupTalkingData {
    [TalkingData setExceptionReportEnabled:YES];
    [TalkingData sessionStarted:kTalkingDataKey withChannelId:kChannelIdKey];
//    [TalkingDataSMS init:@"E7538D90715219B3A2272A3E07E69C57" withSecretId:@""];
}

- (void)setup3DTouch {
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"签到" localizedTitle:@"签到" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"qiandao"] userInfo:nil];
    
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"我的收藏" localizedTitle:@"我的收藏" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"shoucang"] userInfo:nil];
    
    UIApplicationShortcutItem *shortItem3 = [[UIApplicationShortcutItem alloc] initWithType:@"错题本" localizedTitle:@"错题本" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"cuoti"] userInfo:nil];
    
    UIApplicationShortcutItem *shortItem4 = [[UIApplicationShortcutItem alloc] initWithType:@"分享" localizedTitle:@"分享" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"fenxiang"] userInfo:nil];
    
    
    NSArray *shortItems = @[shortItem1, shortItem2, shortItem3, shortItem4];
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    [[self topViewController].tabBarController setSelectedIndex:1];
    
    UINavigationController *navVC = (UINavigationController*)[[self topViewController].tabBarController selectedViewController];
    OLiMeBoard *meVC = (OLiMeBoard*)[navVC topViewController];

    
    if ([shortcutItem.localizedTitle  isEqual: @"签到"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"恭喜，签到成功！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([shortcutItem.localizedTitle  isEqual: @"我的收藏"]) {
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"]) {
            //
            [meVC.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] animated:YES scrollPosition:UITableViewScrollPositionNone];
//        }
    }else if ([shortcutItem.localizedTitle  isEqual: @"错题本"]) {
        
    }else if ([shortcutItem.localizedTitle  isEqual: @"分享"]) {
        [meVC showShareList:nil];
    }
}

- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[OLiAppDelegate appDelegate].window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


- (void)setupUMPush:(NSDictionary *)launchOptions {
    //set AppKey and LaunchOptions
    [UMessage startWithAppkey:kUmengAppKey launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
    //for log
    [UMessage setLogEnabled:YES];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
    //如果注册成功，可以删掉这个方法
    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    //  [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
//    NSString *message = [userInfo valueForKeyPath:@"aps.alert"];
    //定制自定的的弹出框
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
//                                                            message:message
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//
//        [alertView show];
//    }
    
    [self showPushMessage:userInfo];
        

}

- (void)showPushMessage:(NSDictionary*)dic {
    NSString *message = nil;
    @try {
        message = [dic valueForKeyPath:@"aps.alert"];
    } @catch (NSException *exception) {
        //
    } @finally {
        //
    }
    //定制自定的的弹出框
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {
        if (message) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            
            [alertView show];
        }
//    }
}

@end
