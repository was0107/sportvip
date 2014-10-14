//
//  CustomSelectControl.m
//  Discount
//
//  Created by micker on 7/3/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "CustomSelectControl.h"


@interface MyToolbar : UIToolbar
{
}
@end

@implementation MyToolbar
- (void) drawRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    [[UIColor colorWithRed:64.0f/255.0f
                     green:64.0f/255.0f
                      blue:64.0f/255.0f
                     alpha:1.0f] set];
    
    CGRect myRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGContextFillRect(ctx, myRect);
    
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(ctx);
    UIGraphicsEndImageContext();
}
@end


@interface CustomSelectControl()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, assign) UIViewController *controller;
@property (nonatomic, retain) UIView           *selectItemView;


@end

@implementation CustomSelectControl
@synthesize selectItemView  = _selectItemView;
@synthesize pickerView      = _pickerView;
@synthesize controller      = _controller;
@synthesize contentArray    = _contentArray;
@synthesize block           = _block;
@synthesize cellViewBlock   = _cellViewBlock;
@synthesize cellBlock       = _cellBlock;
@synthesize componetBlock    = _componetBlock;
@synthesize componetRowsBlock = _componetRowsBlock;
@synthesize widthBlock      = _widthBlock;
@synthesize didSelectBlock  = _didSelectBlock;
@synthesize tipLabel        = _tipLabel;

- (id) initWithController:(UIViewController *) controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}

-(UIView *)selectItemView
{
    if (!_selectItemView)
    {
        _selectItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 260+44)];
        _selectItemView.backgroundColor = kWhiteColor;
        
        
        
        MyToolbar * toolbar = [[[MyToolbar alloc]initWithFrame:CGRectMake(0, 220, 320, 44)] autorelease];
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.backgroundColor = kLightGrayColor;
        UIBarButtonItem *flexibleButton  = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil] autorelease];
        UIBarButtonItem *rightButton  = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style: UIBarButtonItemStyleDone target: self action: @selector(selectDone:)] autorelease];
        UIBarButtonItem *fixedButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]  autorelease];
        fixedButton.width = 50;
        
        rightButton.tintColor = [UIColor getColor:KCustomGreenColor];
        toolbar.tintColor = kLightGrayColor;
        [toolbar setItems: @[fixedButton,flexibleButton,rightButton, flexibleButton,fixedButton]];
        [_selectItemView addSubview:toolbar];
        [_selectItemView addSubview:self.tipLabel];
        [_selectItemView addSubview:self.pickerView];
    }
    return _selectItemView;
}

- (UILabel *) tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 320, 20)];
        _tipLabel.backgroundColor = kClearColor;
        _tipLabel.font = HTFONTSIZE(kFontSize14);
        _tipLabel.textAlignment = UITextAlignmentCenter;
        _tipLabel.textColor = [UIColor getColor:KCustomGreenColor];
    }
    return _tipLabel;
}


- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 220)];
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    
    return _pickerView;
}

- (void) setContentArray:(NSMutableArray *)contentArray
{
    if (_contentArray != contentArray) {
        [_contentArray release];
        _contentArray = [contentArray retain];
        
        [_pickerView reloadAllComponents];
    }
}

-(void)reloadAllComponents
{
     [_pickerView reloadAllComponents];
}

-(IBAction) selectCancel:(id)sender
{
    [self dissmissContent:YES];
}

-(void)selectDone:(id)sender
{
    [self dissmissContent:NO];
    if (self.block && _contentArray) {  //当只有1个component时，直接返回当前选中的值。
        self.block([_contentArray objectAtIndex:_currentIndex]);
    }
    else if (self.block) {  //当有多个component时，传入UIPickerView对象，供其进行操作。
        self.block(_pickerView);
    }
}

- (id) showContent:(BOOL) flag
{
    if (self.selectItemView.superview) {
        return self;
    }
    __block CustomSelectControl  *blockSelf = self;
    CGRect rect = self.selectItemView.bounds;
    rect.origin.y = 40;
    rect.size.height = 0;
    self.selectItemView.alpha = 0.2f;
    self.selectItemView.frame = rect;
    if (self.belowView) {
        [self.controller.view insertSubview:self.selectItemView  belowSubview:self.belowView];
    } else {
        [self.controller.view addSubview:self.selectItemView];
    }
    CGFloat height = 40;
    [UIView animateWithDuration:flag?0.25f:0.0f
                     animations:^
    {
        blockSelf.selectItemView.frame = CGRectMake(0, height, 320, 260);
        blockSelf.selectItemView.alpha = 1;
    }];
    
    return self;
}

- (id) dissmissContent:(BOOL) flag
{
    if (!self.selectItemView.superview) {
        return self;
    }
    __block CustomSelectControl  *blockSelf = self;
    CGFloat height = self.controller.view.bounds.size.height;
    [UIView animateWithDuration:flag?0.25f:0.0f
                     animations:^
     {
         blockSelf.selectItemView.frame = CGRectMake(0, 44, 320, 0);
     }
                     completion:^(BOOL finished)
     {
         [blockSelf.selectItemView removeFromSuperview];
         blockSelf.selectItemView.alpha = 0.2f;
         blockSelf.contentArray = nil;
     }];
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_contentArray);
    TT_RELEASE_SAFELY(_block);
    TT_RELEASE_SAFELY(_cellBlock);
    TT_RELEASE_SAFELY(_cellViewBlock);
    TT_RELEASE_SAFELY(_pickerView);
    TT_RELEASE_SAFELY(_selectItemView);
    TT_RELEASE_SAFELY(_componetBlock);
    TT_RELEASE_SAFELY(_componetRowsBlock);
    TT_RELEASE_SAFELY(_widthBlock);
    TT_RELEASE_SAFELY(_didSelectBlock);
    TT_RELEASE_SAFELY(_tipLabel);
    [super dealloc];
}

- (void) setCurrentIndex:(int)currentIndex
{
    _currentIndex = currentIndex;
    [_pickerView selectRow:_currentIndex inComponent:0 animated:YES];
}

-(void)setSecondIndex:(int)secondIndex
{
    _secondIndex = secondIndex;
    [_pickerView selectRow:_secondIndex inComponent:1 animated:YES];
}

- (id) selectRow:(NSInteger) row at:(NSInteger) compnent
{
    [_pickerView selectRow:row inComponent:compnent animated:YES];
    return self;
}

#pragma mark
#pragma mark UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.componetBlock) {
        return  _componetBlock(pickerView);
    }
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.componetRowsBlock) {
        return  _componetRowsBlock(pickerView,component);
    }
    return (_contentArray) ? [_contentArray count] : 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.cellBlock) {
       return  _cellBlock(pickerView, row, component);
    }
    return @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (self.cellViewBlock) {
        return  _cellViewBlock(pickerView, row, component,view);
    }
    UIView *content = (UIView *)view;
    UILabel *labelContent = (UILabel *)[view viewWithTag:100];;
    if (!content) {
        CGFloat width = 300.0f;
        if (self.widthBlock) {
            width = _widthBlock(pickerView,component);
        }
        content = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)] autorelease];
        content.backgroundColor = kClearColor;
        labelContent = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, width, 40)] autorelease];
        labelContent.backgroundColor = kClearColor;
        labelContent.font = HTFONTSIZE(kFontSize18);
        labelContent.textColor = kBlackColor;
        labelContent.highlightedTextColor = kWhiteColor;
        labelContent.tag = 100;
        [content addSubview:labelContent];
    }
    if (self.cellBlock) {
        labelContent.text =_cellBlock(pickerView, row, component);
    }
    return content;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.widthBlock) {
        return  _widthBlock(pickerView,component);
    }
    return 300;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.didSelectBlock) {
        _didSelectBlock(pickerView,row,component);
    } else {
        _currentIndex = row;
    }
}

@end


#pragma mark ==
#pragma mark CustomDatePickerControl

@interface CustomDatePickerControl()
@property (nonatomic, assign) UIViewController *controller;
@property (nonatomic, retain) UIView           *selectItemView;


@end
@implementation CustomDatePickerControl
@synthesize selectItemView  = _selectItemView;
@synthesize pickerView      = _pickerView;
@synthesize controller      = _controller;
@synthesize block           = _block;

- (id) initWithController:(UIViewController *) controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}

-(UIView *)selectItemView
{
    if (!_selectItemView)
    {
        _selectItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 156, 320, 280+44)];
        _selectItemView.backgroundColor = kClearColor;
//        UIView *toolbarBGview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//        toolbarBGview.backgroundColor = kLightGrayColor;
        MyToolbar * toolbar = [[[MyToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
//        [toolbar addSubview:toolbarBGview];
//        toolbar.barStyle = UIBarStyleBlackOpaque;
//        toolbar.backgroundColor = kLightGrayColor;
 
        toolbar.opaque = NO;
        toolbar.backgroundColor = [UIColor clearColor];
        toolbar.clearsContextBeforeDrawing = YES;
        UIBarButtonItem *leftButton  = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target: self action: @selector(selectCancel:)] autorelease];
        UIBarButtonItem *flexibleButton  = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil] autorelease];
        UIBarButtonItem *rightButton  = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style: UIBarButtonItemStyleDone target: self action: @selector(selectDone:)] autorelease];
//        leftButton.tintColor = kGrayColor;
//        rightButton.tintColor = kGrayColor;
        [toolbar setItems: @[leftButton,flexibleButton, rightButton]];
        [_selectItemView addSubview:toolbar];
        [_selectItemView addSubview:self.pickerView];
    }
    return _selectItemView;
}


- (UIDatePicker *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, 0, 0)];
        _pickerView.datePickerMode = UIDatePickerModeDate;
        _pickerView.maximumDate = [NSDate date];
    }
    return _pickerView;
}

- (id) showContent:(BOOL) flag
{
    if (self.selectItemView.superview) {
        return self;
    }
    __block CustomDatePickerControl  *blockSelf = self;
    CGRect rect = self.selectItemView.bounds;
    rect.origin.y = self.controller.view.bounds.size.height+260;
    self.selectItemView.frame = rect;
    [self.controller.view addSubview:self.selectItemView];
    CGFloat height = self.controller.view.bounds.size.height - 260;
    [UIView animateWithDuration:flag?0.25f:0.0f
                     animations:^
     {
         blockSelf.selectItemView.frame = CGRectMake(0, height, 320, 260);
     }];
    return self;
}

- (id) dissmissContent:(BOOL) flag
{
    if (!self.selectItemView.superview) {
        return self;
    }
    __block CustomDatePickerControl  *blockSelf = self;
    CGFloat height = self.controller.view.bounds.size.height;
    [UIView animateWithDuration:flag?0.25f:0.0f
                     animations:^
     {
         blockSelf.selectItemView.frame = CGRectMake(0, height, 320, 300);
     }
                     completion:^(BOOL finished)
     {
         [blockSelf.selectItemView removeFromSuperview];
     }];
    return self;
}

-(IBAction) selectCancel:(id)sender
{
    [self dissmissContent:YES];
}

-(void)selectDone:(id)sender
{
    [self dissmissContent:YES];
    if (self.block) {
        self.block([_pickerView date ]);
    }
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_block);
    TT_RELEASE_SAFELY(_pickerView);
    TT_RELEASE_SAFELY(_selectItemView);
    [super dealloc];
}



@end
