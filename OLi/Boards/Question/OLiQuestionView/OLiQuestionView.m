//
//  OLiQuestionView.m
//  OLi
//
//  Created by Brooks on 16/3/24.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiQuestionView.h"

@interface OLiQuestionView()
@property(nonatomic, strong, readwrite) UIView *containerView;
@property(nonatomic, strong, readwrite) UIImageView *imv;
@end

@implementation OLiQuestionView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.containerView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:self.containerView];
    
    //subViews
    self.imv = [[UIImageView alloc] initWithFrame:self.containerView.bounds];
    [self.containerView addSubview:self.imv];
}

- (void)setImageName:(NSString *)imageName {
    if (imageName) {
        [self.imv setImage:[UIImage imageNamed:imageName]];
    }
}

@end
