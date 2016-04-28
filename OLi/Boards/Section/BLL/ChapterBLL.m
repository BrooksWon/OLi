//
//  ChapterBLL.m
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "ChapterBLL.h"
#import "RequestChapter.h"

@implementation ChapterBLL
- (void)loadChapterWithID:(NSString*)_id callback:(void (^) (id objc))callback {
    RequestChapter *req = [[RequestChapter alloc] init];
//    req.id = _id;
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        !callback ?:callback(responseObject);
    } failBlock:^(OLiNetError *error, NSDictionary *options) {
        !callback ?:callback(error);
    }];
}
@end
