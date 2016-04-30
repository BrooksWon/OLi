//
//  OLiMeBoard.h
//  OLi
//
//  Created by Brooks on 16/3/20.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiBaseBoard.h"

@interface OLiMeBoard : OLiBaseBoard <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)showShareList:(id)sender;

@end
