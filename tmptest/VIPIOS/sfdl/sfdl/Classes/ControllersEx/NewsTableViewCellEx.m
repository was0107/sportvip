//
//  NewsTableViewCellEx.m
//  sfdl
//
//  Created by boguang on 14-9-16.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "NewsTableViewCellEx.h"

@implementation NewsTableViewCellEx

- (void) configWithType:(int) type
{
    self.topLabel.frame = CGRectMake(4, 4, 250, 40);
    self.topLabel.font = HTFONTSIZE(kFontSize14);
    self.topLabel.numberOfLines = 2;
    self.topLabel.textColor = kLightGrayColor;
    
    self.rightLabel.frame = CGRectMake(254, 6, 64, 20);
    self.rightLabel.font = HTFONTSIZE(kFontSize16);
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel.numberOfLines = 1;
    self.rightLabel.textColor = kGrayColor;

    self.subRightLabel.frame = CGRectMake(254, 30, 64, 20);
    self.subRightLabel.font = HTFONTSIZE(kFontSize12);
    self.subRightLabel.textAlignment = NSTextAlignmentCenter;
    self.subRightLabel.numberOfLines = 1;
    self.subRightLabel.textColor = kLightGrayColor;
    
    self.rightImageView.frame = CGRectMake(206, 45, 50, 5);
    self.rightImageView.backgroundColor = kOrangeColor;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(250, 0, 1, 50);
    layer.backgroundColor = [[UIColor getColor:@"EBEAF1"] CGColor];
    [self.contentView.layer addSublayer:layer];
    
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.subRightLabel];
    [self.contentView addSubview:self.rightImageView];
}

- (void) showLeft:(BOOL) flag
{
    self.rightImageView.frame = CGRectMake(flag ? 0 : 200, 47, 50, 3);
}

- (void) setContent:(id)content
{
    self.topLabel.text = @"The different series of deutz gensets have different features";
    self.rightLabel.text = @"08:59";
    self.subRightLabel.text = @"2014-09-03";
}

@end