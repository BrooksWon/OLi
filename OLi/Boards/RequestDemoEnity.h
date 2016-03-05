//
//  RequestDemoEnity.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLiRequestObject.h"
#import "OLiRequestObject+InterfaceURLType.h"

@interface RequestDemoEnity : OLiRequestObject

//    //http://api.fblife.com/bbsapinew/login.php?username=FBL10086&password=111111FB&formattype=json&token=
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *formattype;
@property (nonatomic, copy) NSString *token;

@end
