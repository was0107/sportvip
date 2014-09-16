//
//  CreateObject.m
//  b5mappsejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "CreateObject.h"


@implementation CreateObject

+ (UITableView *) plainTableView
{
    return [[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] autorelease];
}

+ (UIImageView *) imageView:(NSString *) image
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:image]] autorelease];
}

+ (UIImageView *) imageView:(NSString *) image frame:(CGRect) frame first:(NSString *) first second:(NSString *) second
{
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:image]] autorelease];
    imageView.frame = frame;
    
    UILabel *firstLabel = [self titleLabel];
    firstLabel.frame = CGRectMake(20, 30, 130, 30);
    firstLabel.text = first;
    firstLabel.font = HTFONTBIGSIZE(kFontSize18);
    [imageView addSubview:firstLabel];
    
    UILabel *secondLabel = [self titleLabel];
    secondLabel.frame = CGRectMake(20, 60, 130, 30);
    secondLabel.text = second;
    secondLabel.textColor = kOrangeColor;
    secondLabel.tag = 1001;
    secondLabel.font = HTFONTBIGSIZE(kFontSize18);
    [imageView addSubview:secondLabel];
    return imageView;
}

+ (UIView *) view
{
    return (UIView *)createOBjectMarco(@"UIView");
}

+ (UIButton *) button
{
    return (UIButton *)createOBjectMarco(@"UIButton");
}

+ (UILabel *) label
{
    return (UILabel *)createOBjectMarco(@"UILabel");
}

+ (UILabel *) titleLabel
{
    UILabel *label  = (UILabel *)createOBjectMarco(@"UILabel");
    label.font = HTFONTBIGSIZE(kFontSize14);
    label.backgroundColor = kClearColor;
    label.textColor = kBlackColor;
    label.lineBreakMode = UILineBreakModeTailTruncation;
    return label;
}

+(UIScrollView *) scrollView
{
    UIScrollView *view = [[[UIScrollView alloc] init] autorelease];
    view.backgroundColor = kClearColor;
    return view;
}

+ (UIButton *) addTargetEfection:(UIButton *) theButton
{
    [theButton setBackgroundImage:[[UIImage imageWithColor:kRedColor size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [theButton setBackgroundImage:[[UIImage imageWithColor:kOrangeColor size:CGSizeMake(10, 10)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    return  theButton;
}
@end
