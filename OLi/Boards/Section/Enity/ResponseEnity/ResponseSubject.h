//
//  ResponseSubject.h
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RspInfo;
@class SubjectList;

@interface ResponseSubject : NSObject

@property (nonatomic, strong)RspInfo *rspInfo;

@property (nonatomic, strong)SubjectList *subjectList;

@end

@interface SubjectList : NSObject

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;

@end