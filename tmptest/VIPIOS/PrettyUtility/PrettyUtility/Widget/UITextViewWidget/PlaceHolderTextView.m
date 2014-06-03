//
//  PlaceHolderTextView.m
//  PrettyUtility
//
//  Created by Jarry on 13-1-8.
//  Copyright (c) 2013年 B5M. All rights reserved.
//

#import "PlaceHolderTextView.h"

@implementation PlaceHolderTextView

@synthesize placeHolderLabel;
@synthesize placeholder;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [placeHolderLabel release]; placeHolderLabel = nil;
    [placeholder release]; placeholder = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:CGRectIntegral(frame)]) )
    {
        [self setPlaceholder:@""];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = [UIColor grayColor];
            placeHolderLabel.shadowColor   = kWhiteColor;
            placeHolderLabel.shadowOffset  = CGSizeMake(1, 1); 
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //Set the line color and width
//    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] colorWithAlphaComponent:0.1].CGColor);
//    CGContextSetLineWidth(context, 1.0f);
//    
//    
//    //Start a new Path
//    CGContextBeginPath(context);
//	
//    //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
//    NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font.leading;
//	
//    //Set the line offset from the baseline. (I'm sure there's a concrete way to calculate this.)
//    CGFloat baselineOffset = 6.0f;
//	
//    //iterate over numberOfLines and draw each line
//    for (int x = 1; x < numberOfLines; x++) {
//        
//        //0.5f offset lines up line with pixel boundary
//        CGContextMoveToPoint(context, self.bounds.origin.x+10, self.font.leading*x + 0.5f + baselineOffset);
//        CGContextAddLineToPoint(context, self.bounds.size.width-10, self.font.leading*x + 0.5f + baselineOffset);
//    }
//	
//    //Close our Path and Stroke (draw) it
//    CGContextClosePath(context);
//    CGContextStrokePath(context);

    
    [super drawRect:rect];
}

@end