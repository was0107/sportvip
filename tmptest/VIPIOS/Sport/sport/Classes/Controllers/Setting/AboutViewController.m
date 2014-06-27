//
//  AboutViewController.m
//  b5mei
//
//  Created by allen.wang on 4/17/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property(nonatomic, retain)UIImageView * iconImageView;
@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)UILabel *labelTwo;
@end

@implementation AboutViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setTitleContent:kTitleAboutString];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.labelTwo];
    // Do any additional setup after loading the view.
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:kAboutLogoFrame];
        _iconImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _iconImageView;
}

-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:kAboutLabelOneFrame];
        _labelOne.textColor  = [UIColor getColor:kCellLeftColor];
        _labelOne.textAlignment = NSTextAlignmentCenter;
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kSystemFontSize15);
        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        _labelOne.text = version;
    }
    return _labelOne;
}

-(UILabel *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[UILabel alloc]initWithFrame:kAboutLabelTwoFrame];
        _labelTwo.textColor  = [UIColor getColor:kCellLeftColor];
        _labelTwo.textAlignment = NSTextAlignmentCenter;
        _labelTwo.backgroundColor = kClearColor;
        _labelTwo.font = HTFONTSIZE(kSystemFontSize14);
        _labelTwo.text = lLabelTwoString;
        _labelTwo.numberOfLines = 0;
        
    }
    return _labelTwo;
}

-(void)reduceMemory
{
    TT_RELEASE_SAFELY(_iconImageView);
    TT_RELEASE_SAFELY(_labelOne);
    TT_RELEASE_SAFELY(_labelTwo);
    [super reduceMemory];
}

@end
