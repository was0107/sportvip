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
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIColor+extend.h"
#import "UIImage+extend.h"
#import "UIView+extend.h"

@interface CustomImageTitleButton()

@end

@implementation CustomImageTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.topButton];
        [self addSubview:self.bottomTitleLabel];
    }
    return self;
}
-(void)dealloc
{
    TT_RELEASE_SAFELY(_topButton);
    TT_RELEASE_SAFELY(_bottomTitleLabel);
    [super dealloc];
}


-(UIButton *)topButton
{
    if (!_topButton) {
        _topButton = [[UIButton alloc]initWithFrame:CGRectMake(3, 3, 70, 70)];
        _topButton.contentMode = UIViewContentModeCenter;
        [_topButton setBackgroundImage:[[UIImage imageWithColor:kButtonNormalColor size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [_topButton setBackgroundImage:[[UIImage imageWithColor:kButtonSelectColor size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    }
    return _topButton;
}


-(UILabel *)bottomTitleLabel
{
    if (!_bottomTitleLabel) {
        _bottomTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 76, 71, 20)];
        _bottomTitleLabel.textColor  = kGrayColor;
        _bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTitleLabel.backgroundColor = kClearColor;
        _bottomTitleLabel.font = SYSTEMFONT(kSystemFontSize10);
        _bottomTitleLabel.numberOfLines = 0;
    }
    return _bottomTitleLabel;
}

- (void) setText:(NSString *) text image:(NSString *)imageName
{
    self.bottomTitleLabel.text = text;
    if (imageName && [imageName hasPrefix:@"http"]) {
        
        [self.topButton setImageWithURL:[NSURL URLWithString:imageName]];
        _topButton.contentMode = UIViewContentModeCenter;
    } else {
        [self.topButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}

@end


@implementation CustomRoundImageTitle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[[UIImage imageWithColor:kLightGrayColor size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        [self addSubview:self.bottomTitleLabel];
        [self addSubview:self.topImage];
    }
    return self;
}
-(void)dealloc
{
    TT_RELEASE_SAFELY(_topImage);
    TT_RELEASE_SAFELY(_bottomTitleLabel);
    [super dealloc];
}


-(UIImageView *)topImage
{
    if (!_topImage) {
        _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 70, 70)];
        _topImage.layer.borderWidth = 2.0f;
        _topImage.layer.cornerRadius = 35;
        _topImage.layer.masksToBounds = YES;
        _topImage.layer.borderColor = [kWhiteColor CGColor];
    }
    return _topImage;
}


-(UILabel *)bottomTitleLabel
{
    if (!_bottomTitleLabel) {
        _bottomTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 76, 71, 20)];
        _bottomTitleLabel.textColor  = kGrayColor;
        _bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTitleLabel.backgroundColor = kClearColor;
        _bottomTitleLabel.font = SYSTEMFONT(kSystemFontSize10);
        _bottomTitleLabel.numberOfLines = 0;
    }
    return _bottomTitleLabel;
}

- (void) setText:(NSString *) text image:(NSString *)imageName
{
    self.bottomTitleLabel.text = text;
    if ([imageName hasPrefix:@"http"]) {
        [self.topImage setImageWithURL:[NSURL URLWithString:imageName]
                      placeholderImage:[UIImage imageNamed:@"icon_default"]
                               success:^(UIImage *image){
                                   UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(70, 70)];
                                   _topImage.image = image1;
                               }
                               failure:^(NSError *error){
                                   _topImage.image = [UIImage imageNamed:@"icon_default"];
                               }];
    } else {
        self.topImage.image = [UIImage imageNamed:imageName];
    }
}


@end