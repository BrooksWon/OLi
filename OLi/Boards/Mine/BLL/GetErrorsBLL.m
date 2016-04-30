//
//  GetErrorsBLL.m
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "GetErrorsBLL.h"
#import "RequestGetErrors.h"

@implementation GetErrorsBLL
- (void)getErrorsWithUserId:(NSString*)userId chapterId:(NSString*)chapterId callback:(void (^) (id objc))callback {
    RequestGetErrors *req = [[RequestGetErrors alloc] init];
    req.userId = userId;
    req.chapterId = chapterId;
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        !callback ?:callback(responseObject);
    } failBlock:^(OLiNetError *error, NSDictionary *options) {
        !callback ?:callback(error);
    }];
}
@end
