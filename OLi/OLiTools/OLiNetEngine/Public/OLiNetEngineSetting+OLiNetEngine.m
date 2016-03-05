//
//  OLiNetEngineSetting+OLiNetEngine.m
//  OLiNetEngine
//
//  Created by Brooks on 15/7/1.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "OLiNetEngineSetting+OLiNetEngine.h"

@implementation OLiNetEngineSetting (OLiNetEngine)

+ (OLiNetEngine *)currentNetEngine
{
    return [OLiNetEngine sharedNetEngine];
}

@end
