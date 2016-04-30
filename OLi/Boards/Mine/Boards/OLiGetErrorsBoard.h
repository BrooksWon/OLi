//
//  OLiGetErrorsBoard.h
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiBaseBoard.h"

@interface OLiGetErrorsBoard : OLiBaseBoard <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL isError;// 1:error, 0:favorite
@property (nonatomic, copy)NSString *ID;

@end
