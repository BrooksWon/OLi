//
//  OLiHomeBoard.m
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiHomeBoard.h"
#import "NextViewController.h"
#import "CCWormView.h"

@interface OLiHomeBoard ()

@property (nonatomic,strong) CCWormView *ccView;

@end

@implementation OLiHomeBoard
- (IBAction)buttonAction:(id)sender {
    if (!self.bll) {
        self.bll = [[DemoBLL alloc] init];
    }
    self.bll.delegate = self;
    [self.bll loadDataFromServer];
}
- (IBAction)downloadAction:(id)sender {
    if (!self.dbll) {
        self.dbll = [[DownloadBLL alloc] init];
    }
    self.dbll.delegate = self;
    [self.dbll downloadloadDataFromServer];
}
- (IBAction)gotoAction:(id)sender {
    UIViewController *vc = NextViewController.new ;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)HUDAction:(id)sender {
    if (!self.ccView) {
        self.ccView = [CCWormView wormHUDWithStyle:CCWormHUDStyleLarge toView:self.view];
    }
    
    if (self.ccView.isShowing == NO) {
        [self.ccView startLodingWormHUD];
    }else{
        [self.ccView endLodingWormHUD];
    }
    
//    [self performSelector:@selector(HUDAction:) withObject:nil afterDelay:3.0];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)uploadAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)after_loadDataFromServer
{
    ///TODO
}

- (void)after_downloadLoadDataFromServer {
    //TODO
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
