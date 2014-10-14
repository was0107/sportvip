//
//  UIImageView+(ASI).m
//  comb5mios
//
//  Created by micker on 7/23/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>

#import "UIImageView+(ASI).h"


@implementation UIImageView(ASI)

- (void)setImageWithURLString:(NSString *)url
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure
{
    
    [self setImageWithURL:[NSURL URLWithString:url]
                  success:success
                  failure:failure];
}

- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholder
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure
{
    [self setImageWithURL:[NSURL URLWithString:url]
         placeholderImage:[UIImage imageNamed:placeholder]
                  success:success
                  failure:failure];
}

- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholder
                      options:(SDWebImageOptions)options
                      success:(void (^)(UIImage *image))success
                      failure:(void (^)(NSError *error))failure
{
    [self setImageWithURL:[NSURL URLWithString:url]
         placeholderImage:[UIImage imageNamed:placeholder]
                  options:options
                  success:success
                  failure:failure];
}

-(void)cancelDownloadImage
{
    [self cancelCurrentImageLoad];
}


@end