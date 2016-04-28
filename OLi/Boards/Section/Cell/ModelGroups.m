//
//  ModelGroups.m
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import "ModelGroups.h"

@implementation ModelGroups

+ (instancetype) parsingDataWithObject:(id)obj {
   return [[self alloc] parsingDataWithObject:obj];
}

- (instancetype) parsingDataWithObject:(id)obj {
    if (self == [super init]) {
        @try {
            self.subjectID = [obj valueForKeyPath:@"id"];
            self.name = [obj valueForKeyPath:@"name"];
        } @catch (NSException *exception) {
            //
        } @finally {
            //
        }
    }
    return self;
}



@end
