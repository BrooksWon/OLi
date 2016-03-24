//
//  OLiQuestionBoard.m
//  OLi
//
//  Created by Brooks on 16/3/24.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiQuestionBoard.h"
#import "OLiQuestionView.h"
#import "OLiToast.h"

@interface OLiQuestionBoard ()
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation OLiQuestionBoard

- (void)setUp
{
    //set up data
    self.items = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        [self.items addObject:@(i)];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUp];
    [self.carousel reloadData];
    self.carousel.pagingEnabled = YES;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.bounceDistance = 5;
    self.carousel.backgroundColor = [UIColor redColor];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.items count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[OLiQuestionView alloc] initWithFrame:CGRectMake(0,0, self.carousel.bounds.size.width, self.carousel.bounds.size.height)];
    }
    OLiQuestionView *qView = (OLiQuestionView*)view;
    qView.imageName = [NSString stringWithFormat:@"page%@", ((NSNumber*)self.items[index]).description];
    qView.backgroundColor = [UIColor greenColor];
    return qView;
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.items)[(NSUInteger)index];
    NSLog(@"Tapped view number: %@", item);
    if ((index+1)%2) {
        [OLiToast showBottomWithText:@"\n恭喜，回答正确！\n"
                        bottomOffset:0
                            duration:0.7
                     backgroundColor:[UIColor blueColor]];
    }else {
        [OLiToast showBottomWithText:@"哎呀，答错啦！\n正确答案：A"
                        bottomOffset:0
                            duration:0.7
                     backgroundColor:[UIColor redColor]];
    }
    [self showAddButton:index];
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}

- (void)showAddButton:(NSInteger)index {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
//        OLiQuestionView *itemView = (OLiQuestionView*)[self.carousel itemViewAtIndex:index];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        btn.backgroundColor = [UIColor blueColor];
//        [btn setTitle:@"添加错题本" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btn.frame = CGRectMake(0, itemView.containerView.bounds.size.height-40, itemView.containerView.bounds.size.width, 40);
//        [itemView.containerView addSubview:btn];
//        
//        // update itemView frame
//        CGRect frame = itemView.imv.frame;
//        itemView.imv.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-btn.frame.size.height);
////        [self.carousel reloadItemAtIndex:index animated:NO];
//        [itemView layoutIfNeeded];
        
        if (index+1<self.items.count) {
            [self.carousel scrollToItemAtIndex:index+1 animated:YES];
        }
    });
}

- (void)dealloc {
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
}

@end
