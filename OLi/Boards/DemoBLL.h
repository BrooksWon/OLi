//
//  DemoBLL.h
//  OLiNetEngine
//
//  Created by Brooks on 15/7/1.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseDemoEnity.h"

@protocol DemoBLLDelegate <NSObject>

-(void)after_loadDataFromServer;

@end

@interface DemoBLL : NSObject

@property (nonatomic, strong) ResponseDemoEnity *responseDemoEnity;
@property (nonatomic, weak) id<DemoBLLDelegate> delegate;

-(void)loadDataFromServer;

@end
