//
//  OLiRequestObject.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "OLiRequestObject.h"
#import "NSObject+OLiNetEngine.h"

NSString *const OLiRequestMethodName_GET_Key    = @"GET";
NSString *const OLiRequestMethodName_POST_Key   = @"POST";
NSString *const OLiRequestMethodName_PUT_Key    = @"PUT";
NSString *const OLiRequestMethodName_DELETE_Key = @"DELETE";

@interface OLiRequestObject ()

@property (nonatomic, assign, readwrite) BOOL cancelled;
@property (nonatomic, assign, readwrite) BOOL executing;

@property (nonatomic, strong) NSString *requestKey;

@end

@implementation OLiRequestObject

-(id)init
{
    self = [super init];
    
    if (self) {
        _requestMethodName = OLiRequestMethodName_GET_Key; // default ‘GET’
        _executing = YES;
        _cancelled = NO;
        _successBlock = nil;
        _failBlock = nil;
        _needCache = NO;
        _isDownloadRequest = NO;
        _isUploadRequest = NO;
    }
    return self;
}

- (void)start {
    self.requestKey = [[OLiNetEngineSetting currentNetEngine] sendRequest:self];
    self.executing = YES;
    self.cancelled = NO;
}

- (void)cancel {
    if (self.executing) {
        [[OLiNetEngineSetting currentNetEngine] cancelRequestWithKey:self.requestKey];
        self.executing = NO;
        self.cancelled = YES;
    }
}

- (void)startWithSuccessBlock:(OLiRequestSuccessBlock)success failBlock:(OLiRequestFailBlock)fail {
    self.successBlock = success;
    self.failBlock = fail;
    [self start];
}

- (void)startWithSuccessBlock:(OLiRequestSuccessBlock)success
                    failBlock:(OLiRequestFailBlock)fail
        downloadProgressBlock:(OLiDownloadProgressBlock)progressBlock {
    self.successBlock = success;
    self.failBlock = fail;
    self.downloadProgressBlock = progressBlock;
    [self start];
}

- (void)clearCompletionBlock {
    self.successBlock = nil;
    self.failBlock = nil;
    self.downloadProgressBlock = nil;
}

@end

@implementation OLiRequestObject (RequestJSONString)

- (NSMutableDictionary *)propertyValueDictionary
{
    NSMutableDictionary *propertyValueDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{@"servicename":self.serviceName}];
    if ([self respondsToSelector:@selector(propertyDictionary)]) {
        [propertyValueDictionary addEntriesFromDictionary:[self performSelector:@selector(propertyDictionary)]];
    }
    return propertyValueDictionary;
}

- (NSString *)requestJSONString
{
    NSMutableDictionary *requestDictionary = [self propertyValueDictionary];    
    
    NSError *error = nil;
    NSString *requestJSONString = nil;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:requestDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (JSONData) {
        requestJSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    }
    
#ifdef OLi_HTTP_DEBUG_REQUEST
    OLiLog(@"request is\n%@", requestJSONString);
#endif
    return requestJSONString;
}

@end