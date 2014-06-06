//
//  CustomImageTitleButton.m
//  sfdl
//
//  Created by allen.wang on 6/4/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "CustomImageTitleButton.h"
#import "UIColor+extend.h"
#import "UIImage+tintedImage.h"

@interface CustomImageTitleButton()
@property(nonatomic, retain)UIImageView * topImageView;
@property(nonatomic, retain)UILabel     * bottomTitleLabel;

@end

@implementation CustomImageTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomTitleLabel];
        [self setBackgroundImage:[[UIImage imageWithColor:[UIColor getColor:@"F3F2F2"] size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateSelected];
        [self setBackgroundImage:[[UIImage imageWithColor:[UIColor getColor:@"F3F2F2"] size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    }
    return self;
}
-(void)dealloc
{
    TT_RELEASE_SAFELY(_topImageView);
    TT_RELEASE_SAFELY(_bottomTitleLabel);
    [super dealloc];
}


-(UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 70, 70)];
        _topImageView.backgroundColor = kGridTableViewColor;
//        _topImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _topImageView;
}


-(UILabel *)bottomTitleLabel
{
    if (!_bottomTitleLabel) {
        _bottomTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 80, 71, 20)];
        _bottomTitleLabel.textColor  = kGrayColor;
        _bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTitleLabel.backgroundColor = kClearColor;
        _bottomTitleLabel.font = SYSTEMFONT(kSystemFontSize15);
        _bottomTitleLabel.text = @"mpmc";
        _bottomTitleLabel.numberOfLines = 0;
    }
    return _bottomTitleLabel;
}


@end
