//
//  RequestDownload.h
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiRequestObject.h"
#import "OLiRequestObject+InterfaceURLType.h"
@interface RequestDownload : OLiRequestObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *taskId;
@end
