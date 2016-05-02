//
//  MsgBoard.h
//  OLi
//
//  Created by Brooks on 16/5/2.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiBaseBoard.h"

@interface MsgBoard : OLiBaseBoard<UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
