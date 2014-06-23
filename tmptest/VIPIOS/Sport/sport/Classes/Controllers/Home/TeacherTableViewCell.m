//
//  TeacherTableViewCell.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "TeacherTableViewCell.h"
#import "PaggingItem.h"

@implementation TeacherTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) configTeacherDetailHeader
{
    self.topLabelEx.frame        = CGRectMake(120, 10, 190, 24);
    self.topRigithEx.frame       = CGRectMake(120, 30, 190, 60);
    self.leftImageView.frame     = CGRectMake(10, 10, 100, 90);
    
    if (!self.topLabelEx.superview) {
        self.topLabelEx.textColor    = kBlackColor;
        self.topRigithEx.textColor   = kLightGrayColor;
        self.topRigithEx.numberOfLines = 0;
        self.leftImageView.layer.cornerRadius = 4.0f;
        self.leftImageView.layer.borderColor  = [[UIColor getColor:KCustomGreenColor] CGColor];
        self.leftImageView.layer.borderWidth  = 0.8f;
        
        [self.contentView addSubview:self.topLabelEx];
        [self.contentView addSubview:self.topRigithEx];
        [self.contentView addSubview:self.leftImageView];
    }
   
    
    self.topLabelEx.text = @"国学培训课程（免费试听)";
    [self.topLabelEx setImages:[NSArray arrayWithObjects:@"icon",@"icon",nil] origitation:1];
    self.topRigithEx.text = @"国子学堂虹桥中心国子学堂虹桥中心国子学堂虹子学堂虹桥中心国子学堂虹子学堂虹桥中心国子学堂虹桥中心";
    
    
    
    TeacherTableViewCell *blockSelf = self;
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


- (void) configWithType:(int) type
{
    self.topLabelEx.frame        = CGRectMake(112, 6, 140, 24);
    self.subRightEx.frame        = CGRectMake(254, 6, 60, 24);
    self.topRigithEx.frame       = CGRectMake(112, 34, 202, 24);
    self.middleLabelEx.frame     = CGRectMake(112, 65, 130, 24);
    self.subRightLabel.frame     = CGRectMake(244, 65, 70, 24);
    self.leftImageView.frame     = CGRectMake(6, 5, 100, 90);
    
    if (!self.topLabelEx.superview) {
        self.subRightLabel.font               = HTFONTSIZE(kFontSize17);
        self.topLabelEx.textColor             = kBlackColor;
        self.topRigithEx.textColor            = kLightGrayColor;
        self.middleLabelEx.textColor          = kLightGrayColor;
        self.subRightLabel.textColor          = [UIColor getColor:KCustomGreenColor];
        self.subRightLabel.textAlignment      = UITextAlignmentRight;
        self.leftImageView.layer.cornerRadius = 4.0f;
        self.leftImageView.layer.borderColor  = [[UIColor getColor:KCustomGreenColor] CGColor];
        self.leftImageView.layer.borderWidth  = 0.8f;
        
        
        [self.topLabelEx setImageSize:CGSizeMake(18, 20)];
        [self.subRightEx setImageSize:CGSizeMake(18, 18)];
        [self.topRigithEx setImageSize:CGSizeMake(16, 18)];
        [self.middleLabelEx setImageSize:CGSizeMake(16, 18)];
        
        
        [self.contentView addSubview:self.topLabelEx];
        [self.contentView addSubview:self.topRigithEx];
        [self.contentView addSubview:self.middleLabelEx];
        [self.contentView addSubview:self.subRightEx];
        [self.contentView addSubview:self.subRightLabel];
        [self.contentView addSubview:self.leftImageView];

    }
}

- (void) configWithData:(id) content
{
    if (self.content != content) {
        self.content = content;
        CoacheItem *item = (CoacheItem *) self.content;
        
        CGSize size = [item.name sizeWithFont:self.topLabelEx.font constrainedToSize:CGSizeMake(140, 24)];
        if (size.width + 40 < 140) {
            [self.topLabelEx setFrameSize:CGSizeMake(size.width + 40, 24)];
            [self.subRightEx setFrameWidth:100 - size.width + self.subRightEx.width-10 ];
        }
        
        self.topLabelEx.text = item.name;
        [self.topLabelEx setImages:[NSArray arrayWithObjects:@"hot",@"xin",nil] origitation:1];
        
        self.subRightEx.text = item.distanceString;
        [self.subRightEx setImages:[NSArray arrayWithObjects:@"cell_distance",nil] origitation:0];
        
        
        self.topRigithEx.text = item.address;
        [self.topRigithEx setImages:[NSArray arrayWithObjects:@"cell_map",nil] origitation:0];
        
        self.middleLabelEx.text = item.certificate;
        [self.middleLabelEx setImage:@"cell_hornor" origitation:0];
        
        self.subRightLabel.text = item.priceString;
        self.leftImageView.image = [UIImage imageNamed:@"icon"];
        
        
        TeacherTableViewCell *blockSelf = self;
        [self.leftImageView setImageWithURL:[NSURL URLWithString:item.avatar]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 80)];
                                        blockSelf.leftImageView.image = image1;
                                        
                                    }
                                    failure:^(NSError *error){
                                        blockSelf.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];

    }
}



//- (void) configWithType:(int) type
//{
//    self.topLabel.frame          = CGRectMake(92, 6, 222, 24);
//    self.subLabel.frame          = CGRectMake(92, 33, 222, 24);
//    self.rightLabel.frame        = CGRectMake(92, 60, 148, 24);
//    self.subRightLabel.frame     = CGRectMake(244, 60, 70, 24);
//    self.leftImageView.frame     = CGRectMake(6, 5, 80, 80);
//    
//    self.topLabel.font           = HTFONTSIZE(kFontSize17);
//    self.subLabel.font           = HTFONTSIZE(kFontSize14);
//    self.rightLabel.font         = HTFONTSIZE(kFontSize14);
//    self.subRightLabel.font      = HTFONTSIZE(kFontSize18);
//    
//    self.topLabel.textColor      = kBlackColor;
//    self.subLabel.textColor      = kLightGrayColor;
//    self.rightLabel.textColor    = kLightGrayColor;
//    self.subRightLabel.textColor = [UIColor getColor:KCustomGreenColor];
//    
//    self.subRightLabel.textAlignment = UITextAlignmentRight;
//    
//    [self.contentView addSubview:self.topLabel];
//    [self.contentView addSubview:self.subLabel];
//    [self.contentView addSubview:self.rightLabel];
//    [self.contentView addSubview:self.subRightLabel];
//    [self.contentView addSubview:self.leftImageView];
//    
//    self.topLabel.text = @"国学培训课程（免费试听)";
//    self.subLabel.text = @"国子学堂虹桥中心";
//    self.rightLabel.text = @"张鸿宇老师|05.19 10：30";
//    self.subRightLabel.text = @"￥2290";
//    self.leftImageView.image = [UIImage imageNamed:@"icon"];
//    
//    self.leftImageView.layer.cornerRadius = 40.0f;
//    self.leftImageView.layer.borderColor  = [[UIColor getColor:KCustomGreenColor] CGColor];
//    self.leftImageView.layer.borderWidth  = 2.0f;
//    
//    
//    TeacherTableViewCell *blockSelf = self;
//    [self.leftImageView setImageWithURL:[NSURL URLWithString:@"http://img.b5m.com/image/T1PaAXBvLb1RCvBVdK"]
//                       placeholderImage:[UIImage imageNamed:kImageDefault]
//                                success:^(UIImage *image){
//                                    UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(80, 80)];
//                                    blockSelf.leftImageView.image = image1;
//                                    
//                                }
//                                failure:^(NSError *error){
//                                    blockSelf.leftImageView.image = [UIImage imageNamed:kImageDefault];
//                                }];
//    
//}


@end
