//
//  OLiRequestObject+InterfaceURLType.m
//  OLiNetEngine
//
//  Created by Brooks on 15/7/1.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "OLiRequestObject+InterfaceURLType.h"

@implementation OLiRequestObject (InterfaceURLType)

- (void)setInterfaceURL:(NSString *)interfaceURL_ Type:(InterfaceURLType)_type {
#ifdef OLi_Server_Debug
    //如果数据不存在，默认赋值初始化工具
    self.interfaceURL = [NSString stringWithFormat:@"%@%@", DomainDic[_type].stringDomain, interfaceURL_];
#else
    self.interfaceURL = [NSString stringWithFormat:@"%@%@", DomainDic[_type].stringDomain, interfaceURL_];
#endif
    
#ifdef OLi_HTTP_DEBUG_REQUEST_DOMAIN_InterFace
    OLiLog(@"Request RUL is\n%@", self.interfaceURL);
#endif
}

@end
