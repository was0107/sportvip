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
#import "GrowAndDownControl.h"
#import "UIKeyboardAvoidingScrollView.h"

@interface ProductDetailViewController : ViewPagerController
@property (nonatomic, retain) ProductItem *productItem;

@end



@interface ProductDetailIntroController : BaseViewController
@property (nonatomic, assign)  UINavigationController *parentNavigationController;
@property(nonatomic, retain)UILabel *labelOne;
@property(nonatomic, retain)GrowAndDownControl *labelTwo;
@property(nonatomic, retain)UIImageView *leftImageView;
@property(nonatomic, retain)UIWebView *webView;
@property(nonatomic, retain)UIButton  *rightButton;

@property (nonatomic, retain) ProductItem *productItem;
@property (nonatomic, retain) ViewProductRequest        *request;
@property (nonatomic, retain) ProductDetailResponse     *response;


@end



@interface ProductDetailCommentController : BaseTableViewController <UITextViewDelegate>
@property (nonatomic, retain) UITextView *commentView;
@property (nonatomic, retain) UIButton   *submitButton;
@property (nonatomic, retain) UIView     *footerView;
@property (nonatomic, assign)  UINavigationController *parentNavigationController;
@property (nonatomic, retain) ProductItem *productItem;
@property (nonatomic, retain) CommentListRequest    *request;
@property (nonatomic, retain) CommentsResponse      *response;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;


@end