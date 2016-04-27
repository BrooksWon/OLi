//
//  OLiNetEngine.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "OLiNetEngine.h"

#import "Reachability.h"
#import "NSObject+OLiNetEngine.h"
#import "OLiHTTPRequestOperationManager.h"
#import "OLiHTTPRequestOperationManager+Download.h"
#import "OLiNetError.h"
#import "OLiRequestObject.h"
#define kRequestClassPrefix     @"Request"
#define kResponseClassPrefix    @"Response"

/** 自定义设置，供operationOptions集合内数据使用 */
NSString *const OLiRequestJSONString     = @"OLiRequestJSONString";
NSString *const OLiRequestServiceName    = @"OLiRequestServiceName";
NSString *const OLiRequestEntityObject   = @"OLiRequestEntityObject";
NSString *const OLiRequestIsCache        = @"OLiRequestIsCache";
NSString *const OLiResponseEntityName    = @"OLiResponseEntityName";

/** 自定义设置，供响应回调options使用 */
NSString *const OLiCallBackResponse      = @"OLiCallBackResponse";
NSString *const OLiCallBackResponseString= @"OLiCallBackResponseString";
NSString *const OLiCallBackResponseData  = @"OLiCallBackResponseData";
NSString *const OLiCallBackRequest       = @"OLiCallBackRequest";

@interface OLiNetEngine()

@property (nonatomic, strong, readwrite) NSMutableDictionary *requestQueue;
@property (nonatomic, strong, readwrite) NSMutableDictionary *operationOptions;
@property (nonatomic, strong) OLiHTTPRequestOperationManager *operationManager;

@end

@implementation OLiNetEngine

- (instancetype)init
{
    if (self = [super init]) {
        self.requestQueue = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL) isReachable
{
    if (OLiNetworkReachabilityStatusNotReachable == [self networkReachabilityStatus] || OLiNetworkReachabilityStatusUnknown == [self networkReachabilityStatus])
    {
        return NO;
    }else{
        return YES;
    }
    
}

- (OLiNetworkReachabilityStatus) networkReachabilityStatus
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    [reach startNotifier];
    
    NetworkStatus status=[reach currentReachabilityStatus];
    
    switch (status)
    {
        case NotReachable:
            return OLiNetworkReachabilityStatusNotReachable;
        case ReachableViaWWAN:
            return OLiNetworkReachabilityStatusReachableViaWWAN;
        case ReachableVia2G:
            return OLiNetworkReachabilityStatusReachableVia2G;
        case ReachableVia3G:
            return OLiNetworkReachabilityStatusReachableVia3G;
        case ReachableVia4G:
            return OLiNetworkReachabilityStatusReachableVia4G;
        case ReachableViaWiFi:
            return OLiNetworkReachabilityStatusReachableViaWiFi;
        default:
            return OLiNetworkReachabilityStatusUnknown;
    }
}

- (NSUInteger)requestCount
{
    return self.requestQueue.count;
}

#pragma mark -
- (NSString *)sendRequest:(id<OLiRequestObjectDelegate>)request
{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *requestJSONString = nil;
    if ([request respondsToSelector:@selector(requestJSONString)]) {
        requestJSONString = [request performSelector:@selector(requestJSONString)];
    }
    __weak __typeof(self) weakSelf = self;
    if (!self.operationManager) {
        self.operationManager = [OLiHTTPRequestOperationManager manager];
        self.operationManager.operationQueue.maxConcurrentOperationCount = 16;
    }
    NSMutableDictionary *propertyValueDictionary = nil;
    if ([request respondsToSelector:@selector(propertyValueDictionary)]) {
        propertyValueDictionary = [request performSelector:@selector(propertyValueDictionary)];
    }
    
    NSString *requestKey = [self.operationManager requestKeyWithDictionary:propertyValueDictionary digitalSign:[NSString stringWithFormat:@"W%@J%@Y", [request interfaceURL], [request serviceName]]];
    
    NSString *responseClassName = [self responseClassNameWithRequest:request];
    NSDictionary *options = @{OLiResponseEntityName: responseClassName,
                              OLiRequestEntityObject:request,
                              OLiRequestIsCache: @([request needCache]),
                              OLiRequestServiceName: [request serviceName] ?: @"无serviceName,可能是GET请求",
                              OLiRequestJSONString:requestJSONString ?: @"无参数，可能是GET请求"};
    if (!self.operationOptions) {
        self.operationOptions = [[NSMutableDictionary alloc] init];
    }
    self.operationOptions[requestKey] = options;
    
    AFHTTPRequestOperation *requestOperation = nil;
    
    if([request isDownloadRequest]){
        requestOperation = [self.operationManager OLi_Request_Method:request.requestMethodName
                                                           URLString:request.interfaceURL
                                                          parameters:propertyValueDictionary
                                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                 [weakSelf requestFinishedWithOperation:operation requestKey:requestKey];
                                                             }
                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                 [weakSelf requestFinishedWithOperation:operation requestKey:requestKey];
                                                             } downloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
#warning 未完待续
                                                                 //
                                                                 if ([request respondsToSelector:@selector(downloadProgressBlock)]) {
                                                                     OLiDownloadProgressBlock downloadProgressBlock = [request performSelector:@selector(downloadProgressBlock)];
                                                                     if (downloadProgressBlock) dispatch_async(dispatch_get_main_queue(), ^{ downloadProgressBlock(bytesRead, totalBytesRead, totalBytesExpectedToRead); });
                                                                 }
                                                             }];
    }if ([request isUploadRequest]) {
#warning 未完待续
        //
    }else{        
        requestOperation = [self.operationManager OLi_Request_Method:request.requestMethodName
                                                           URLString:request.interfaceURL
                                                          parameters:propertyValueDictionary
                            //#warning 待优化
                                                             success:^(AFHTTPRequestOperation *operation, id responseObject)
                            {
                                [weakSelf requestFinishedWithOperation:operation requestKey:requestKey];
                            }
                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
                            {
                                [weakSelf requestFinishedWithOperation:operation requestKey:requestKey];
                            }
                                                       cacheResponse:[request needCache]
                                                            cacheKey:requestKey];
        
        [self.requestQueue setValue:requestOperation forKey:requestKey];
    }
    
    return requestKey;
}

- (void)requestFinishedWithOperation:(AFHTTPRequestOperation *)operation requestKey:(NSString *)requestKey
{
    NSString *responseString = [[operation responseString] stringByReplacingOccurrencesOfString:@"&#160;" withString:@""];
    NSDictionary *options = self.operationOptions[requestKey];
    
    if (!options) {
#ifdef OLi_Server_Debug
        OLiLog(@"请求已被取消");   //请求缓存机制可以更优化，数组保存对象控制
#endif
        return;
    }
    
#ifdef OLi_HTTP_DEBUG_REQUEST_DOMAIN
    OLiLog(@"request url is\n%@\nserviceName is\n%@", [operation.request.URL absoluteString],
          options[OLiRequestServiceName]);
#endif
    
#ifdef OLi_HTTP_DEBUG_RESPONSE
    if (responseString) {
        const char *str = [responseString UTF8String];
        OLiLog(@"response is\n%@", [NSString stringWithCString:str encoding:NSUTF8StringEncoding]);
    }
#endif
    
    id requestEntityObject = options[OLiRequestEntityObject];
    
    NSMutableDictionary *callBackOptions = [@{} mutableCopy];
    [callBackOptions setValue:operation.response ?: @"" forKey:OLiCallBackResponse];
    [callBackOptions setValue:operation.responseString ?: @"" forKey:OLiCallBackResponseString];
    [callBackOptions setValue:operation.responseData ?: @"" forKey:OLiCallBackResponseData];
    [callBackOptions setValue:operation.request ?: @"" forKey:OLiCallBackRequest];
    
    if (operation.response.statusCode == 200)
    {
        id responseObject = [self responseObjectWithJSONString:responseString className:options[OLiResponseEntityName]];
        
        if (responseObject) {
            if ([responseObject isKindOfClass:[OLiNetError class]]) {
                if ([requestEntityObject respondsToSelector:@selector(failBlock)]) {
                    OLiRequestFailBlock failBlock = [requestEntityObject performSelector:@selector(failBlock)];
                    if (failBlock) dispatch_async(dispatch_get_main_queue(), ^{ failBlock(responseObject, callBackOptions); });
                }
            }
            else {
                //缓存正确的请求
                if ([options[OLiRequestIsCache] boolValue]) {
                    [self.operationManager archiveRequestOperation:operation withKey:requestKey];
                }
                
                if ([requestEntityObject respondsToSelector:@selector(successBlock)]) {
                    OLiRequestSuccessBlock successBlock = [requestEntityObject performSelector:@selector(successBlock)];
                    if (successBlock) dispatch_async(dispatch_get_main_queue(), ^{ successBlock(responseObject, callBackOptions); });
                }
            }
#ifdef OLi_Server_Debug
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kDEBUGMONITORINTERFACE" object:@[responseObject]];
#endif
        }
        else {
#ifdef OLi_Server_Debug
            OLiLog(@"响应%@类名未按开发规范定义", options[OLiResponseEntityName]);
            [NSException raise:NSInvalidArgumentException format:@"请联系BrooksWon"];
#endif
        }
    }
    else {
        OLiNetError *error = [OLiNetError OLiNetErrorWithCode:operation.response.statusCode
                                            withDesc:@"哎呀，您的热情让服务器受宠若惊，先去其他页面逛逛吧"
                                       withDetailErr:operation.error];
        error.entityName = options[OLiResponseEntityName];
        
        if ([requestEntityObject respondsToSelector:@selector(failBlock)]) {
            OLiRequestFailBlock failBlock = [requestEntityObject performSelector:@selector(failBlock)];
            if (failBlock) dispatch_async(dispatch_get_main_queue(), ^{ failBlock(error, callBackOptions); });
        }
    }
    [self removeRequestQueueWithKey:requestKey];
}

- (id)responseObjectWithJSONString:(NSString *)JSONString className:(NSString *)className
{
    id returnObject = nil;
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    if (JSONDictionary)
    {
        if (JSONDictionary && [JSONDictionary isKindOfClass:[NSDictionary class]]) {
            if ([JSONDictionary objectForKey:@"rspData"]) {//为了兼容rspData外面包了一层格式，无任何业务意义
                NSMutableDictionary *editDic = [[NSMutableDictionary alloc] initWithDictionary:JSONDictionary];
                [editDic addEntriesFromDictionary:(NSDictionary*)[JSONDictionary objectForKey:@"rspData"]];
                returnObject = [self objectWithDictionary:editDic className:className];
            }else {
                returnObject = [self objectWithDictionary:JSONDictionary className:className];
            }
        }
        else
        {
            OLiNetError *error = [[OLiNetError alloc] init];
            error.entityName = className;
            error.description = @"服务器暂无响应，请稍后再试";
            error.fileBody = JSONDictionary;// 如果解析出错，就把json扔给业务端同学

            returnObject = error;
        }
    }
    return returnObject;
}

#pragma mark -
- (BOOL)cancelRequestWithKey:(NSString *)key
{
    if ([key length] > 0) {
        AFHTTPRequestOperation *request = [self.requestQueue valueForKey:key];
        if (request) {
            [request cancel];
            [self removeRequestQueueWithKey:key];
            return YES;
        }
    }
    return NO;
}

- (void)removeRequestQueueWithKey:(NSString *)key
{
    if ([key length] > 0) {
        [self.requestQueue removeObjectForKey:key];
        [self.operationOptions removeObjectForKey:key];
        
        if (self.requestCount == 0) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }
}

- (BOOL)cancelRequestWithKeys:(NSArray *)keys
{
    if ([keys isKindOfClass:[NSArray class]]) {
        __weak typeof(self) weakSelf = self;
        [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
         {
             [weakSelf cancelRequestWithKey:key];
         }];
        return YES;
    }
    return NO;
}

- (void)cancelAllRequest
{
    [self.requestQueue enumerateKeysAndObjectsUsingBlock:^(id key, AFHTTPRequestOperation *request, BOOL *stop)
     {
         [request cancel];
     }];
    [self.requestQueue removeAllObjects];
    [self.operationOptions removeAllObjects];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark -
- (id)requestObjectWithKey:(NSString *)key
{
    NSDictionary *options = self.operationOptions[key];
    return options[OLiRequestEntityObject];
}

#pragma mark -
- (NSString *)responseClassNameWithRequest:(id<OLiRequestObjectDelegate>)request
{
    NSString *responseClassName = nil;
    NSString *requestClassName = NSStringFromClass([request class]);
    if ([requestClassName hasPrefix:kRequestClassPrefix])
    {
        responseClassName = [requestClassName stringByReplacingOccurrencesOfString:kRequestClassPrefix withString:kResponseClassPrefix];
    }
    else
    {
#ifdef OLi_Server_Debug
        OLiLog(@"请求%@类名未按开发规范定义", requestClassName);
        [NSException raise:NSInvalidArgumentException format:@"请联系Brooks"];
#endif
    }
    return responseClassName;
}

@end


@implementation OLiNetEngine (SharedNetEngine)

+(id)sharedNetEngine
{
    static OLiNetEngine *netEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netEngine = [[self alloc] init];
    });
    return netEngine;
}

@end
