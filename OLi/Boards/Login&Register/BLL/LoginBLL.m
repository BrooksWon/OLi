//
//  LoginBLL.m
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "LoginBLL.h"
#import "RequestLogin.h"

@implementation LoginBLL

- (void)loginWithSN:(NSString*)sn account:(NSString*)account password:(NSString*)pw callback:(void (^) (id objc))callback {
    RequestLogin *req = [[RequestLogin alloc] init];
    req.sn = sn;
    req.account = account;
    req.password = pw;
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        !callback ?:callback(responseObject);
    } failBlock:^(OLiNetError *error, NSDictionary *options) {
        !callback ?:callback(error);
    }];
}

@end
