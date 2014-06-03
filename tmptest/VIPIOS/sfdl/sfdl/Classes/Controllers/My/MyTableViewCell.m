//
//  MyTableViewCell.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self configWithType:1];
    }
    return self;
}


- (void) configWithType:(int) type
{
    self.topLabel.frame                = CGRectMake(44, 10, 202, 24);
    self.leftImageView.frame           = CGRectMake(10, 10, 24, 24);

    self.topLabel.font                 = HTFONTSIZE(kFontSize16);
    self.topLabel.textColor            = kBlackColor;
    self.topLabel.highlightedTextColor = kBlackColor;
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.leftImageView];
}


@end
