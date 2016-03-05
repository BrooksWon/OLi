//
//  RequestDemoEnity.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "RequestDemoEnity.h"

@implementation RequestDemoEnity

-(instancetype)init
{
    if (self = [super init]) {
#ifdef OLi_Server_Debug
        [self setInterfaceURL:@"bbsapinew/login.php" Type:test_Domain];
#else
        [self setInterfaceURL:@"" Type:outer_Domain];
#endif
        self.serviceName = @"bbsapinew/login.php";
        self.needCache = NO;
        self.requestMethodName = @"GET"; // get http://v.juhe.cn/weather/index?(null)=%7B%0A%0A%7D
                                         //post ;http://v.juhe.cn/weather/index
    }
    return self;
}

@end
