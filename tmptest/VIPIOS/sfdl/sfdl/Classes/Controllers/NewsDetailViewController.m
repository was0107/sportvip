//
//  NewsDetailViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "ProductRequest.h"
#import "ProductResponse.h"

@interface NewsDetailViewController ()
@property (nonatomic, retain) ViewNewsRequest *request;
@property (nonatomic, retain) NewsDetailResponse *response;
@property(nonatomic, retain)UIImageView * iconImageView;
@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)UIWebView *content;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"News";
    [self.scrollView removeFromSuperview];
    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.content];
    self.labelOne.text = self.newItem.newsTitle;
    [self sendRequestToServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) useTablViewToShow
{
    return NO;
}


- (CGRect)tableViewFrame
{
    return CGRectMake(0, 64, 320.0, kContentBoundsHeight-64);
}


-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 300, 24)];
        _labelOne.textColor  = [UIColor getColor:kCellLeftColor];
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kSystemFontSize17);
    }
    return _labelOne;
}


-(UIWebView *)content
{
    if (!_content)
    {
        _content = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, kContentBoundsHeight-64)];
        _content.backgroundColor = kClearColor;
        
    }
    return _content;
}

- (void)sendRequestToServer
{
    __unsafe_unretained NewsDetailViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.response = [[[NewsDetailResponse alloc] initWithJsonString:content] autorelease];
        [safeSelf.content loadHTMLString:safeSelf.response.item.content baseURL:nil];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    if (!self.request) {
        self.request = [[[ViewNewsRequest alloc] init] autorelease];
    }
    self.request.newsId = self.newItem.newsId;
    [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}


@end
