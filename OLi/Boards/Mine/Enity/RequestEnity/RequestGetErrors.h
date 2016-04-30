//
//  RequestGetErrors.h
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiRequestObject.h"
#import "OLiRequestObject+InterfaceURLType.h"

@interface RequestGetErrors : OLiRequestObject
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *chapterId;
@end
