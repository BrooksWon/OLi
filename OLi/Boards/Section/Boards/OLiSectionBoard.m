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

#import "SubjectBLL.h"
#import "ChapterBLL.h"

#import "OLiQuestionViewController.h"
#import "UMSocial.h"

#import "OLiAppDelegate.h"

@interface OLiSectionBoard ()<OLiTableViewHeaderViewDelegate, UIViewControllerPreviewingDelegate,UMSocialUIDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong)SubjectBLL *subjectBLL;
@property (nonatomic, strong)ChapterBLL *chapterBLL;


@end

@implementation OLiSectionBoard

- (NSArray *)listArray{
    if (!_listArray) {
        self.listArray = [NSMutableArray array];
    }

    return _listArray;
}

- (void)loadDataFromServer:(BOOL)isRefresh {
    
    [self HUDAction:nil];
    
    if (isRefresh) {
        self.listArray = nil;
    }
    
    __typeof (self) weakSelf = self;
    [self.subjectBLL loadSubjectWithCallback:^(id objc) {
        NSMutableArray * arr = [NSMutableArray array];
        @try {
            for (id item in [objc valueForKeyPath:@"subjectList"]) {
                ModelGroups *group = [ModelGroups parsingDataWithObject:item];
                [arr addObject:group];
                
            }
        } @catch (NSException *exception) {
            NSLog(@"没有返回subjectList列表");
        } @finally {
            //
        }
        
        [weakSelf.listArray addObjectsFromArray:arr];
        if (0 < weakSelf.listArray.count) {
            [self.tableView reloadData];
        }
        
        [self HUDAction:nil];
    }];
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.sectionHeaderHeight = 44;
    
    [self loadDataFromServer:YES];
    
    [self check3DTouch];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    if (group) {
        return group.isOpen? group.groups.count:0;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OLiSectionTableViewCell *cell = [OLiSectionTableViewCell sectionTableViewCellWithTableView:tableView forIndexPath:indexPath];
    if (self.listArray) {
        ModelGroups *group = self.listArray[indexPath.section];
        
        @try {
            cell.sectionName = [group.groups[indexPath.row] valueForKeyPath:@"name"];
        } @catch (NSException *exception) {
            NSLog(@"没有该章节，或者该章节的name为空");
        } @finally {
            //
        }
        
    }
    
    // 注册peek、pop
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    
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
    if (view.group.isOpen) {
        [self HUDAction:nil];
        [self.chapterBLL loadChapterWithID:view.group.subjectID callback:^(id objc) {
            @try {
                view.group.groups = [objc valueForKeyPath:@"chapterList"];
                if (0 < view.group.groups.count) {
                    [self.tableView reloadData];
                }
            } @catch (NSException *exception) {
                NSLog(@"没有chapterList列表");
            } @finally {
                //
            }
            [self HUDAction:nil];
        }];
    }else {
        [self.tableView reloadData];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *_ids = [self.listArray[indexPath.section] valueForKeyPath:@"groups"];
    NSString *_id = [_ids[indexPath.row] valueForKeyPath:@"id"];
    NSString *idLink = kDaTi(_id);
    OLiQuestionViewController* webViewController = [[OLiQuestionViewController alloc] initWithUrl:[NSURL URLWithString:idLink]];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (SubjectBLL*)subjectBLL {
    if (nil == _subjectBLL) {
        self.subjectBLL = [SubjectBLL new];
    }
    return _subjectBLL;
}

- (ChapterBLL*)chapterBLL {
    if (nil == _chapterBLL) {
        self.chapterBLL = [ChapterBLL new];
    }
    return _chapterBLL;
}

-(void)check3DTouch
{
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //ok
    }
    else{
        //notok
    }
}

#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[context sourceView]];
    
    NSArray *_ids = [self.listArray[indexPath.section] valueForKeyPath:@"groups"];
    NSString *_id = [_ids[indexPath.row] valueForKeyPath:@"id"];
    NSString *idLink = kDaTi(_id);
    OLiQuestionViewController *childVC = [[OLiQuestionViewController alloc] initWithUrl:[NSURL URLWithString:idLink]];
    
    
    childVC.preferredContentSize = CGSizeMake(0.0f,500.f);
    return childVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
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

@end
