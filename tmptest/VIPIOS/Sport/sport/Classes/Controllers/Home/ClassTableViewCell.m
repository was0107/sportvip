//
//  ClassTableViewCell.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ClassTableViewCell.h"
@interface ClassTableViewCell()

@end

@implementation ClassTableViewCell

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
    self.topLabelEx.frame        = CGRectMake(112, 6, 140, 24);
    self.topRigithEx.frame       = CGRectMake(112, 30, 202, 34);
    self.middleLabelEx.frame     = CGRectMake(112, 66, 12, 24);
    self.subRightEx.frame        = CGRectMake(254, 6, 60, 24);
    self.subRightLabel.frame     = CGRectMake(244, 86, 70, 24);
    self.leftImageView.frame     = CGRectMake(6, 5, 100, 90);

    self.subRightLabel.font = HTFONTSIZE(kFontSize17);
    self.topLabelEx.textColor    = kBlackColor;
    self.topRigithEx.textColor   = kLightGrayColor;
    self.middleLabelEx.textColor = kLightGrayColor;
    self.subRightLabel.textColor = [UIColor getColor:KCustomGreenColor];
    
    self.subRightLabel.textAlignment = UITextAlignmentRight;
    
    [self.contentView addSubview:self.topLabelEx];
    [self.contentView addSubview:self.topRigithEx];
    [self.contentView addSubview:self.middleLabelEx];
    [self.contentView addSubview:self.subRightEx];
    [self.contentView addSubview:self.subRightLabel];
    [self.contentView addSubview:self.leftImageView];
    
    self.topLabelEx.text = @"国学培训课程（免费试听)";
    [self.topLabelEx setImages:[NSArray arrayWithObjects:@"icon",@"icon",nil] origitation:1];

    self.topRigithEx.text = @"国子学堂虹桥中心国子学堂虹桥中心国子学堂虹桥中心";
    [self.topRigithEx setImages:[NSArray arrayWithObjects:@"icon",nil] origitation:0];
    
    self.subRightEx.text = @"245km";
    [self.subRightEx setImages:[NSArray arrayWithObjects:@"icon",nil] origitation:0];

//    self.middleLabelEx.text = @"张鸿宇老师|05.19 10：30";
    [self.middleLabelEx setImage:@"icon" origitation:0];
    
    for (int i = 0 ; i < 3; i++) {
        UIImageLabelEx *labelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(130 + 36 *i, 68, 36, 20)] autorelease];
        labelEx.backgroundColor = kClearColor;
        labelEx.textColor = kDarkTextColor;
        labelEx.highlightedTextColor = kBlackColor;
        labelEx.font = HTFONTSIZE(kFontSize13);
        labelEx.textAlignment = UITextAlignmentCenter;
        labelEx.text = @"篮球";
        [self.contentView addSubview:labelEx];
        [labelEx setImage:@"icon" origitation:2];

    }

    self.subRightLabel.text = @"￥2290";
    self.leftImageView.image = [UIImage imageNamed:@"icon"];
    self.leftImageView.layer.cornerRadius = 4.0f;
    self.leftImageView.layer.borderColor  = [[UIColor getColor:KCustomGreenColor] CGColor];
    self.leftImageView.layer.borderWidth  = 0.8f;
    
    
    ClassTableViewCell *blockSelf = self;
    [self.leftImageView setImageWithURL:[NSURL URLWithString:@"http://img.b5m.com/image/T1W8hjBCJj1RCvBVdK"]
                    placeholderImage:[UIImage imageNamed:kImageDefault]
                             success:^(UIImage *image){
                                 UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 80)];
                                 blockSelf.leftImageView.image = image1;
                                 
                             }
                             failure:^(NSError *error){
                                 blockSelf.leftImageView.image = [UIImage imageNamed:kImageDefault];
                             }];
    
}

@end
