//
//  OLiLoginBoard.m
//  OLi
//
//  Created by Brooks on 16/3/17.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiLoginBoard.h"
#import "OLiAppDelegate.h"

#import "HyTransitions.h"
#import "HyLoglnButton.h"

#define AppDelegateEntity ((OLiAppDelegate *)[UIApplication sharedApplication].delegate)
#import "OLiIndexBoard.h"

#import "TalkingData.h"

#import "LoginBLL.h"

@interface OLiLoginBoard ()<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) IBOutlet UIImageView *bgImgV1;
@property(nonatomic, strong) IBOutlet UITextField *countField;
@property(nonatomic, strong) IBOutlet UITextField *pwField;
@property(nonatomic, strong) IBOutlet UIView *licenseView;
@property(nonatomic, strong) IBOutlet UIImageView *bgImgV2;
@property(nonatomic, strong) IBOutlet UITextField *licenseField;

@property(nonatomic, assign) NSInteger time;
@property(nonatomic, assign) BOOL isChangeLicense;

@property(nonatomic, strong) LoginBLL *loginBLL;

@end

@implementation OLiLoginBoard

- (IBAction)loginBtnActionWithCount:(id)sender {
        [TalkingData trackEvent:@"loginBtn_count"];
//    [AppDelegateEntity changeVC];
    
    __typeof(self) __weak weakSelf = self;
    [self.loginBLL loginWithSN:nil account:self.countField.text password:self.pwField.text callback:^(id objc) {
        NSLog(@"objc = %@", objc);
        if ([@"1000" isEqualToString:[objc valueForKeyPath:@"rspInfo.rspCode"]]) {
            //网络正常 或者是密码账号正确跳转动画
            [sender ExitAnimationCompletion:^{
                [weakSelf didPresentControllerButtonTouch];
                [[NSUserDefaults standardUserDefaults] setObject:[objc valueForKeyPath:@"userInfo.id"] forKey:kUID];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];
        }else {
            //网络错误 或者是密码不正确还原动画
            [sender ErrorRevertAnimationCompletion:^{
                weakSelf.pwField.text = @"密码错误";
            }];
        }
    }];
}

- (IBAction)loginBtnActionWithLicense:(id)sender {
    [TalkingData trackEvent:@"loginBtn_License"];
    
    __typeof(self) __weak weakSelf = self;
    [self.loginBLL loginWithSN:self.licenseField.text account:nil password:nil callback:^(id objc) {
        NSLog(@"objc = %@", objc);
        if ([@"1000" isEqualToString:[objc valueForKeyPath:@"rspInfo.rspCode"]]) {
            //网络正常 或者是密码账号正确跳转动画
            [sender ExitAnimationCompletion:^{
                [weakSelf didPresentControllerButtonTouch];
                [[NSUserDefaults standardUserDefaults] setObject:[objc valueForKeyPath:@"userInfo.id"] forKey:kUID];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];
        }else {
            //网络错误 或者是密码不正确还原动画
            [sender ErrorRevertAnimationCompletion:^{
                weakSelf.licenseField.text = @"授权码错误";
            }];
        }
    }];
}

- (IBAction)changeLicenseBtnAction:(id)sender {
    [self.view addSubview:self.licenseView];
    self.licenseView.frame = self.view.bounds;
    [self.bgImgV2 setImage:self.bgImgV1.image];
    self.isChangeLicense = YES;
}

- (IBAction)changeCountBtnAction:(id)sender {
    [self.licenseView removeFromSuperview];
    self.isChangeLicense = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小试牛刀";
}

/*!
 *  @brief 切换到业务首页
 */
- (void)didPresentControllerButtonTouch {
    
    UIViewController *controller = [OLiIndexBoard new];
    
    controller.transitioningDelegate = self;
    
//    UINavigationController *nai = [[UINavigationController alloc] initWithRootViewController:controller];
//    nai.transitioningDelegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
}


- (LoginBLL*)loginBLL {
    if (nil == _loginBLL) {
        self.loginBLL = [LoginBLL new];
    }
    return _loginBLL;
}

@end
