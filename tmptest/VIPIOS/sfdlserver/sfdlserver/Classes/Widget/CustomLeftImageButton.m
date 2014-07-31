//
//  CustomLeftImageButton.m
//  sfdl
//
//  Created by Erlang on 14-6-28.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "CustomLeftImageButton.h"

@implementation CustomLeftImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightLabel];
    }
    return self;
}
-(UILabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 2, self.frame.size.width - 44, 40)];
        _rightLabel.textColor  = [UIColor getColor:kCellLeftColor];
        _rightLabel.backgroundColor = kClearColor;
        _rightLabel.adjustsFontSizeToFitWidth = YES;
        _rightLabel.numberOfLines = 2.0f;
        _rightLabel.layer.borderColor = [kButtonNormalColor CGColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = HTFONTSIZE(kSystemFontSize15);
    }
    return _rightLabel;
}


- (UIImageView *) leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
        _leftImageView.backgroundColor = kClearColor;
        _leftImageView.userInteractionEnabled = YES;
        _leftImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _leftImageView;
}

@end
