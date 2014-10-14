//
//  BaseSectionTableViewController.m
//  sport
//
//  Created by micker on 5/21/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "BaseSectionTableViewController.h"

@interface BaseSectionTableViewController ()

@property (nonatomic, retain) UIView   *sectionView, *backImageView;
@end

@implementation BaseSectionTableViewController
{
    float _width ;
    int   _oldIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_titleArray);
    [super reduceMemory];
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 40, 320.0, kContentBoundsHeight-40);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _oldIndex = -1;
    _currentIndex = -1;
    [self configSectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) configSectionView
{
    self.sectionView                 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    self.sectionView.backgroundColor = kClearColor;
    CALayer *layer                   = [CALayer layer];
    layer.backgroundColor            = [kLightGrayColor CGColor];
    layer.frame                      = CGRectMake(0, 39.8f, 320, 0.2f);
    [self.sectionView.layer addSublayer:layer];
    [self.view addSubview:self.sectionView];
    return self;
}

- (void) setTitleArray:(NSMutableArray *)titleArray
{
    if (_titleArray != titleArray) {
        [_titleArray release];
        _titleArray = [titleArray retain];
        [self configTitles];
    }
}

- (id) configTitles
{
    [self.sectionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int total = [self.titleArray count];
    if (total > 0) {
        float padding = 0;
        _width = (320 - (total + 1) * padding ) / total + padding;
        if (!self.backImageView) {
            self.backImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(padding, 0, _width, 40)] autorelease];
            self.backImageView.backgroundColor = kGreenColor;
        }
        [self.sectionView addSubview:self.backImageView];
        for (int i = 0 ; i < total; i++ ) {
            UIButton *button           = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame               = CGRectMake(_width * i , 0,  _width - padding, 40);
            button.backgroundColor     = kClearColor;
            button.tag                 = 333 + i;
            button.titleLabel.font     = HTFONTSIZE(kFontSize16);
            [button setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.sectionView addSubview:button];
        }
    }
    return self;
}

- (IBAction)sectionButtonAction:(id)sender
{
    UIButton *button = (UIButton *) sender;
    if (button) {
        int tag = button.tag - 333;
        [self setCurrentIndex:tag];
        [self didSelected:tag];
    }
}

- (void) setCurrentIndex:(NSUInteger)currentIndex
{
    if (_currentIndex != currentIndex) {
        _oldIndex = _currentIndex;
        _currentIndex = currentIndex;
        __block BaseSectionTableViewController *blockSelf = self;
        [UIView animateWithDuration:0.15f
                         animations:^{
                             [_backImageView setFrameX:_width * _currentIndex];
        }
                         completion:^(BOOL finished) {
                             
                             UIButton *oldButton = (UIButton *)[blockSelf.sectionView viewWithTag:333+_oldIndex];
                             UIButton *newButton = (UIButton *)[blockSelf.sectionView viewWithTag:333+_currentIndex];
                             if (oldButton) {
                                 [oldButton setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];
                             }
                             if (newButton) {
                                 [newButton setTitleColor:kBlackColor forState:UIControlStateNormal];
                             }
        }];
        
    }
}

- (void) didSelected:(NSUInteger ) index
{
    
}


@end
