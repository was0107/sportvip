//
//  CheckClassTableViewCell.m
//  sport
//
//  Created by allen.wang on 6/27/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "CheckClassTableViewCell.h"
#import "PaggingItem.h"

@implementation CheckClassTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) configWithType:(int) type
{
    self.leftImageView.frame     = CGRectMake(10, 10, 100, 90);
    self.topLabelEx.frame        = CGRectMake(120, 10, 190, 24);
    self.topRigithEx.frame       = CGRectMake(120, 32, 190, 20);
    self.middleLabelEx.frame     = CGRectMake(120, 55, 190, 20);
    self.subRightEx.frame        = CGRectMake(120,75, 190, 24);

    if (!self.topLabelEx.superview) {
        self.topLabelEx.textColor             = kBlackColor;
        self.topRigithEx.textColor            = kLightGrayColor;
        self.middleLabelEx.textColor          = kLightGrayColor;
        self.topRigithEx.numberOfLines        = 0;
        self.leftImageView.layer.cornerRadius = 4.0f;
        self.leftImageView.layer.borderColor  = [[UIColor getColor:KCustomGreenColor] CGColor];
        self.leftImageView.layer.borderWidth  = 0.8f;
        self.topLabelEx.font                  = HTFONTSIZE(kFontSize16);
        self.subRightEx.font                  = HTFONTSIZE(kFontSize16);
        self.subRightEx.textColor             = [UIColor getColor:KCustomGreenColor];
        [self.contentView addSubview:self.subRightEx];
        [self.contentView addSubview:self.topLabelEx];
        [self.contentView addSubview:self.topRigithEx];
        [self.contentView addSubview:self.middleLabelEx];
        [self.contentView addSubview:self.leftImageView];
    }
}

- (void) configWithData:(id) content
{
    CheckClassItem *classItem = (CheckClassItem *) content;
    
    self.topLabelEx.text = classItem.name;
    CGSize size = [classItem.name sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 2000)];
    [[self.topLabelEx setFrameHeight:size.height + 4] setFrameWidth:size.width + 45];
    [self.topLabelEx setImages:[NSArray arrayWithObjects:@"hot",@"xin",nil] origitation:1];
    self.subRightEx.text = [NSString stringWithFormat:@"¥%@", classItem.price];
    self.topRigithEx.text = [NSString stringWithFormat:@"教练：%@", classItem.coachName];
    self.middleLabelEx.text = [NSString stringWithFormat:@"上课时间：%@", classItem.schoolTime];
    [self.topRigithEx setImages:[NSArray arrayWithObjects:@"cell_teacher",nil] origitation:0];
    [self.middleLabelEx setImages:[NSArray arrayWithObjects:@"cell_time",nil] origitation:0];
    
    
    CheckClassTableViewCell *blockSelf = self;
    [self.leftImageView setImageWithURL:[NSURL URLWithString:classItem.coachAvatar]
                       placeholderImage:[UIImage imageNamed:kImageDefault]
                                success:^(UIImage *image){
                                    UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 90)];
                                    blockSelf.leftImageView.image = image1;
                                    
                                }
                                failure:^(NSError *error){
                                    blockSelf.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                }];

}


@end
