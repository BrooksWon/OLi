//
//  OLiSectionTableViewCell.m
//  OLi
//
//  Created by Brooks on 16/3/23.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import "OLiSectionTableViewCell.h"

@implementation OLiSectionTableViewCell

+ (nonnull instancetype)sectionTableViewCellWithTableView:(nonnull UITableView *)tableView forIndexPath:(nonnull NSIndexPath*)indexPath
{
    static NSString *ID = @"OLiSectionTableViewCell";
    OLiSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID /*forIndexPath:indexPath*/];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OLiSectionTableViewCell" owner:self
                                           options:nil] lastObject];
        cell.imageView.image = [UIImage imageNamed:@"zhangjie"];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSectionName:(NSString *)sectionName {
    self.textLabel.text = sectionName;
}

@end
