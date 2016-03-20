//
//  OLiMeBoard.m
//  OLi
//
//  Created by Brooks on 16/3/20.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiMeBoard.h"

@interface OLiMeBoard ()

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
            break;
    }
    
    return nil;
}

@end
