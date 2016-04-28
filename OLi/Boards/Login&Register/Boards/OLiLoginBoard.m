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
//    [AppDelegateEntity changeVC];
    [self gotoHomePageAction:sender];
    
    
    
    
//    [self.loginBLL loginWithCallback:^(id objc) {
//        NSLog(@"objc = %@", objc);
//    }];
    
    
    
    
    [TalkingData trackEvent:@"loginBtn_count"];
}

- (IBAction)loginBtnActionWithLicense:(id)sender {
    [self gotoHomePageAction:sender];
    [TalkingData trackEvent:@"loginBtn_License"];
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
//    [self.bgImgV1 setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg4" ofType:@"jpg"]]];
}

-(void)gotoHomePageAction:(HyLoglnButton *)button {
    
    __typeof(self) __weak weakSelf = self;
    __block __typeof(self.time) times = self.time;
    //模拟网络访问
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (times%2) {
            //网络正常 或者是密码账号正确跳转动画
            [button ExitAnimationCompletion:^{
                [weakSelf didPresentControllerButtonTouch];
            }];
        }else{
            //网络错误 或者是密码不正确还原动画
            [button ErrorRevertAnimationCompletion:^{
                if (!weakSelf.isChangeLicense) {
                    weakSelf.pwField.text = @"密码错误";
                }else {
                    weakSelf.licenseField.text = @"授权码错误";
                }
                
            }];
        }
    });
    
    self.time += 1;
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
