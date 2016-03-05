//
//  OLiHomeBoard.m
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiHomeBoard.h"

@interface OLiHomeBoard ()

@end

@implementation OLiHomeBoard
- (IBAction)buttonAction:(id)sender {
    if (!self.bll) {
        self.bll = [[DemoBLL alloc] init];
    }
    self.bll.delegate = self;
    [self.bll loadDataFromServer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)after_loadDataFromServer
{
    ///TODO
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
