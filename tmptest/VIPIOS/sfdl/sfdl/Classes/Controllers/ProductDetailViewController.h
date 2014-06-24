//
//  ProductDetailViewController.h
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ViewPagerController.h"
#import "ProductRequest.h"
#import "ProductResponse.h"

@interface ProductDetailViewController : ViewPagerController
@property (nonatomic, retain) ProductItem *productItem;

@end



@interface ProductDetailIntroController : BaseViewController

@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)UILabel *labelTwo;
@property(nonatomic, retain)UIWebView *webView;

@property (nonatomic, retain) ProductItem *productItem;
@property (nonatomic, retain) ViewProductRequest        *request;
@property (nonatomic, retain) ProductDetailResponse     *response;
@end



@interface ProductDetailCommentController : BaseTableViewController
@property (nonatomic, retain) ProductItem *productItem;
@property (nonatomic, retain) CommentListRequest    *request;
@property (nonatomic, retain) CommentsResponse      *response;
@end