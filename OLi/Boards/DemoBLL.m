//
//  DemoBLL.m
//  OLiNetEngine
//
//  Created by Brooks on 15/7/1.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "DemoBLL.h"

#import "RequestDemoEnity.h"

#import "AFNetworking.h"

@implementation DemoBLL

-(void)loadDataFromServer
{
    RequestDemoEnity *req = [[RequestDemoEnity alloc] init];
    req.username = @"FBL10086";
    req.password = @"111111FB";
    req.formattype = @"json";
    req.token = nil;
    
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
            self.responseDemoEnity = (ResponseDemoEnity*)responseObject;
        }
         [weakSelf.delegate after_loadDataFromServer];
         
    }failBlock:^(OLiNetError *error, NSDictionary *options)
    {
        NSLog(@"error = %@, options = %@", error, options);
        
        [weakSelf.delegate after_loadDataFromServer];
    }];
}

@end
