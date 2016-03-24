//
//  OLiQuestionBoard.h
//  OLi
//
//  Created by Brooks on 16/3/24.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiBaseBoard.h"
#import "iCarousel.h"

@interface OLiQuestionBoard : OLiBaseBoard <iCarouselDataSource, iCarouselDelegate>

@property(nonatomic, strong) IBOutlet iCarousel *carousel;
@property(nonatomic, strong) IBOutlet UIButton *addButton;

@end
