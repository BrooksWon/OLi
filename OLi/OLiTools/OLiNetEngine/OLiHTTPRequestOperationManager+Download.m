//
//  OLiHTTPRequestOperationManager+Download.m
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiHTTPRequestOperationManager+Download.h"
#import "OLiNetEngineSetting.h"

@implementation OLiHTTPRequestOperationManager (Download)

static NSOperationQueue* OLiHTTPRequestOperationDownloadQueue() {
    static NSOperationQueue *downloadQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadQueue = [[NSOperationQueue alloc] init];;
    });
    
    return downloadQueue;
}


-(AFHTTPRequestOperation*)OLi_Request_Method:(NSString *)method
                                   URLString:(NSString*)URLString
                                  parameters:(id)parameters
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                       downloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadProgressBlock
{
    
    NSOperationQueue *downloadQueue = OLiHTTPRequestOperationDownloadQueue();
    
    // 1. 建立请求
//    NSURLRequest *request = [_httpClient requestWithMethod:@"GET" path:@"download/Objective-C2.0.zip" parameters:nil];
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
    
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
//    // 2. 操作
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // 下载
    // 指定文件保存路径，将文件保存在沙盒中
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docs[0] stringByAppendingPathComponent:@"download.zip"];
    
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    // 设置下载进程块代码
    /*
     21      bytesRead                      当前一次读取的字节数(100k)
     22      totalBytesRead                 已经下载的字节数(4.9M）
     23      totalBytesExpectedToRead       文件总大小(5M)
     24      */
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        // 设置进度条的百分比
//        CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
//        _progressView.progress = precent;
        downloadProgressBlock(bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
    // 设置下载完成操作
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responSEObject) {
        // 下载完成之后，解压缩文件
        /*
         39          参数1:要解结压缩的文件名及路径 path - > download.zip
         40          参数2:要解压缩到的位置，目录    - > document目录
         41          */
        [SSZipArchive unzipFileAtPath:path toDestination:docs[0]];
        // 解压缩之后，将原始的压缩包删除
        // NSFileManager专门用于文件管理操作，可以删除，复制，移动文件等操作
        // 也可以检查文件是否存在
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
        // 下一步可以进行进一步处理，或者发送通知给用户。
        NSLog(@"下载成功");
        success(operation, responSEObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        failure(operation, error);
    }];
    
    // 启动下载
    [downloadQueue addOperation:op];
}


@end
