//
//  ModelGroups.m
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import "ModelGroups.h"

@implementation ModelGroups

+ (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] parsingJsonWithDictionary:dict];
}

- (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *Arr = [NSMutableArray array];
        for (NSDictionary * __dic in self.groups) {
            [Arr addObject:__dic];
        }
        self.groups = Arr;
    }
    return self;
}


@end
