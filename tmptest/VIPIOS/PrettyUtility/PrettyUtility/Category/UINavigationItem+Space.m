//
//  UINavigationItem+Space.m
//  sfdl
//
//  Created by micker on 6/8/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "UINavigationItem+Space.h"

@implementation UINavigationItem (Space)

- (UIBarButtonItem *)spacer
{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                           target:nil action:nil];
    space.width = -20.0f;
    return space ;
}


- (UIBarButtonItem *)rightSpacer
{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                           target:nil action:nil];
    space.width = -16.0f;
    return space ;
}

-(void)mySetLeftBarButtonItem:(UIBarButtonItem*)barButton
{
    NSArray* barButtons = nil;
    if (IS_IOS_7_OR_GREATER) {
        barButtons = [NSArray arrayWithObjects: [self spacer], barButton,nil ];
    } else {
        barButtons = [NSArray arrayWithObjects: barButton,nil ];
    }
    [self setLeftBarButtonItems: barButtons];
}

-(void)mySetRightBarButtonItem:(UIBarButtonItem*)barButton
{
    NSArray* barButtons = nil;
    if (IS_IOS_7_OR_GREATER) {
        barButtons = [NSArray arrayWithObjects: [self rightSpacer], barButton,nil ];
        
    } else {
        barButtons = [NSArray arrayWithObjects: barButton,nil ];
    }
    [self setRightBarButtonItems: barButtons];
}

@end
