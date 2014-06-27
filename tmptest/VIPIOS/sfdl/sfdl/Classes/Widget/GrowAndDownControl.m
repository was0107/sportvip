//
//  GrowAndDownControl.m
//  sfdl
//
//  Created by Erlang on 14-6-28.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "GrowAndDownControl.h"
#import "CreateObject.h"


@interface GrowAndDownControl()
@property (nonatomic, retain) UIButton *leftButton, *rightButton;
@property (nonatomic, retain) UILabel  *middleLabel,*rightLabel;

@end

@implementation GrowAndDownControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kClearColor;
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.middleLabel];
        [self addSubview:self.rightLabel];
        self.value = 0;
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_leftButton);
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_middleLabel);
    TT_RELEASE_SAFELY(_rightLabel);
    [super dealloc];
}

-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 46,30)];
        [_leftButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_leftButton setTitleColor:kBlackColor forState:UIControlStateSelected];
        _leftButton.titleLabel.font = HTFONTSIZE(kSystemFontSize14);
        [_leftButton setTitle:@"-" forState:UIControlStateNormal];
        _leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [CreateObject addTargetEfection:_leftButton];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_leftButton addTarget:self action:@selector(buttonLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(90, 5, 44,30)];
        [_rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_rightButton setTitleColor:kBlackColor forState:UIControlStateSelected];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _rightButton.titleLabel.font = HTFONTSIZE(kSystemFontSize14);
        [_rightButton setTitle:@"+" forState:UIControlStateNormal];
        [CreateObject addTargetEfection:_rightButton];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_rightButton addTarget:self action:@selector(buttonRightAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UILabel *)middleLabel
{
    if (!_middleLabel)
    {
        _middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 42, 30)];
        _middleLabel.textColor  = [UIColor getColor:kCellLeftColor];
        _middleLabel.backgroundColor = kClearColor;
        _middleLabel.layer.borderColor = [kButtonNormalColor CGColor];;
        _middleLabel.layer.borderWidth = 2.0f;
        _middleLabel.layer.cornerRadius = 2.0f;
        _middleLabel.text = kIntToString(self.value);
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.font = HTFONTSIZE(kSystemFontSize15);
    }
    return _middleLabel;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(136, 5, 44, 30)];
        _rightLabel.textColor  = kGrayColor;
        _rightLabel.backgroundColor = kClearColor;
        _rightLabel.text = @"Unit(s)";
        _rightLabel.font = HTFONTSIZE(kSystemFontSize15);
    }
    return _rightLabel;
}
- (void) setValue:(NSInteger)value
{
    if (_value != value) {
        if (value < 0) {
            return;
        }
        _value = value;
        [self.middleLabel setText:kIntToString(_value)];
    }
}

-(IBAction)buttonLeftAction:(id)sender
{
    self.value = self.value - 1;
}

-(IBAction)buttonRightAction:(id)sender
{
    self.value = self.value + 1;
}


@end
