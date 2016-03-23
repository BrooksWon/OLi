//
//  OLiSectionTableViewCell.h
//  OLi
//
//  Created by Brooks on 16/3/23.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLiSectionTableViewCell : UITableViewCell

@property(nonatomic, copy, nullable)NSString *sectionName;

+ (nonnull instancetype)sectionTableViewCellWithTableView:(nonnull UITableView *)tableView forIndexPath:(nonnull NSIndexPath*)indexPath;

@end
