//
//  ModelGroups.h
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelGroups : NSObject
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, copy) NSString *name;
/**
 *  记录这行是否被打开
 */
@property (nonatomic, getter=isOpen) BOOL isOpen;

+ (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict;
- (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict;
@end
