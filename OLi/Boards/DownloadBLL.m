//
//  DownloadBLL.m
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "DownloadBLL.h"
#import "ResponseDownload.h"
#import "RequestDownload.h"
@implementation DownloadBLL
-(void)loadDataFromServer
{
    RequestDownload *req = [[RequestDownload alloc] init];
    req.username = @"FBL10086";
    req.password = @"111111FB";
    req.taskId = @"101";
    
    
    __weak typeof(self) weakSelf = self;
    //
    //    [[AFHTTPRequestOperationManager manager] GET:@"http://v.juhe.cn/weather/index" parameters:@{@"phone":@"18301596978",@"password":@"jianyu996"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        //
    //    }];
    
    //http://api.fblife.com/bbsapinew/login.php?username=FBL10086&password=111111FB&formattype=json&token=
    
    [req startWithSuccessBlock:^(id responseObject, NSDictionary *options)
     {
         
         NSLog(@"responseObject = %@, options = %@", responseObject, options);
         
         if (responseObject) {
             self.responseDemoEnity = (ResponseDownload*)responseObject;
         }
         [weakSelf.delegate after_loadDataFromServer];
         
     }failBlock:^(OLiNetError *error, NSDictionary *options)
     {
         NSLog(@"error = %@, options = %@", error, options);
         
         [weakSelf.delegate after_loadDataFromServer];
     }];
}
@end
