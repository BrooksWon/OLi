//
//  OLiRequestObject.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const OLiRequestMethodName_GET_Key;
FOUNDATION_EXPORT NSString * const OLiRequestMethodName_POST_Key;
FOUNDATION_EXPORT NSString * const OLiRequestMethodName_PUT_Key;
FOUNDATION_EXPORT NSString * const OLiRequestMethodName_DELETE_Key;

#import "OLiNetEngine.h"
#import "OLiNetEngineSetting+OLiNetEngine.h"

@interface OLiRequestObject : NSObject<OLiRequestObjectDelegate>

/** 默认实现OLiRequestObjectDelegate协议 */
/** 链接地址(一般是二级地址)
 */
@property (nonatomic, strong) NSString *interfaceURL;
/** 中间层定义的服务名 */
@property (nonatomic, strong) NSString *serviceName;
/** 客户端判断是否需要缓存
 *  缓存统一设置：默认5分钟内有效，暂无单独设置, default is 'NO'
 */
@property (nonatomic, assign) BOOL needCache;

/**
 * HTTP 请求方式 (GET/POST/PUT/DELETE)  default ‘GET’
 */
@property (nonatomic, strong) NSString *requestMethodName;

/** 请求成功回调，可不设置，默认nil */
@property (nonatomic, copy) OLiRequestSuccessBlock successBlock;
/** 请求失败回调，可不设置，默认nil */
@property (nonatomic, copy) OLiRequestFailBlock failBlock;

/** 请求进度回调，可不设置，默认nil */
@property (nonatomic, copy) OLiRequestProgressBlock progressBlock;

/** 是否进行中 */
@property (nonatomic, assign, readonly, getter = isExecuting) BOOL executing;

/** 是否已取消 */
@property (nonatomic, assign, readonly, getter = isCancelled) BOOL cancelled;
/** 取消当前请求 */
- (void)cancel;

/** 对已保存的请求实体直接发起请求*/
- (void)start;


/**
 *  对successBlock和failBlock赋值并执行start
 *
 *  @param success 同successBlock
 *  @param fail    同failBlock
 */
- (void)startWithSuccessBlock:(OLiRequestSuccessBlock)success
                    failBlock:(OLiRequestFailBlock)fail;

/** 对successBlock和failBlock进行nil赋值，设置executing为nil */
- (void)clearCompletionBlock;

@end

@interface OLiRequestObject (RequestJSONString)

- (NSMutableDictionary *)propertyValueDictionary;
- (NSString *)requestJSONString;

@end
