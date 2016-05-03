//
//  OLiAppDelegate.h
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUmengAppKey    @"571f237de0f55a16c500002a"//暂时使用的是UM官方demo的key

#define kUID @"UID"

#define kDaTi(x) (NSString*)[NSString stringWithFormat:@"http://www.niudaoxiaoshi.com/question/mindex?chapterId=%@&userId=%@", (x), [[NSUserDefaults standardUserDefaults] stringForKey:kUID]]


@interface OLiAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)changeVC2Login;

+ (OLiAppDelegate *)appDelegate;

@end

