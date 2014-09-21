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
@property(nonatomic, retain)UILabel *labelOne, *labelTwo;
@property(nonatomic, retain) UIView *topView, *bottomView;
@property(nonatomic, retain)UIWebView *content;
@property(nonatomic, retain) UIButton *preButton, *nextButton;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.secondTitleLabel.text = @"News";
    [self setTitleContent:@"NEWS"];
    self.scrollView.backgroundColor = kWhiteColor;
    [self.scrollView removeFromSuperview];
    [self.content.scrollView addSubview:self.topView];
    [self.view addSubview:self.content];
    [self.content.scrollView setContentInset:UIEdgeInsetsMake(80,0,80,0)];
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

- (UIView *) topView
{
    if (!_topView) {
        _topView = [[[UIView alloc] initWithFrame:CGRectMake(0, -80, 320, 80)] autorelease];
        _topView.backgroundColor = kWhiteColor;
        UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 79, 320, 1)] autorelease];
        lineView.backgroundColor = kLightGrayColor;
        lineView.alpha = 0.5f;
        [_topView addSubview:lineView];
        
        [_topView addSubview:self.labelOne];
        [_topView addSubview:self.labelTwo];
    }
    return _topView;
}

- (UIView *) bottomView
{
    if (!_bottomView) {
        _bottomView = [[[UIView alloc] initWithFrame:CGRectMake(0, kContentBoundsHeight-70, 320, 70)] autorelease];
        _bottomView.backgroundColor = kWhiteColor;
        UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 79, 320, 1)] autorelease];
        lineView.backgroundColor = kLightGrayColor;
        lineView.alpha = 0.5f;
        [_bottomView addSubview:lineView];
        
        self.preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.preButton.backgroundColor = kClearColor;
        self.preButton.frame = CGRectMake(0, 4, 320, 30);
        [self.preButton addTarget:self action:@selector(preAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextButton.backgroundColor = kClearColor;
        self.nextButton.frame = CGRectMake(0, 36, 320, 30);
        [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:self.preButton];
        [_bottomView addSubview:self.nextButton];
    }
    return _bottomView;
}

- (void) NewsItemChanged:(NSUInteger ) index
{
    NSUInteger total = [self.newsList count];
    
    if (NSNotFound == index) {
        [self.bottomView setHidden:YES];
    } else if (0 == index) {
        [self.preButton setEnabled:NO];
        [self.preButton setTitle:@"Previous:--" forState:UIControlStateNormal];
        if (index + 1 < total) {
            NewsItem *NextItem = [self.newsList objectAtIndex:index + 1];
            [self.nextButton setTitle:[NSString stringWithFormat:@"Next:%@",NextItem.content] forState:UIControlStateNormal];
            [self.nextButton setEnabled:YES];
        }
        
    } else if ( (total - 1) == index) {
        if (index > 0) {
            NewsItem *NextItem = [self.newsList objectAtIndex:index -1];
            [self.preButton setTitle:[NSString stringWithFormat:@"Previous:%@",NextItem.content] forState:UIControlStateNormal];
            [self.preButton setEnabled:YES];
        }
        
        [self.nextButton setEnabled:NO];
        [self.nextButton setTitle:@"Next:--" forState:UIControlStateNormal];
        
    } else {
        
        if (index > 0) {
            [self.preButton setEnabled:YES];
            NewsItem *NextItem = [self.newsList objectAtIndex:index -1];
            [self.preButton setTitle:[NSString stringWithFormat:@"Previous:%@",NextItem.content] forState:UIControlStateNormal];
        }
        if (index + 1 < total) {
            [self.nextButton setEnabled:YES];
            NewsItem *NextItem = [self.newsList objectAtIndex:index + 1];
            [self.nextButton setTitle:[NSString stringWithFormat:@"Next:%@",NextItem.content] forState:UIControlStateNormal];
        }
    }
    
    [self goToNews];
}

- (void) setNewItem:(NewsItem *)newItem
{
    if (_newItem != newItem) {
        [_newItem release];
        
        if (!_newItem) {
            return;
        }
        
        NSUInteger index =  [self.newsList indexOfObject:_newItem];
        [self NewsItemChanged:index];
    }
}

- (void) goToNews
{
    self.labelOne.text = self.newItem.newsTitle;
    self.labelTwo.text = self.newItem.creationTime;
    [self.content.scrollView setContentInset:UIEdgeInsetsMake(80,0,80,0)];
    [[self.content scrollView] scrollRectToVisible:CGRectMake(0, -80, 0, 0) animated:YES];
    [self sendRequestToServer];
}

- (IBAction)preAction:(id)sender
{
    
}

- (IBAction)nextAction:(id)sender
{
    
}





- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight-0);
}


-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 40)];
        _labelOne.textColor  = kBlackColor;
        _labelOne.backgroundColor = kClearColor;
        _labelOne.numberOfLines = 2;
        _labelOne.font = HTFONTSIZE(kSystemFontSize17);
    }
    return _labelOne;
}

-(UILabel *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, 300, 20)];
        _labelTwo.textColor  = kLightGrayColor;
        _labelTwo.backgroundColor = kClearColor;
        _labelTwo.numberOfLines = 2;
        _labelTwo.textAlignment = NSTextAlignmentRight;
        _labelTwo.font = HTFONTSIZE(kSystemFontSize14);
    }
    return _labelTwo;
}


-(UIWebView *)content
{
    if (!_content)
    {
        _content = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, kContentBoundsHeight)];
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
