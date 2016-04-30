//
//  CheckinBLL.m
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "CheckinBLL.h"
#import "RequestCheckin.h"

@implementation CheckinBLL
- (void)checkinWithUserId:(NSString*)userId callback:(void (^) (id objc))callback{
    RequestCheckin *req = [[RequestCheckin alloc] init];
    req.userId = userId;
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        !callback ?:callback(responseObject);
    } failBlock:^(OLiNetError *error, NSDictionary *options) {
        !callback ?:callback(error);
    }];
}
@end
