//
//  ChapterBLL.h
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChapterBLL : NSObject
- (void)loadChapterWithCallback:(void (^) (id objc))callback;
@end
