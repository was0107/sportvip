//
//  AboutUsViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AboutUsViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "RTLabel.h"


@interface AboutUsViewController ()
@property (nonatomic, retain) CompanyInfoRequest *request;
@property (nonatomic, retain) AboutUsResponse    *response;
@property(nonatomic, retain)UIImageView * iconImageView;
@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)UIWebView *labelTwo;

@end

@implementation AboutUsViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_iconImageView);
    TT_RELEASE_SAFELY(_labelOne);
    TT_RELEASE_SAFELY(_labelTwo);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showType] showRight];
    [self setTitleContent:@"ABOUT US"];
    [self.tableView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRequestToGetCompanyServer) name:@"sendRequestToGetCompanyServer" object:nil];
//    [self.view addSubview:self.iconImageView];
//    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.labelTwo];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sendRequestToGetCompanyServer];
}


- (void)sendRequestToGetCompanyServer
{
    typeof(self) blockSelf = self;
    if ([[[AppDelegate sharedAppDelegate] rootController] aboutResponse]) {
        blockSelf.response = [[[AppDelegate sharedAppDelegate] rootController] aboutResponse];
        [blockSelf.labelTwo loadHTMLString:blockSelf.response.companyDes baseURL:nil];
        return;
    }
    [[[AppDelegate sharedAppDelegate] rootController] sendRequestToGetCompanyServer];
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:kAboutLogoFrame];
        _iconImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _iconImageView;
}

-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:CGRectMake(8, 44, 304, 20)];
        _labelOne.textColor  = [UIColor getColor:kCellLeftColor];
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kFontSize14);
//        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//        _labelOne.text = version;
    }
    return _labelOne;
}

-(UIWebView *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, kContentBoundsHeight-0)];
//        _labelTwo.textColor  = [UIColor getColor:kCellLeftColor];
//        _labelTwo.textAlignment = NSTextAlignmentCenter;
        _labelTwo.backgroundColor = kClearColor;
//        _labelTwo.font = HTFONTSIZE(kSystemFontSize14);
//        _labelTwo.text = lLabelTwoString;
//        _labelTwo.numberOfLines = 0;
        
    }
    return _labelTwo;
}

@end
