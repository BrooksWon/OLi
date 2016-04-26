//
//  UIViewController+Analytics.m
//  OLi
//
//  Created by Brooks on 16/4/26.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "UIViewController+Analytics.h"
#import <objc/runtime.h>
#import "TalkingData.h"

@implementation UIViewController (Analytics)

+(void)load {
    [self swizzleInstanceSelector:@selector(viewWillAppear:) withNewSelector:@selector(Analytics_viewWillAppear:)];
    [self swizzleInstanceSelector:@selector(viewWillDisappear:) withNewSelector:@selector(Analytics_viewWillDisappear:)];
}

- (void)Analytics_viewWillAppear:(BOOL)animated {
    [self Analytics_viewWillAppear:animated];
    
    [TalkingData trackPageBegin:NSStringFromClass(self.class)];
}

- (void)Analytics_viewWillDisappear:(BOOL)animated {
    [self Analytics_viewWillDisappear:animated];
    
    [TalkingData trackPageEnd:NSStringFromClass(self.class)];
}

#pragma tools method
+ (void)swizzleInstanceSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
    Method newMethod = class_getInstanceMethod(self.class, newSelector);
    
    BOOL methodAdded = class_addMethod(self.class,
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod(self.class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, originalMethod);
    }
}


@end
