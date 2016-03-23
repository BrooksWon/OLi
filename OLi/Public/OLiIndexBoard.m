//
//  OLiIndexBoard.m
//  OLi
//
//  Created by Brooks on 16/3/23.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiIndexBoard.h"

@interface OLiIndexBoard ()

@end

@implementation OLiIndexBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewControllers];
}

- (void)initViewControllers {
    if (self.viewControllers.count <= 0) {
        self.viewControllers = @[CreateNavigationController(CreateViewController(@"OLiSectionBoard"),
                                                            nil,
                                                            nil,
                                                            @"练习"),
                                 CreateNavigationController(CreateViewController(@"OLiHomeBoard"),
                                                            nil,
                                                            nil,
                                                            @"NetEngine"),];
    }
    
}

static inline  UIViewController * CreateViewController(NSString *className) {
    UIViewController *VC = nil;
    if (className) {
        if (NSClassFromString(className)) {
            VC = (UIViewController*)[[NSClassFromString(className) alloc] init];
        }
    }
    return VC;
}

static inline UINavigationController *CreateNavigationController(UIViewController *vc,
                                                                 NSString *selectedImageName,
                                                                 NSString *unSelectedImageName,
                                                                 NSString *title) {
    UINavigationController *nav = nil;
    if (vc) {
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if (nav) {
            nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                           image:[UIImage imageNamed:unSelectedImageName]
                                                   selectedImage:[UIImage imageNamed:selectedImageName]];
        }
    }
    return nav;
}

@end
