//
//  UIImageLabelEx.m
//  sport
//
//  Created by Erlang on 14-6-2.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "UIImageLabelEx.h"
#import "UIView+extend.h"

#define kImageWidthHeight   20.0f
#define kImageWidthHeight2  20.0f
#define kImageSpace         2.0f

@interface UIImageLabelEx()
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) NSMutableArray *layerArray;
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
        self.imageSize = CGSizeMake(kImageWidthHeight, kImageWidthHeight2);
    }
    return self;
}

- (id) setInternalImages
{
    int total  =  [self.imageArray count];
    if (!self.layerArray) {
        self.layerArray = [NSMutableArray array];
    }
    if (total > 0) {
        
        float space = total * (self.imageSize.width + kImageSpace);
        UIView *superView = self.superview;
        
        CGRect rect = self.frame;
        if (0 == _origitation) {
            [self setExtendWidth:space];
        }
        else  if (1 == _origitation) {
            [self setFrameWidth:self.width - space];
        }
        
        if (superView) {
            [self.layerArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            for (int i = 0; i < total; i++) {
                UIImageView *layer = [[[UIImageView alloc] init] autorelease];
                NSString *imageName = [self.imageArray objectAtIndex:i];
                if ([imageName hasPrefix:@"http"]) {
                    [layer setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"icon"]];
                } else {
                    layer.image = [UIImage imageNamed:imageName];
                }
                
                if (0 == _origitation) {
                    layer.frame = CGRectMake(rect.origin.x + i * (self.imageSize.width + kImageSpace), rect.origin.y + 2, self.imageSize.width,  self.imageSize.height);
                } else  if (1 == _origitation) {
                    layer.frame = CGRectMake(rect.origin.x + rect.size.width - (total - i) *  (self.imageSize.width + kImageSpace), rect.origin.y + 2,  self.imageSize.width,  self.imageSize.height);
                } else  if (2 == _origitation) {
                    layer.frame = CGRectMake(rect.origin.x + 10 , rect.origin.y + rect.size.height  + kImageSpace,  self.imageSize.width,  self.imageSize.height);
                } else  if (3 == _origitation) {
                    layer.frame = CGRectMake(0, 0,  self.imageSize.width,  self.imageSize.height);
                }
                [superView addSubview:layer];
                [self.layerArray addObject:layer];
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


- (id) shiftPositionY:(CGFloat) flag
{
    for (UIView *layer in self.layerArray) {
        CGRect rect = [layer frame];
        rect.origin.y += flag;
        layer.frame = rect;
    }
    return self;
}

- (id) shiftPositionX:(CGFloat) flag
{
    for (CALayer *layer in self.layerArray) {
        CGRect rect = [layer frame];
        rect.origin.x += flag;
        layer.frame = rect;
    }
    return self;
}

- (void) removeFromSuperview
{
    [super removeFromSuperview];
    [self.layerArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


@end
