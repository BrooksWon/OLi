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

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialAlipayShareHandler.h"

#define kTalkingDataKey @"A41B884029285A99D0DFF86B7C9F9B87"
#define kChannelIdKey   @"AppStore"

@interface OLiAppDelegate ()

@end

@implementation OLiAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
//    self.window.rootViewController = OLiHomeBoard.new;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:OLiLoginBoard.new];
//    self.window.rootViewController = [OLiIndexBoard new];
    
    [self customizeAppearance];
    
    [self setupTalkingData];
    [self setupUMShare];
    
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)changeVC {
    self.window.rootViewController = OLiHomeBoard.new;
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

@end
