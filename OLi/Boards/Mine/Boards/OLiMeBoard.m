//
//  OLiMeBoard.m
//  OLi
//
//  Created by Brooks on 16/3/20.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiMeBoard.h"

#define kTableViewSectionNumbers 6

#import "OLiSettingBoard.h"

#import "UMSocial.h"

#import "OLiAppDelegate.h"
#import "OLiGetErrorsBoard.h"

@interface OLiMeBoard ()<UMSocialUIDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *meCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *questionsCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *msgCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *shareCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *favorateCell;

@end

@implementation OLiMeBoard

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kTableViewSectionNumbers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.meCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
        {
            return self.meCell;
        }
        case 1:
        {
            return self.questionsCell;
        }
        case 2:
        {
            return self.favorateCell;
        }
        case 3:
        {
            return self.msgCell;
        }
        case 4:
        {
            return self.shareCell;
        }
        case 5:
        {
            return self.settingCell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return 60;
        }
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            break;
        }
        case 1:
        {
            OLiGetErrorsBoard *vc = [[OLiGetErrorsBoard alloc] init];
            vc.isError = 1;
            vc.ID = @"1";
            vc.title = @"错题本";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            OLiGetErrorsBoard *vc = [[OLiGetErrorsBoard alloc] init];
            vc.isError = 0;
            vc.ID = @"1";
            vc.title = @"我的收藏 ";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            //message
            break;
        }
        case 4:
        {
            [self showShareList:nil];
            break;
        }
        case 5:
        {
            UIViewController *vc = [OLiSettingBoard new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
}


-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
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
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUmengAppKey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToEmail,UMShareToSms]
                                       delegate:self];
}

@end
