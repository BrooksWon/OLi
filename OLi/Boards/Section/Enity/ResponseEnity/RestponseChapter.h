//
//  RestponseChapter.h
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RspInfo;
@class ChapterList;

@interface RestponseChapter : NSObject

@property (nonatomic, strong)RspInfo *rspInfo;

@property (nonatomic, copy)ChapterList *chapterList;

@end

@interface ChapterList : NSObject

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *Progress;
@property (nonatomic, copy)NSString *CorrectRate;
@property (nonatomic, copy)NSString *QuestionQuantity;

@end

//{
//    "rspInfo": {
//        "rspType": "响应类型",
//        "rspCode": "1000",
//        "rspDesc": "获取成功"
//    },
//    "rspData": {
//        "chapterList": [
//                        {
//                            "id": "1",
//                            "name": "第一章 总论",
//                            "QuestionQuantity": "0",
//                            "Progress": "0",
//                            "CorrectRate": "0"
//                        },
//                        {
//                            "id": "2",
//                            "name": "第二章 会计要素与会计等式",
//                            "QuestionQuantity": "0",
//                            "Progress": "0",
//                            "CorrectRate": "0"
//                        }
//                        ]
//    }
//}
