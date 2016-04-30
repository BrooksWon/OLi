//
//  RequestCheckin.m
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "RequestCheckin.h"

@implementation RequestCheckin
-(instancetype)init
{
    if (self = [super init]) {
#ifdef OLi_Server_Debug
        [self setInterfaceURL:@"" Type:test_Domain];
#else
        [self setInterfaceURL:@"" Type:outer_Domain];
#endif
        self.serviceName = @"User.Checkin";
        self.requestMethodName = OLiRequestMethodName_POST_Key;
    }
    return self;
}
@end
