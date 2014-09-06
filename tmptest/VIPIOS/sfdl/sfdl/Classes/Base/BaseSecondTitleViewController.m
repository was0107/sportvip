//
//  BaseSecondTitleViewController.m
//  sfdl
//
//  Created by allen.wang on 6/5/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "BaseSecondTitleViewController.h"

@interface BaseSecondTitleViewController ()
@end

@implementation BaseSecondTitleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.secondTitleLabel];
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [KLineColor CGColor];
    lineLayer.frame = CGRectMake(10, 38, 300, 2);
    [self.view.layer addSublayer:lineLayer];
    
    if (![self useTablViewToShow]) {
        [self.view addSubview:self.scrollView];
    } else {
        [self.view addSubview:self.tableView];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 40, 320.0, kContentBoundsHeight-40);
}

- (UILabel *) secondTitleLabel
{
    if (!_secondTitleLabel) {
        _secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 300, 24)];
        _secondTitleLabel.backgroundColor = kClearColor;
        _secondTitleLabel.textColor = KTextColor;
        _secondTitleLabel.highlightedTextColor = kWhiteColor;
        _secondTitleLabel.font = HTFONTSIZE(kFontSize15);
    }
    return _secondTitleLabel;
}

- (UIKeyboardAvoidingScrollView *) scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIKeyboardAvoidingScrollView alloc] initWithFrame:[self tableViewFrame]];
        _scrollView.backgroundColor = kClearColor;
    }
    return _scrollView;
}


- (void) dealloc
{
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_secondTitleLabel);
    [super dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
