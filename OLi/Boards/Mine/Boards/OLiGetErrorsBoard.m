//
//  OLiGetErrorsBoard.m
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiGetErrorsBoard.h"
#import "OLiSectionTableViewCell.h"
#import "OLiQuestionViewController.h"
#import "OLiAppDelegate.h"

#import "GetErrorsBLL.h"
#import "GetFavoritesBLL.h"
#import "CheckinBLL.h"

#import "CCWormView.h"

@interface OLiGetErrorsBoard ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong) CCWormView *ccView;

@property (nonatomic, strong)GetErrorsBLL *getErrorsBLL;
@property (nonatomic, strong)GetFavoritesBLL *getFavoritesBLL;
@property (nonatomic, strong)CheckinBLL *checkinBLL;

@end

@implementation OLiGetErrorsBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.tableView.tableFooterView = [UIView new];
    
    self.dataArray = [NSMutableArray array];
    __typeof (self) weakSelf = self;
    if (self.isError) {
        [self HUDAction:nil];
        [self.getErrorsBLL getErrorsWithUserId:[[NSUserDefaults standardUserDefaults] stringForKey:kUID] chapterId:self.ID callback:^(id objc) {
            [weakSelf.dataArray addObjectsFromArray:[objc valueForKeyPath:@"questionIds"]];
            [weakSelf.tableView reloadData];
            [self HUDAction:nil];
        }];
    }else {
        [self HUDAction:nil];
        [self.getFavoritesBLL getFavoritesWithUserId:[[NSUserDefaults standardUserDefaults] stringForKey:kUID] chapterId:self.ID callback:^(id objc) {
            [weakSelf.dataArray addObjectsFromArray:[objc valueForKeyPath:@"questionIds"]];
            [weakSelf.tableView reloadData];
            [self HUDAction:nil];
        }];
    }
}

- (IBAction)HUDAction:(id)sender {
    if (!self.ccView) {
        self.ccView = [CCWormView wormHUDWithStyle:CCWormHUDStyleLarge toView:[UIApplication sharedApplication].keyWindow];
    }
    
    if (self.ccView.isShowing == NO) {
        [self.ccView startLodingWormHUD];
    }else{
        [self.ccView endLodingWormHUD];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OLiSectionTableViewCell *cell = [OLiSectionTableViewCell sectionTableViewCellWithTableView:tableView forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataArray[indexPath.row] valueForKeyPath:@"id"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *_id = [self.dataArray[indexPath.row] valueForKeyPath:@"id"];;
    NSString *idLink = kDaTi(_id);
    OLiQuestionViewController* webViewController = [[OLiQuestionViewController alloc] initWithUrl:[NSURL URLWithString:idLink]];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

-(GetFavoritesBLL *)getFavoritesBLL {
    if (nil == _getFavoritesBLL) {
        self.getFavoritesBLL = [GetFavoritesBLL new];
    }
    return _getFavoritesBLL;
}

-(GetErrorsBLL *)getErrorsBLL{
    if (nil == _getErrorsBLL) {
        self.getErrorsBLL = [GetErrorsBLL new];
    }
    return _getErrorsBLL;
}

- (CheckinBLL *)checkinBLL {
    if (nil == _checkinBLL) {
        self.checkinBLL = [CheckinBLL new];
    }
    return _checkinBLL;
}

@end
