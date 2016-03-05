//
//  OLiNetError.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "OLiNetError.h"

@implementation OLiNetError

@synthesize description;

+ (OLiNetError *)OLiNetErrorWithCode:(NSInteger)code
                      withDesc:(NSString*)desc
                 withDetailErr:(NSError*)detail
{
    return [[OLiNetError alloc] initWithCode:code
                                 withDesc:desc
                            withDetailErr:detail];
}

- (OLiNetError *)initWithCode:(NSInteger)code
                  withDesc:(NSString*)desc
             withDetailErr:(NSError*)detail;
{
    if (self = [super init]) {
        self.code = code;
        self.description = desc;
        self.detail = detail;
    }
    return self;
}

- (void)description_:(NSString *)description_
{
    description = description_;
}

@end
