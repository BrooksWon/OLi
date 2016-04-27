//
//  SubjectBLL.m
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "SubjectBLL.h"
#import "RequestSubject.h"

@implementation SubjectBLL
- (void)loadSubjectWithCallback:(void (^) (id objc))callback {
    RequestSubject *req = [[RequestSubject alloc] init];
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        !callback ?:callback(responseObject);
    } failBlock:^(OLiNetError *error, NSDictionary *options) {
        !callback ?:callback(error);
    }];
}
@end
