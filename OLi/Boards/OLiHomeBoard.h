//
//  OLiHomeBoard.h
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiBaseBoard.h"
#import "DemoBLL.h"

@interface OLiHomeBoard : OLiBaseBoard <DemoBLLDelegate>
@property (nonatomic, strong) DemoBLL *bll;
@end
