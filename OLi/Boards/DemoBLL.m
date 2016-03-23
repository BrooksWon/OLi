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
    req.courseId=@"2";
    
    __weak typeof(self) weakSelf = self;
    
//    [[AFHTTPRequestOperationManager manager] GET:@"http://123.56.193.250:8088//Question/GetPaperInfo?" parameters:@{@"courseId":@"2"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //
//    }];
    
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
