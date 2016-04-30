//
//  GetFavoritesBLL.m
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "GetFavoritesBLL.h"
#import "RequestGetFavorites.h"

@implementation GetFavoritesBLL
- (void)getFavoritesWithUserId:(NSString*)userId chapterId:(NSString*)chapterId callback:(void (^) (id objc))callback {
    RequestGetFavorites *req = [[RequestGetFavorites alloc] init];
    req.userId = userId;
    req.chapterId = chapterId;
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        !callback ?:callback(responseObject);
    } failBlock:^(OLiNetError *error, NSDictionary *options) {
        !callback ?:callback(error);
    }];
}
@end
