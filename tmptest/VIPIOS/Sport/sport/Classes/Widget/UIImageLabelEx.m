//
//  UIImageLabelEx.m
//  sport
//
//  Created by Erlang on 14-6-2.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "UIImageLabelEx.h"
#import "UIView+extend.h"

#define kImageWidthHeight   15.0f
#define kImageSpace         2.0f

@interface UIImageLabelEx()
@property (nonatomic, retain) NSArray *imageArray;
@end

@implementation UIImageLabelEx
{
    int _origitation;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_imageArray);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setText:(NSString *)text
{
    
    [super setText:text];
    [self setInternalImages];
    
}

- (id) setInternalImages
{
    int total  =  [self.imageArray count];
    if (total > 0) {
        
        float space = total * (kImageWidthHeight + kImageSpace);
        UIView *superView = self.superview;
        CALayer *superLayer = nil;
        if (superView) {
            superLayer = superView.layer;
        }
        
        CGRect rect = self.frame;
        if (0 == _origitation) {
            [self setExtendWidth:space];
        } else  if (1 == _origitation) {
            [self setFrameWidth:self.width - space];
        }
        
        if (superLayer) {
            for (int i = 0; i < total; i++) {
                CALayer *layer = [CALayer layer];
                layer.contents = (id)[UIImage imageNamed:[self.imageArray objectAtIndex:i]].CGImage;
                if (0 == _origitation) {
                    layer.frame = CGRectMake(rect.origin.x + i * (kImageWidthHeight + kImageSpace), rect.origin.y + 4, kImageWidthHeight, kImageWidthHeight);
                } else  if (1 == _origitation) {
                    layer.frame = CGRectMake(rect.origin.x + rect.size.width - (total - i) *  (kImageWidthHeight + kImageSpace), rect.origin.y + 4, kImageWidthHeight, kImageWidthHeight);
                } else  if (2 == _origitation) {
                    layer.frame = CGRectMake(rect.origin.x + 10 , rect.origin.y + rect.size.height  + kImageSpace, kImageWidthHeight, kImageWidthHeight);
                } else  if (3 == _origitation) {
                    layer.frame = CGRectMake(0, 0, kImageWidthHeight, kImageWidthHeight);
                }
                [superLayer addSublayer:layer];
            }
        }
    }
    return self;
}


- (id) setImages:(NSArray *) images origitation:(int) flag
{
    self.imageArray = images;
    _origitation = flag;
    [self setInternalImages];
    return self;
}

- (id) setImage:(NSString *) image origitation:(int) flag
{
    if (!image) {
        return self;
    }
    return [self setImages:[NSArray arrayWithObject:image] origitation:flag];
}

@end
