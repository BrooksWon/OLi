//
//  OLiNetEngine.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OLiRequestObjectDelegate.h"
@class OLiNetError;

typedef NS_ENUM(NSInteger, OLiNetworkReachabilityStatus) {
    OLiNetworkReachabilityStatusUnknown          = -1,
    OLiNetworkReachabilityStatusNotReachable     = 0,
    OLiNetworkReachabilityStatusReachableViaWWAN = 1,
    OLiNetworkReachabilityStatusReachableVia2G   = 2,
    OLiNetworkReachabilityStatusReachableVia3G   = 3,
    OLiNetworkReachabilityStatusReachableVia4G   = 4,
    OLiNetworkReachabilityStatusReachableViaWiFi
};

/** 自定义设置，供operationOptions集合内数据使用 */
extern NSString * const OLiRequestJSONString;
extern NSString * const OLiRequestServiceName;
extern NSString * const OLiRequestEntityObject;
extern NSString * const OLiRequestIsCache;
extern NSString * const OLiResponseEntityName;

/** 自定义设置，供响应回调options使用 */
extern NSString * const OLiCallBackResponse;
extern NSString * const OLiCallBackResponseString;
extern NSString * const OLiCallBackResponseData;
extern NSString * const OLiCallBackRequest;

typedef void(^OLiRequestProgressBlock)(NSUInteger receivedSize, long long expectedSize);
typedef void(^OLiRequestSuccessBlock)(id responseObject, NSDictionary *options);
typedef void(^OLiRequestFailBlock)(OLiNetError *error, NSDictionary *options);

typedef void(^OLiDownloadProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);

@interface OLiNetEngine : NSObject

/** 当前网络是否可用 */
@property (nonatomic, assign, readonly, getter = isReachable) BOOL reachable;
/** 当前网络状态 */
@property (nonatomic, assign, readonly) OLiNetworkReachabilityStatus networkReachabilityStatus;

/** 当前请求数 */
@property (nonatomic, assign, readonly) NSUInteger requestCount;
/** requestOperation集合 */
@property (nonatomic, strong, readonly) NSMutableDictionary *requestQueue;
/** 根据objectIdentifier保存的属性 */
@property (nonatomic, strong, readonly) NSMutableDictionary *operationOptions;

/** 发送请求
 *
 *  @param request 请求实体，需要实现OLiRequestObjectDelegate且类名以Request开头
 *
 *  @return objectIdentifier
 */
- (NSString *)sendRequest:(id<OLiRequestObjectDelegate>)request;

/** 根据objectIdentifier取消对应请求
 *
 *  @param key sendRequest返回值
 *
 *  @return 操作结果
 */
- (BOOL)cancelRequestWithKey:(NSString *)key;
/** 批量取消请求队列 */
- (BOOL)cancelRequestWithKeys:(NSArray *)keys;
/** 取消当前所有请求 */
- (void)cancelAllRequest;

/** 根据objectIdentifier获取request实体对象
 *
 *  @param key objectIdentifier
 *
 *  @return 符合OLiRequestObjectDelegate的reqeust实体对象
 */
- (id<OLiRequestObjectDelegate>)requestObjectWithKey:(NSString *)key;

@end

@interface OLiNetEngine (SharedNetEngine)

/**
 *  协议扩展，创建请求引擎单例对象，不建议调用
 *
 *  @return 单例对象
 */
+ (id)sharedNetEngine;

@end
