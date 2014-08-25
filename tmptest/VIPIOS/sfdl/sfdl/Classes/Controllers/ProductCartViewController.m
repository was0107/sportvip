//
//  ProductCartViewController.m
//  sfdl
//
//  Created by allen.wang on 6/26/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductCartViewController.h"
#import "LoginResponse.h"
#import "LoginRequest.h"
#import "ProductResponse.h"
#import "ProductRequest.h"
#import "ProductCart.h"
#import "GrowAndDownControl.h"
#import "ProductDetailViewController.h"
#import "CreateObject.h"
#import "LoginViewController.h"

@interface ProductCartViewController ()
@property (nonatomic, retain) ProductListRequest *request;
@property (nonatomic, retain) ProductResponse    *response;

@end

@implementation ProductCartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"Product Carts";
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  44, 320.0, kContentBoundsHeight-44)] autorelease];
    self.scrollView.backgroundColor = kWhiteColor;
    [self.scrollView addSubview:self.tableView];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    [self enableBuyButton];
}

- (CGRect) tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight-40);
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __block ProductCartViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];//[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCartViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.topLabel.frame = CGRectMake(60, 10, 80, 50);
            cell.leftImageView .frame = CGRectMake(10, 10, 50, 50);
            cell.topLabel.numberOfLines = 2;
            cell.topLabel.textColor = kBlackColor;
            GrowAndDownControl *labelTwo = [[[GrowAndDownControl alloc]initWithFrame:CGRectMake(140, 0, 170, 40)] autorelease];
            labelTwo.tag = 1000;
            cell.topLabel.font = HTFONTSIZE(kFontSize15);
            [cell.rightButton setTitle:@"Remove" forState:UIControlStateNormal];
            cell.rightButton.backgroundColor = kButtonNormalColor;
            cell.rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            cell.rightButton.frame = CGRectMake(250, 40, 65, 30);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.leftImageView];
            [cell.contentView addSubview:labelTwo];
            [cell.contentView addSubview:cell.rightButton];
        }
        cell.contentView.tag  = 1024+indexPath.row;
        GrowAndDownControl *labelTwo = (GrowAndDownControl *)[cell.contentView viewWithTag:1000];
        ProductItem *item = [[[ProductCart sharedInstance] products] objectAtIndex:indexPath.row ];
        cell.topLabel.text = item.productName;
        cell.subLabel.text = item.productDesc;
        labelTwo.value = item.buyCount;
        labelTwo.content = item;
        cell.content = item;
        
        cell.block = ^(id content){
            [[[ProductCart sharedInstance] products] removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadData];
            [blockSelf enableBuyButton];
        };
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.productImg]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 100)];
                                        cell.leftImageView.image = image1;
                                    }
                                    failure:^(NSError *error){
                                        cell.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];
        labelTwo.block = ^(id content){
            GrowAndDownControl *labelTwo = (GrowAndDownControl *) content;
            ProductItem *item = labelTwo.content;
            item.buyCount = labelTwo.value;

        };
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[[[ProductCart sharedInstance] products] count];
    };
    
    self.tableView.cellEditBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  UITableViewCellEditingStyleDelete;
    };
    self.tableView.cellEditActionBlock = ^( UITableView *tableView, NSInteger editingStyle, NSIndexPath *indexPath){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [[[ProductCart sharedInstance] products] removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadData];
            [blockSelf enableBuyButton];
        }
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  70.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 30.0f;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return (NSInteger)1;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
        view.backgroundColor = kWhiteColor;
        NSString *keys[] = {@"Product",@"Items",@"Quantity"};
        int  align[] = {NSTextAlignmentLeft,NSTextAlignmentCenter,NSTextAlignmentRight};
        for (int i = 0 ; i < 3 ; i++) {
            
            UILabel *tipLabel = [[[UILabel alloc] initWithFrame:CGRectMake(i * 98 + 12, 3, 100, 24)] autorelease];
            tipLabel.backgroundColor = kClearColor;
            tipLabel.text = keys[i];
            tipLabel.textAlignment = align[i];
            tipLabel.font = HTFONTSIZE(kFontSize13);
            [view addSubview:tipLabel];
        }
        return (UIView *)view;
    };

    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ProductItem *item = [[[ProductCart sharedInstance] products] objectAtIndex:indexPath.row ];
        ProductDetailViewController *controller = [[[ProductDetailViewController alloc] init] autorelease];
        controller.productItem = item;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
    };
    
}

- (void) enableBuyButton
{
        [self.submitButton setEnabled:([[[ProductCart sharedInstance] products] count] > 0)];
}


- (UITextView *) commentView
{
    if (!_commentView) {
        _commentView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10+24, 300, 60)];
        _commentView.layer.cornerRadius = 2.0f;
        _commentView.layer.borderColor = [kBlueColor CGColor];
        _commentView.layer.borderWidth = 1.0f;
        _commentView.delegate = self;
    }
    return _commentView ;
}

- (UIButton *) goBackShoppingButton
{
    if (!_goBackShoppingButton) {
        _goBackShoppingButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _goBackShoppingButton.frame = CGRectMake(5, 120+24, 150, 30);
        [CreateObject addTargetEfection:_goBackShoppingButton];
        _goBackShoppingButton.titleLabel.font = HTFONTSIZE(kFontSize14);
        [_goBackShoppingButton setTitle:@"Continue Shopping" forState:UIControlStateNormal];
        [_goBackShoppingButton addTarget:self action:@selector(goBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackShoppingButton;
}

- (UIButton *) submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _submitButton.frame = CGRectMake(165, 120+24, 150, 30);
        _submitButton.titleLabel.font = HTFONTSIZE(kFontSize14);
        [CreateObject addTargetEfection:_submitButton];
        [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (UILabel *) tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75+24, 300, 40)];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = @"After you submit you order we will have professional within 24 hours and contact you";
        _tipLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _tipLabel;
}

- (UIView *) footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 160+24)];
       UILabel *tipLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 4, 300, 20)] autorelease];
        tipLabel1.text = @"Remark:";
        tipLabel1.font = HTFONTSIZE(kFontSize14);
        [_footerView addSubview:tipLabel1];
        [_footerView addSubview:self.commentView];
        [_footerView addSubview:self.tipLabel];
        [_footerView addSubview:self.goBackShoppingButton];
        [_footerView addSubview:self.submitButton];
        _footerView.backgroundColor = kClearColor;
    }
    return _footerView;
}

- (IBAction)goBackButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonAction:(id)sender
{
    if (self.commentView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Remark 不能为空"];
        return;
    }
    NSMutableString *quantityListId = [NSMutableString string];
    NSMutableString *listId = [NSMutableString string];
    NSMutableString *listTitle = [NSMutableString string];
    NSArray *listItems = [[[ProductCart sharedInstance] products] copy];
    int total = 0;
    for (int i = 0 ; i < [listItems count]; i++) {
        ProductItem *item = [listItems objectAtIndex:i];
        [listId appendFormat:@"%@,",item.productId];
        [listTitle appendFormat:@"%@,",item.productName];
        [quantityListId appendFormat:@"%d,",item.buyCount];
        total += item.buyCount;
    }
    
    if (total == 0) {
        return;
    }
    
    if (listId.length == 0 || listTitle.length ==0 ||quantityListId.length ==0  ) {
        return;
    }
    
    if ([[self currentUserId] length] == 0) {
        BaseTitleViewController *controller =  [[[LoginViewController alloc] init] autorelease];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        return ;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交订单..."];
    [self.commentView resignFirstResponder];
    __block ProductCartViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.commentView.text = @"";
        [SVProgressHUD showSuccessWithStatus:@"提交订单成功!"];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"提交订单失败"];
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [SVProgressHUD showErrorWithStatus:@"提交订单失败"];
    };
    CreateOrderRequest *addCommentRequest = [[[CreateOrderRequest alloc] init] autorelease];
    addCommentRequest.username = [UserDefaultsManager userName];
    addCommentRequest.content = self.commentView.text.length == 0 ? @"": self.commentView.text;
    addCommentRequest.title = [listTitle substringToIndex:listTitle.length - 1];
    addCommentRequest.productList = [listId substringToIndex:listId.length - 1];
//    addCommentRequest.quantityList = [quantityListId substringToIndex:quantityListId.length - 1];
    [WASBaseServiceFace serviceWithMethod:[addCommentRequest URLString] body:[addCommentRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) {
        [self.commentView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.commentView resignFirstResponder];
}

@end
