//
//  OLiRequestObjectDelegate.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OLiRequestObjectDelegate <NSObject>

@required

- (NSString *)interfaceURL; /** 中间层定义的链接地址 */
- (NSString *)serviceName;  /** 中间层定义的服务名 */

/** 客户端判断是否需要缓存
 *  缓存统一设置：默认5分钟内有效，暂无单独设置
 */
- (BOOL)needCache;

/**
 * HTTP 请求方式 (GET/POST/PUT/DELETE)
 */
- (NSString *)requestMethodName;

/*!
 *  @brief 是否为下载请求
 *
 *  @return 默认为NO
 */
- (BOOL)isDownloadRequest;

/*!
 *  @brief 是否为下上传请求
 *
 *  @return 默认为NO
 */
- (BOOL)isUploadRequest;

@end
