//
//  OrderTableViewCell.m
//  sport
//
//  Created by allen.wang on 5/21/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self configSubViews];
    }
    return self;
}


- (void) configSubViews
{
    self.topLabel.frame              = CGRectMake(8, 4, 200, 20);
    self.subLabel.frame              = CGRectMake(8, 26, 200, 20);
    self.timeLabel.frame             = CGRectMake(8, 47, 200, 20);
    self.rightLabel.frame            = CGRectMake(220, 15, 90, 20);
    self.subRightLabel.frame         = CGRectMake(220, 35, 90, 20);

    self.timeLabel.backgroundColor   = kClearColor;
    self.timeLabel.textAlignment     = UITextAlignmentLeft;
    self.rightLabel.textAlignment    = UITextAlignmentRight;
    self.subRightLabel.textAlignment = UITextAlignmentRight;

    self.topLabel.textColor          = kBlackColor;
    self.rightLabel.textColor        = kBlackColor;
    self.subLabel.textColor          = kLightGrayColor;
    self.timeLabel.textColor         = kLightGrayColor;
    self.subRightLabel.textColor     = [UIColor getColor:KCustomGreenColor];

    self.topLabel.font               = HTFONTSIZE(kFontSize16);
    self.subLabel.font               = HTFONTSIZE(kFontSize14);
    self.timeLabel.font              = HTFONTSIZE(kFontSize14);
    self.rightLabel.font             = HTFONTSIZE(kFontSize16);
    self.subRightLabel.font          = HTFONTSIZE(kFontSize14);

    self.topLabel.text               = @"中教+外教（免费试听）";
    self.subLabel.text               = @"美华少儿英语浦东金桥中心";
    self.timeLabel.text              = @"05/18 17:00-18:00";
    self.rightLabel.text             = @"￥120.00";
    self.subRightLabel.text          = @"交易关闭";
    
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.subRightLabel];
}
@end
