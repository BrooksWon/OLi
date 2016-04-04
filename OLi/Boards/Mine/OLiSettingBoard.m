//
//  OLiSettingBoard.m
//  OLi
//
//  Created by Brooks on 16/4/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiSettingBoard.h"

#define kTableViewSectionNumbers 3

#import "OLiWebBoard.h"

@interface OLiSettingBoard ()

@property (strong, nonatomic) IBOutlet UITableViewCell *legalCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *logoutCell;

@end

@implementation OLiSettingBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    switch (indexPath.section) {
        case 0:
        {
            return self.legalCell;
        }
        case 1:
        {
            return self.aboutCell;
        }
        case 2:
        {
            return self.logoutCell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OLiWebBoard *webVC = [OLiWebBoard new];
    webVC.webURL = @"http://www.baidu.com";
    webVC.title = @"免责声明";
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
