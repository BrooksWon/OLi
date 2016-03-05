//
//  OLiHTTPRequestOperationManager.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

static NSString *const  OLiRequestCacheFolderName = @"RequestCache";
static NSUInteger const OLiRequestCacheRetainTime = 60 * 5; //5分钟
static NSUInteger const OLiRequestTimeoutInterval = 40;     //40s

@interface OLiHTTPRequestOperationManager : AFHTTPRequestOperationManager

/**
 *  http  请求
 *
 *  @param method        请求方法(GET/POST/PUT/DELETE)
 *  @param url_          请求url
 *  @param parameters_   参数
 *  @param success       成功回调
 *  @param failure       失败回调
 *  @param cacheResponse 是否缓存
 *  @param cacheKey      缓存key
 *
 *  @return 当前请求的operation
 */
-(AFHTTPRequestOperation*)OLi_Request_Method:(NSString *)method
                                   URLString:(NSString*)URLString
                                  parameters:(id)parameters
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                               cacheResponse:(BOOL)cacheResponse
                                    cacheKey:(NSString *)cacheKey;

/**
 *  生成 HTTP请求的 唯一标示符 key
 *
 *  @param dictionary    请求参数
 *  @param digitalSign   一些额外的参数（为了保证的生成key的唯一性）
 *
 *  @return 当前请求的operation 唯一标示符 key
 */
- (NSString *)requestKeyWithDictionary:(NSDictionary *)dictionary digitalSign:(NSString *)digitalSign;

/**
 *  根据请求的唯一key，将请求缓存到本地
 *
 *  @param requestOperation    具体某个请求
 *  @param digitalSign          某个请求的key
 */
- (void)archiveRequestOperation:(AFHTTPRequestOperation *)requestOperation withKey:(NSString *)key;

@end
