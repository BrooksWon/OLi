//
//  OLiLoginBoard.m
//  OLi
//
//  Created by Brooks on 16/3/17.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiLoginBoard.h"
#import "OLiAppDelegate.h"
#define AppDelegateEntity ((OLiAppDelegate *)[UIApplication sharedApplication].delegate)

@interface OLiLoginBoard ()

@property(nonatomic, strong) IBOutlet UIImageView *bgImgV;

@end

@implementation OLiLoginBoard

- (IBAction)loginBtnAction:(id)sender {
    [AppDelegateEntity changeVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小试牛刀";
    [self.bgImgV setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg4" ofType:@"jpg"]]];
}

@end
