//
//  CustomThreeButton.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "CustomThreeButton.h"
#import "UIImageView+(ASI).h"
#import "UIImage+extend.h"

@interface CustomColumButton()
@property (nonatomic, retain) UIImageView *theImageView;
@property (nonatomic, retain) UILabel     *theLabel;

@end

@implementation CustomColumButton

- (void) dealloc
{
    TT_RELEASE_SAFELY(_theLabel);
    TT_RELEASE_SAFELY(_theImageView);
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.theImageView];
        [self addSubview:self.theLabel];
        self.backgroundColor = kWhiteColor;
        self.title = @"MOST POPULAR";
        self.theImageView.image = [UIImage imageNamed:kImageDefault];
    }
    return self;
}

- (UIImageView *) theImageView
{
    if (!_theImageView) {
        _theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
//        _theImageView.layer.cornerRadius = 2.0f;
//        _theImageView.layer.borderColor = kGrayColor;
//        _theImageView.layer.borderWidth = 1.0f;
        _theLabel.backgroundColor = kWhiteColor;
        
    }
    return _theImageView;
}

- (UILabel *) theLabel
{
    if (!_theLabel) {
        _theLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _theLabel.textColor = kOrangeColor;
        _theLabel.numberOfLines = 2;
        _theLabel.backgroundColor = kClearColor;
        _theLabel.textAlignment = NSTextAlignmentCenter;
        _theLabel.font = HTFONTSIZE(kFontSize12);
    }
    return _theLabel;
}

- (void) setTitle:(NSString *)title
{
    if (_title != title) {
        [_title release];
        _title = [title copy];
    }
    self.theLabel.text = title;
}


- (void) setImageString:(NSString *)imageString
{
    if (_imageString != imageString) {
        [_imageString release];
        _imageString = [imageString copy];
        
        __block typeof(self) blockSelf = self;
        [self.theImageView setImageWithURL:[NSURL URLWithString:_imageString]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(107, 93)];
                                        blockSelf.theImageView.image = image1;
                                        
                                    }
                                    failure:^(NSError *error){
                                        blockSelf.theImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];
    }
}


- (void) setContent:(id)content
{
    if (_content != content) {
        _content = content;
        HomeProductItem *item = (HomeProductItem *) content;
        if (item) {
            self.title = item.productName;
            self.imageString = item.productImg;
        }
    }
}

@end

@implementation CustomThreeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.theLabel.frame = CGRectMake(2, 0, 103, 36);
        self.theImageView.frame = CGRectMake(0, 37, 107, 93);
        UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 36, 107, 1)] autorelease];
        lineView.backgroundColor = kGrayColor;
        lineView.alpha = 0.3f;
        [self addSubview:lineView];
    }
    return self;
}

@end


@implementation CustomTwoButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.theLabel.frame = CGRectMake(2, 0, 103, 36);
        self.theImageView.frame = CGRectMake(0, 37, 107, 93);
        UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 36, 107, 1)] autorelease];
        lineView.backgroundColor = kGrayColor;
        lineView.alpha = 0.3f;
        [self addSubview:lineView];
        
    }
    return self;
}

@end
