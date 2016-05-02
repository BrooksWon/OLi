//
//  MsgBoard.m
//  OLi
//
//  Created by Brooks on 16/5/2.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "MsgBoard.h"
#import "CCWormView.h"

@interface MsgBoard ()
@property (nonatomic, strong) CCWormView *ccView;

@end

@implementation MsgBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    [self HUDAction:nil];
    [self performSelector:@selector(HUDAction:) withObject:nil afterDelay:3.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
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

@end
