//
//  OLiHTTPRequestOperationManager.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "OLiHTTPRequestOperationManager.h"
#import "NSString+PublicEncrypt.h"

//此处不应该这样用
#import "OLiNetEngineSetting.h"

@interface OLiHTTPRequestOperationManager ()

@property (nonatomic, strong) dispatch_queue_t fileOperationQueue;

@end

@implementation OLiHTTPRequestOperationManager

- (dispatch_queue_t)fileOperationQueue
{
    if (!_fileOperationQueue) {
        _fileOperationQueue = dispatch_queue_create("com.BrooksWon.OLiHTTPRequestOperationManagerQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return _fileOperationQueue;
}

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
                                    cacheKey:(NSString *)cacheKey
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:parameters
                                                                       error:nil];
    
    [request setValue:@"OLiRequest" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:OLi_ProtocolVer forHTTPHeaderField:@"ProtocolVer"];//数据交换协议版本号
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:OLiRequestTimeoutInterval];
    [request setValue:@"de2a2f134a4702a5fd272a9ec8152c93" forHTTPHeaderField:@"apikey"];
//    [request setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if (cacheResponse) {
        AFHTTPRequestOperation *operation = [self requestOperationWithKey:cacheKey];
        if (operation) {
            if (success) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_USEC)), dispatch_get_main_queue(), ^(void) {
                    success(operation, nil);
                });
            }
            return operation;
        }
    }
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    return operation;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    return [super HTTPRequestOperationWithRequest:request
                                          success:success
                                          failure:failure];
}

- (NSString *)requestKeyWithDictionary:(NSDictionary *)dictionary digitalSign:(NSString *)digitalSign
{
    if (dictionary) {
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        if ([JSONData length] > 0) {
            NSString *JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            return [[NSString stringWithFormat:@"%@%@", JSONString, digitalSign] MD5EncodedString];
        }
    }
    return nil;
}

- (AFHTTPRequestOperation *)requestOperationWithKey:(NSString *)key
{
    if ([key length] > 0) {
        NSString *cacheFileName = [self cacheFileNameWithKey:key];
        NSDictionary *arrtibutes = [[NSFileManager defaultManager]attributesOfItemAtPath:cacheFileName error:nil];
        if (arrtibutes) {
            NSDate *createDate = arrtibutes[NSFileCreationDate];
            if (createDate) {
                NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:createDate];
                BOOL valid = interval < OLiRequestCacheRetainTime;
                if (valid) {
                    AFHTTPRequestOperation *operation = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFileName];
                    return operation ?: nil;
                }
            }
            dispatch_async(self.fileOperationQueue, ^{
                [[NSFileManager defaultManager] removeItemAtPath:cacheFileName error:nil];
            });
        }
    }
    return nil;
}

- (void)archiveRequestOperation:(AFHTTPRequestOperation *)requestOperation withKey:(NSString *)key
{
    if ([key length] > 0) {
        NSString *cacheFileName = [self cacheFileNameWithKey:key];
        if (![[NSFileManager defaultManager] fileExistsAtPath:cacheFileName]) {
            dispatch_async(self.fileOperationQueue, ^{
                [NSKeyedArchiver archiveRootObject:requestOperation toFile:cacheFileName];
            });
        }
    }
}

- (NSString *)cachePath
{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@", cachesDirectory, OLiRequestCacheFolderName];
    if([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    return path;
}

- (NSString *)cacheFileNameWithKey:(NSString *)key
{
    return [[self cachePath] stringByAppendingPathComponent:key];
}

@end
