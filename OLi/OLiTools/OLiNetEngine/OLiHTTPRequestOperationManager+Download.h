//
//  OLiHTTPRequestOperationManager+Download.h
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiHTTPRequestOperationManager.h"

typedef void(^DownloadProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);

@interface OLiHTTPRequestOperationManager (Download)


/*!
 *  @brief 断点下载
 *
 *  @param method                方法类型
 *  @param URLString             请求地址
 *  @param parameters            参数
 *  @param success               下载完成
 *  @param failure               下载失败
 *  @param downloadProgressBlock 下载进度等
 *
 *  @return 下载操作
 */
-(AFHTTPRequestOperation*)OLi_Request_Method:(NSString *)method
                                   URLString:(NSString*)URLString
                                  parameters:(id)parameters
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                       downloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadProgressBlock;

@end
