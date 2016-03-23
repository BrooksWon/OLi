//
//  OLiTableViewHeaderView.h
//  OLi
//
//  Created by Brooks on 16/3/23.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModelGroups.h"
@class OLiTableViewHeaderView;

@protocol OLiTableViewHeaderViewDelegate <NSObject>
- (void)OLiTableViewHeaderView:(OLiTableViewHeaderView *)view didButton:(UIButton *)sender;
@end

@interface OLiTableViewHeaderView : UITableViewHeaderFooterView

+(OLiTableViewHeaderView *)OLiTableViewHeaderView:(UITableView *)tableView;

@property (nonatomic, strong) ModelGroups *group;
@property (nonatomic, weak) id <OLiTableViewHeaderViewDelegate>delegate;
@end
