//
//  OLiHomeBoard.h
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiBaseBoard.h"
#import "DemoBLL.h"
#import "DownloadBLL.h"

@interface OLiHomeBoard : OLiBaseBoard <DemoBLLDelegate,DownloadBLLDelegate>
@property (nonatomic, strong) DemoBLL *bll;
@property (nonatomic, strong) DownloadBLL *dbll;
@end
