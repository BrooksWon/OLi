//
//  RequestLogin.h
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiRequestObject.h"
#import "OLiRequestObject+InterfaceURLType.h"

@interface RequestLogin : OLiRequestObject

@property (nonatomic, copy)NSString *sn;//授权码
@property (nonatomic, copy)NSString *account;//账号
@property (nonatomic, copy)NSString *password;//密码


@end
