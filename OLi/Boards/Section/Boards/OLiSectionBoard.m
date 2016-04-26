//
//  OLiSectionBoard.m
//  OLi
//
//  Created by Brooks on 16/3/23.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiSectionBoard.h"
#import "OLiSectionTableViewCell.h"
#import "OLiTableViewHeaderView.h"
#import "OLiWebViewNavigationViewController.h"
#import "OLiWebViewController.h"

@interface OLiSectionBoard ()<OLiTableViewHeaderViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listArray;

@end

@implementation OLiSectionBoard

- (NSArray *)listArray{
    if (!_listArray) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"list.plist" ofType:nil];
        NSArray * dicArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary *dict in dicArr) {
            ModelGroups *group = [ModelGroups parsingJsonWithDictionary:dict];
            [arr addObject:group];
        }
        _listArray = arr;
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.sectionHeaderHeight = 44;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ModelGroups *group = self.listArray[section];
    return group.isOpen? group.groups.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OLiSectionTableViewCell *cell = [OLiSectionTableViewCell sectionTableViewCellWithTableView:tableView forIndexPath:indexPath];
    if (self.listArray) {
        ModelGroups *group = self.listArray[indexPath.section];
        
        cell.sectionName = [group.groups[indexPath.row] valueForKeyPath:@"intro"];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OLiTableViewHeaderView *header = [OLiTableViewHeaderView OLiTableViewHeaderView:tableView];
    header.delegate = self;
    if (self.listArray) {
        ModelGroups *group = self.listArray[section];
        header.group = group;
    }
    return header;
}

- (void)OLiTableViewHeaderView:(OLiTableViewHeaderView *)view didButton:(UIButton *)sender
{
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OLiWebViewController* webViewController = [[OLiWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://m.auto.life"]];
    webViewController.hidesBottomBarWhenPushed = YES;
//    UIViewController* webViewController = CreateViewController(@"OLiQuestionBoard");
    [self.navigationController pushViewController:webViewController animated:YES];
}


static inline  UIViewController * CreateViewController(NSString *className) {
    UIViewController *VC = nil;
    if (className) {
        if (NSClassFromString(className)) {
            VC = (UIViewController*)[[NSClassFromString(className) alloc] init];
        }
    }
    VC.hidesBottomBarWhenPushed = YES;
    return VC;
}

@end
