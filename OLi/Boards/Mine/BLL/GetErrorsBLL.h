//
//  GetErrorsBLL.h
//  OLi
//
//  Created by Brooks on 16/4/30.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetErrorsBLL : NSObject
- (void)getErrorsWithUserId:(NSString*)userId chapterId:(NSString*)chapterId callback:(void (^) (id objc))callback;
@end
