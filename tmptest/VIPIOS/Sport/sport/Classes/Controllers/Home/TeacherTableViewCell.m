//
//  TeacherTableViewCell.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "TeacherTableViewCell.h"

@implementation TeacherTableViewCell

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
    self.topLabel.frame          = CGRectMake(92, 6, 222, 24);
    self.subLabel.frame          = CGRectMake(92, 33, 222, 24);
    self.rightLabel.frame        = CGRectMake(92, 60, 148, 24);
    self.subRightLabel.frame     = CGRectMake(244, 60, 70, 24);
    self.leftImageView.frame     = CGRectMake(6, 5, 80, 80);
    
    self.topLabel.font           = HTFONTSIZE(kFontSize17);
    self.subLabel.font           = HTFONTSIZE(kFontSize14);
    self.rightLabel.font         = HTFONTSIZE(kFontSize14);
    self.subRightLabel.font      = HTFONTSIZE(kFontSize18);
    
    self.topLabel.textColor      = kBlackColor;
    self.subLabel.textColor      = kLightGrayColor;
    self.rightLabel.textColor    = kLightGrayColor;
    self.subRightLabel.textColor = [UIColor getColor:KCustomGreenColor];
    
    self.subRightLabel.textAlignment = UITextAlignmentRight;
    
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.subRightLabel];
    [self.contentView addSubview:self.leftImageView];
    
    self.topLabel.text = @"国学培训课程（免费试听)";
    self.subLabel.text = @"国子学堂虹桥中心";
    self.rightLabel.text = @"张鸿宇老师|05.19 10：30";
    self.subRightLabel.text = @"￥2290";
    self.leftImageView.image = [UIImage imageNamed:@"icon"];
    
    self.leftImageView.layer.cornerRadius = 40.0f;
    self.leftImageView.layer.borderColor  = [[UIColor getColor:KCustomGreenColor] CGColor];
    self.leftImageView.layer.borderWidth  = 2.0f;
    
    
    TeacherTableViewCell *blockSelf = self;
    [self.leftImageView setImageWithURL:[NSURL URLWithString:@"http://img.b5m.com/image/T1PaAXBvLb1RCvBVdK"]
                       placeholderImage:[UIImage imageNamed:kImageDefault]
                                success:^(UIImage *image){
                                    UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(80, 80)];
                                    blockSelf.leftImageView.image = image1;
                                    
                                }
                                failure:^(NSError *error){
                                    blockSelf.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                }];
    
}


@end
