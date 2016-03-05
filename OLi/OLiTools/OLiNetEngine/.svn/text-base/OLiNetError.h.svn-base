//
//  OLiNetError.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLiNetError : NSObject

@property (nonatomic, copy) NSString *entityName;/* 响应实体的名字 */
@property (nonatomic, copy, setter = description_:) NSString *description; /* 响应描述 */
@property (nonatomic, assign) NSInteger code; /* 响应码 */
@property (nonatomic, copy) NSError *detail; /* 响应 错误描述 */
@property (nonatomic, strong) id fileBody; /* 响应体 */

/* 创建网络错误实例 */
+ (OLiNetError *)OLiNetErrorWithCode:(NSInteger)_code withDesc:(NSString*)_desc withDetailErr:(NSError*)_detail;

@end
