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

@interface OLiAppDelegate ()

@end

@implementation OLiAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
//    self.window.rootViewController = OLiHomeBoard.new;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:OLiLoginBoard.new];
//    self.window.rootViewController = [OLiIndexBoard new];
    
//    [self customizeAppearance];
    
    return YES;
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)changeVC {
    self.window.rootViewController = OLiHomeBoard.new;
}

- (void)customizeAppearance
{
//    // 设置导航按钮样式
//    UIImage *returnBg = [[UIImage imageNamed:@"return_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
//    UIImage *returnBgOn = [[UIImage imageNamed:@"return_button_on"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 11)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:returnBg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:returnBgOn forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
//    // 导航栏上的按钮
//    UIImage *buttonBg = [[UIImage imageNamed:@"button_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
//    UIImage *buttonBgOn = [[UIImage imageNamed:@"button_bg_on"] resizableImageWithCapInsets:UIEdgeInsetsMake(9, 12, 9, 12)];
//    [[UIButton appearanceWhenContainedIn:[UINavigationBar class],nil] setBackgroundImage:buttonBg forState:UIControlStateNormal];
//    [[UIButton appearanceWhenContainedIn:[UINavigationBar class],nil] setBackgroundImage:buttonBgOn forState:UIControlStateHighlighted];
//    [[UIButton appearanceWhenContainedIn:[UINavigationBar class],nil] setBackgroundImage:buttonBg forState:UIControlStateDisabled];
    
    // 设置导航条背景 和顶部文字样式
    UIImage *navBg = [[UIImage imageNamed:@"navigationbar_background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    [[UINavigationBar appearance] setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor blackColor],NSForegroundColorAttributeName,
//      [UIFont systemFontOfSize:18],NSFontAttributeName, nil]
//     ];
    
    UIImage *tabbarBg = [[UIImage imageNamed:@"tabbar_background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    [[UITabBar appearance] setBackgroundImage:tabbarBg];
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
//    
//    //设置工具栏背景
//    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"tool_bar"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    //搜索栏相关设置
    //    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar"]];
    
    //    [[UIButton appearanceWhenContainedIn:[UITextField class],[UISearchBar class],nil] setBackgroundImage:nil forState:UIControlStateNormal];
    //    [[UIButton appearanceWhenContainedIn:[UITextField class],[UISearchBar class],nil] setBackgroundImage:nil forState:UIControlStateHighlighted];
    //    [[UIButton appearanceWhenContainedIn:[UITextField class],[UISearchBar class],nil] setBackgroundImage:nil forState:UIControlStateDisabled];
    
    //    [[UIButton appearanceWhenContainedIn:[UISearchBar class],nil] setBackgroundImage:buttonBg forState:UIControlStateNormal];
    //    [[UIButton appearanceWhenContainedIn:[UISearchBar class],nil] setBackgroundImage:buttonBgOn forState:UIControlStateHighlighted];
    //    [[UIButton appearanceWhenContainedIn:[UISearchBar class],nil] setBackgroundImage:buttonBg forState:UIControlStateDisabled];
}

@end
