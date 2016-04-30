//
//  ResponseGetFavorites.h
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RspInfo;
@class QuestionIds;

@interface ResponseGetFavorites : NSObject

@property(nonatomic, strong)RspInfo *rspInfo;
@property(nonatomic, strong)QuestionIds *questionIds;

@end
