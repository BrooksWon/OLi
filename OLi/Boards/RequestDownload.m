//
//  RequestDownload.m
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "RequestDownload.h"

@implementation RequestDownload
-(instancetype)init
{
    if (self = [super init]) {
#ifdef OLi_Server_Debug
        [self setInterfaceURL:@"thoughtbot/Markoff/archive/master.zip" Type:test_Domain];
#else
        [self setInterfaceURL:@"" Type:outer_Domain];
#endif
        self.serviceName = @"thoughtbot/Markoff/archive/master.zip";
        self.needCache = NO;
        self.isDownloadRequest = YES;
        self.requestMethodName = @"GET"; // get http://v.juhe.cn/weather/index?(null)=%7B%0A%0A%7D
        //post ;http://v.juhe.cn/weather/index
    }
    return self;
}
@end
