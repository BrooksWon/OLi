//
//  OLiMeBoard.m
//  OLi
//
//  Created by Brooks on 16/3/20.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiMeBoard.h"

#define kTableViewSectionNumbers 5

#import "OLiSettingBoard.h"

@interface OLiMeBoard ()
@property (strong, nonatomic) IBOutlet UITableViewCell *meCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *questionsCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *msgCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *shareCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingCell;

@end

@implementation OLiMeBoard

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
            return self.msgCell;
        }
        case 3:
        {
            return self.shareCell;
        }
        case 4:
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
    UIViewController *vc = [OLiSettingBoard new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
