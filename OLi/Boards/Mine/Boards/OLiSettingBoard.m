//
//  OLiSettingBoard.m
//  OLi
//
//  Created by Brooks on 16/4/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiSettingBoard.h"

#define kTableViewSectionNumbers 1

#import "OLiWebBoard.h"
#import "OLiAppDelegate.h"

@interface OLiSettingBoard ()

@property (strong, nonatomic) IBOutlet UITableViewCell *legalCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *logoutCell;
@property (nonatomic, strong) IBOutlet UILabel *versionLabel;

@end

@implementation OLiSettingBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本号:%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
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
//    switch (indexPath.section) {
//        case 0:
//        {
//            return self.legalCell;
//        }
//        case 1:
//        {
//            return self.aboutCell;
//        }
//        case 2:
//        {
            return self.logoutCell;
//        }
//    }
//    
//    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case 0:
//        {
//            OLiWebBoard *webVC = [OLiWebBoard new];
//            webVC.webURL = @"http://www.baidu.com";
//            webVC.title = @"免责声明";
//            webVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:webVC animated:YES];
//            break;
//        }
//        case 1:
//        {
//            OLiWebBoard *webVC = [OLiWebBoard new];
//            webVC.webURL = @"http://www.baidu.com";
//            webVC.title = @"免责声明";
//            webVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:webVC animated:YES];
//            break;
//        }
//        case 2:
//        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [((OLiAppDelegate*)[UIApplication sharedApplication].delegate) changeVC2Login];
//            break;
//        }
//    }
}


@end
