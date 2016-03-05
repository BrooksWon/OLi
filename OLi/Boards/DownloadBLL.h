//
//  DownloadBLL.h
//  OLi
//
//  Created by Brooks on 16/3/5.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseDownload.h"
@protocol DownloadBLLDelegate <NSObject>

-(void)after_downloadLoadDataFromServer;

@end

@interface DownloadBLL : NSObject

@property (nonatomic, strong) ResponseDownload *responseDemoEnity;
@property (nonatomic, weak) id<DownloadBLLDelegate> delegate;

-(void)downloadloadDataFromServer;

@end
