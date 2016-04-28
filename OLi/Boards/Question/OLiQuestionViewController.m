//
//  OLiQuestionViewController.m
//  OLi
//
//  Created by Brooks on 16/4/28.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiQuestionViewController.h"
#import "NextViewController.h"
#import "OLiAppDelegate.h"

@interface OLiQuestionViewController ()

@end

@implementation OLiQuestionViewController

- (instancetype)initWithTitle:(NSString *)title bgColor:(UIColor *)bgc
{
    if (self = [super init]) {
        self.title = title;
        self.view.backgroundColor = bgc;
        self.url = [NSURL URLWithString:@"http://www.baidu.com"];
    }
    return self;
}

-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * action1 = [UIPreviewAction actionWithTitle:@"大" style:1 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NextViewController *aaaa = [[NextViewController alloc] init];
        [[self topViewController] presentViewController:aaaa animated:YES completion:nil];
    }];
    
    UIPreviewAction * action2 = [UIPreviewAction actionWithTitle:@"家" style:0 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        UIViewController *aaaa = [[UIViewController alloc] init];
        aaaa.view.backgroundColor = [UIColor brownColor];
        [[self topViewController].navigationController pushViewController:aaaa animated:YES];
        
    }];
    UIPreviewAction * action3 = [UIPreviewAction actionWithTitle:@"好" style:2 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    }];
    
    NSArray * actions = @[action1,action2,action3];
    
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

@end
