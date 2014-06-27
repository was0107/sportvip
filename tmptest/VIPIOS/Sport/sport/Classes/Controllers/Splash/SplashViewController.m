//
//  SplashViewController.m
//  sport
//
//  Created by allen.wang on 4/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "SplashViewController.h"

#define kNumberOfPages 1

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define kPageHeight IS_IPHONE_5 ? 568.0f : 480.0f
#define kPageWidth  [[UIScreen mainScreen] bounds].size.width
@interface SplashViewController ()<UIScrollViewDelegate>

@property(nonatomic, retain) UIScrollView *scrollView;

@end

@implementation SplashViewController

- (void)dealloc
{
    DEBUGLOG(@"user guide dealloc.");
    [_scrollView release];
    [super dealloc];
}

-(void)loadView
{
    [super loadView];
    [self.view addSubview:[self scrollView]];
    
    NSArray *imageNames;
    if (IS_IPHONE_5) {
        imageNames = @[@"Default-568h", @"guide_iphone5_2"];
    }else{
        imageNames = @[@"Default", @"guide_iphone4_2"];
    }
    
    if (IS_IPHONE_5) {
        imageNames = @[@"guide_iphone5_2"];
    }else{
        imageNames = @[@"guide_iphone4_2"];
    }
    
    UIImageView *guideImage;
	CGRect imageFrame;
	for (int photoIndex = 0 ; photoIndex < kNumberOfPages ; photoIndex++)
	{
		imageFrame = CGRectMake(photoIndex * kPageWidth, 0.0f, kPageWidth, kPageHeight);
		guideImage = [[UIImageView alloc] initWithFrame: imageFrame];
        guideImage.image = [UIImage imageNamed:[imageNames objectAtIndex:photoIndex]];
		[_scrollView addSubview: guideImage];
        if (photoIndex == kNumberOfPages -1 ) {
            guideImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoRoot:)] autorelease];
            [guideImage addGestureRecognizer:gesture];
        }
		[guideImage release];
	}
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, kPageWidth, kPageHeight);
        _scrollView.contentSize = CGSizeMake(kPageWidth * kNumberOfPages, kPageHeight);
        _scrollView.pagingEnabled = YES;
        [_scrollView setBackgroundColor:[UIColor darkGrayColor]];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollView;
}

- (void) gotoRoot:(UIGestureRecognizer *)recognizer
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate goToRootController];
}
@end
