//
//  OLiQuestionViewController.m
//  OLi
//
//  Created by Brooks on 16/4/28.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiQuestionViewController.h"
#import "OLiAppDelegate.h"
#import "UMSocial.h"


@interface OLiQuestionViewController ()<UMSocialUIDelegate>

@end

@implementation OLiQuestionViewController

- (instancetype)initWithTitle:(NSString *)title bgColor:(UIColor *)bgc url:(NSURL *)_url {
    if (self = [super init]) {
        self.title = title;
        self.view.backgroundColor = bgc;
        self.url = _url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * action1 = [UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        [self showShareList:[self topViewController]];
    }];
    
    UIPreviewAction * action2 = [UIPreviewAction actionWithTitle:@"答题" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        OLiQuestionViewController* webViewController = [[OLiQuestionViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.baidu.com"]];
        webViewController.hidesBottomBarWhenPushed = YES;
        [[self topViewController].navigationController pushViewController:webViewController animated:YES];
    }];
    
    NSArray * actions = @[action1,action2];
    
    return actions;
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

/*
 注意分享到新浪微博我们使用新浪微博SSO授权，你需要在xcode工程设置url scheme，并重写AppDelegate中的`- (BOOL)application openURL sourceApplication`方法，详细见文档。否则不能跳转回来原来的app。
 */
-(IBAction)showShareList:(id)sender
{
    NSString *shareText = @"欢迎使用－小试牛刀，考证无忧！ http://niudaoxiaoshi.com"; //分享内嵌文字
    UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon60x60@2x" ofType:@"png"]];
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:sender
                                         appKey:kUmengAppKey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToEmail,UMShareToSms]
                                       delegate:sender];
}

@end
