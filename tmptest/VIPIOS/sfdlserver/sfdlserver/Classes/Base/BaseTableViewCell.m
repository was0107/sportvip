//
//  BaseTableViewCell.m
//  Discount
//
//  Created by allen.wang on 5/29/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTableViewCell.h"


#pragma mark --
#pragma mark BaseTableViewCell

@interface BaseTableViewCornerCell()
@property (nonatomic, retain) UIImageView *topBg,*topSelBg;
@property (nonatomic, retain) UIImageView *midBg,*midSelBg;
@property (nonatomic, retain) UIImageView *botBg,*botSelBg;
@property (nonatomic, retain) UIImageView *oneBg,*oneSelBg;

@end
@implementation BaseTableViewCornerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = kWhiteColor;
        
        UIView *SELVIEW = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        SELVIEW.backgroundColor = KCellSelColor;
        self.selectedBackgroundView = SELVIEW;
//        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_topBg);
    TT_RELEASE_SAFELY(_topSelBg);
    TT_RELEASE_SAFELY(_midBg);
    TT_RELEASE_SAFELY(_midSelBg);
    TT_RELEASE_SAFELY(_botBg);
    TT_RELEASE_SAFELY(_botSelBg);
    TT_RELEASE_SAFELY(_oneBg);
    TT_RELEASE_SAFELY(_oneSelBg);
    [super dealloc];
}

- (UIImageView *) topBg
{
    if (!_topBg) {
        _topBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_top_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _topBg;
}
- (UIImageView *) topSelBg
{
    if (!_topSelBg) {
        _topSelBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_top_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _topSelBg;
}
- (UIImageView *) midBg
{
    if (!_midBg) {
        _midBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_middle_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _midBg;
}

- (UIImageView *) midSelBg
{
    if (!_midSelBg) {
        _midSelBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_middle_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _midSelBg;
}
- (UIImageView *) botBg
{
    if (!_botBg) {
        _botBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_bottom_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _botBg;
}
- (UIImageView *) botSelBg
{
    if (!_botSelBg) {
        _botSelBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_bottom_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _botSelBg;
}
- (UIImageView *) oneBg
{
    if (!_oneBg) {
        _oneBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_single_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _oneBg;
}
- (UIImageView *) oneSelBg
{
    if (!_oneSelBg) {
        _oneSelBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_single_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    }
    return _oneSelBg;
}
- (id)setCellsCount:(NSInteger ) number at:(NSIndexPath *)indexPath
{
    if (IS_IOS_7_OR_GREATER) {
//	self.backgroundView = nil;
//    self.backgroundColor = kClearColor;
	return self;
    }
    if (1 == number) {
        self.backgroundView = self.oneBg;
        self.selectedBackgroundView = self.oneSelBg;
    } else {
        if (0 == indexPath.row) {
            self.backgroundView = self.topBg;
            self.selectedBackgroundView = self.topSelBg;
        } else if ((number - 1) == indexPath.row ) {
            self.backgroundView = self.botBg;
            self.selectedBackgroundView = self.botSelBg;
        } else {
            self.backgroundView = self.midBg;
            self.selectedBackgroundView = self.midSelBg;
        }
    }
    return self;
}

- (id)setCellsGroupCount:(NSInteger ) number at:(NSIndexPath *)indexPath
{
    if (IS_IOS_7_OR_GREATER) {
        self.backgroundView = nil;
        //        self.backgroundColor = kClearColor;
        return self;
    }
    if (1 == number) {
        self.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_alone_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_alone_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
    } else {
        if (0 == indexPath.row) {
            self.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_top_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
            self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_top_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
        } else if ((number - 1) == indexPath.row ) {
            self.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_bottom_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
            self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_bottom_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
        } else {
            self.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_middle_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
            self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"list_middle_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]];
        }
    }
    return self;
}



@end

#pragma mark --
#pragma mark BaseTableViewCell

@implementation BaseTableViewCell
@synthesize topLabel = _topLabel;
@synthesize subLabel = _subLabel;
@synthesize leftImageView = _leftImageView;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_topLabel);
    TT_RELEASE_SAFELY(_subLabel);
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_textField);
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_block);
    [super dealloc];
}

- (UILabel *) topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _topLabel.backgroundColor = kClearColor;
        _topLabel.textColor = kDarkTextColor;
        _topLabel.highlightedTextColor = kWhiteColor;
        _topLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _topLabel;
}

- (UILabel *) subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subLabel.backgroundColor = kClearColor;
        _subLabel.textColor = kTableViewColor;
        _subLabel.highlightedTextColor = kWhiteColor;
        _subLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _subLabel;
}

- (UITextField *) textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.backgroundColor = kClearColor;
        _textField.font = HTFONTSIZE(kFontSize16);
        _textField.textColor = kDarkTextColor;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeyNext;

    }
    return _textField;
}

- (UIImageView *) leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 35,35)];
        _leftImageView.backgroundColor = kClearColor;
        _leftImageView.userInteractionEnabled = YES;
        _leftImageView.layer.borderColor = [kButtonNormalColor CGColor];;
        _leftImageView.layer.borderWidth = 2.0f;
        _leftImageView.layer.cornerRadius = 2.0f;
        _leftImageView.image = [UIImage imageNamed:@"btn_tab2"];
    }
    return _leftImageView;
}



-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_rightButton setTitleColor:kBlackColor forState:UIControlStateSelected];
        _rightButton.titleLabel.font = HTFONTSIZE(kSystemFontSize14);
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_rightButton addTarget:self action:@selector(buttonOneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}


-(IBAction)buttonOneAction:(id)sender
{
    if (self.block && self.content) {
        self.block(self.content);
    }
}

- (void) configWithType:(int) type
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (0 == type) {
        [self.topLabel setFrame:CGRectMake(10, 11, 80, 20)];
        [self.subLabel setFrame:CGRectMake(100, 11, 290, 20)];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.subLabel];
        [_leftImageView removeFromSuperview];
    } else if (1 == type)  {
        [self.topLabel setFrame:CGRectMake(44, 12, 70, 20)];
        [self.subLabel setFrame:CGRectMake(124, 12, 150, 20)];
        [self.leftImageView setFrame:CGRectMake(8, 8, 28, 28)];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView addSubview:self.leftImageView];
    } else if (2 == type) {
        [self.topLabel setFrame:CGRectMake(44, 12, 200, 20)];
        [self.leftImageView setFrame:CGRectMake(8, 8, 28, 28)];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.leftImageView];
    } else if (3 == type) {
        [self.topLabel setFrame:CGRectMake(66, 12, 200, 20)];
        [self.subLabel setFrame:CGRectMake(66, 38, 200, 20)];
        [self.leftImageView setFrame:CGRectMake(8, 8, 50, 50)];
         self.subLabel.textColor = kCustomRedColor;
        self.topLabel.font = HTFONTSIZE(kSystemFontSize16);
         self.subLabel.font = HTFONTSIZE(kSystemFontSize14);
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView addSubview:self.leftImageView];
    } else if (4 == type) { //bangbi
        self.topLabel.font = HTFONTSIZE(kFontSize16);
        [self.topLabel setFrame:CGRectMake(68, 26, 200, 20)];
        [self.leftImageView setFrame:CGRectMake(20, 20, 32, 32)];
        self.subLabel.textColor = kRedColor;
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.leftImageView];
    }else if (5 == type) { //favourate
        self.topLabel.font = HTFONTSIZE(kFontSize16);
        [self.topLabel setFrame:CGRectMake(14, 14, 200, 20)];
        [self.contentView addSubview:self.topLabel];
    }else if (6 == type) { //favourate add
        self.topLabel.font = HTFONTSIZE(kFontSize16);
        [self.topLabel setFrame:CGRectMake(14, 14, 200, 20)];
        [self.leftImageView setFrame:CGRectMake(280, 14.5, 15, 15)];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.leftImageView];
    }else if (7 == type) { //textfield
        [self.textField removeFromSuperview];
        [self.textField setFrame:CGRectMake(15, 12, 275, 20)];
        [self.contentView addSubview:self.textField];
    }else if (8 == type)  { // other archive
        [self.topLabel setFrame:CGRectMake(44, 14, 70, 20)];
        [self.subLabel setFrame:CGRectMake(120, 4, 155, 40)];
        self.subLabel.numberOfLines = 0;
        self.subLabel.font = HTFONTSIZE(kFontSize12);
        [self.leftImageView setFrame:CGRectMake(8, 10, 28, 28)];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView addSubview:self.leftImageView];
    }else if (9 == type)  { //autofill search cell
        [self.topLabel setFrame:CGRectMake(5, 5, 150, 30)];
        [self.subLabel setFrame:CGRectMake(160, 5, 150, 30)];
        self.topLabel.textColor = kBlackColor;
        self.subLabel.textColor = kDarkGrayColor;
        self.subLabel.font = HTFONTSIZE(kFontSize12);
        self.subLabel.textAlignment = NSTextAlignmentRight;
        [self.leftImageView setFrame:CGRectMake(8, 8, 28, 28)];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.subLabel];
    }else if (10 == type)
    {
        [self.topLabel setFrame:CGRectMake(60, 10, 100, 20)];
        [self.subLabel setFrame:CGRectMake(60, 35, 200, 15)];
        [self.leftImageView setFrame:CGRectMake(7, 7, 50, 50)];
        
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.subLabel];
        [self.contentView  addSubview:self.leftImageView];
    }
}


@end


#pragma mark ==
#pragma mark BaseSingleTableViewCell

@implementation BaseSingleTableViewCell
@synthesize topLabel = _topLabel;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_topLabel);
    [super dealloc];
}

- (UILabel *) topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 24)];
        _topLabel.backgroundColor = kClearColor;
        _topLabel.textColor = kDarkTextColor;
        _topLabel.font = HTFONTSIZE(kFontSize16);
    }
    return _topLabel;
}

@end

#pragma mark --
#pragma mark BaseNewTableViewCell

@implementation BaseNewTableViewCell
@synthesize topLabel      = _topLabel;
@synthesize subLabel      = _subLabel;
@synthesize leftImageView = _leftImageView;
@synthesize rightLabel    = _rightLabel;
@synthesize subRightLabel = _subRightLabel;
@synthesize rightImageView = _rightImageView;
@synthesize bgImageView    = _bgImageView;
@synthesize timeLabel      = _timeLabel;
@synthesize actionButtonOne = _actionButtonOne;
@synthesize actionButtonTwo = _actionButtonTwo;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_topLabel);
    TT_RELEASE_SAFELY(_subLabel);
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_rightLabel);
    TT_RELEASE_SAFELY(_subRightLabel);
    TT_RELEASE_SAFELY(_rightImageView);
    TT_RELEASE_SAFELY(_subRightImageView);
    TT_RELEASE_SAFELY(_bgImageView);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_actionButtonOne);
    TT_RELEASE_SAFELY(_actionButtonTwo);
    [super dealloc];
}

- (UILabel *) topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _topLabel.backgroundColor = kClearColor;
        _topLabel.textColor = kDarkTextColor;
        _topLabel.highlightedTextColor = kBlackColor;
        _topLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _topLabel;
}

- (UILabel *) subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subLabel.backgroundColor = kClearColor;
        _subLabel.textColor = kTableViewColor;
        _subLabel.highlightedTextColor = kBlackColor;
        _subLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _subLabel;
}


- (UIImageView *) leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImageView.backgroundColor = kClearColor;
        _leftImageView.userInteractionEnabled = YES;
        _leftImageView.layer.cornerRadius = 0.0f;
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.borderWidth = 0.0f;
        _leftImageView.layer.borderColor = kWhiteColor.CGColor;
        _leftImageView.image = [UIImage imageNamed:@"btn_tab2"];
    }
    return _leftImageView;
}

- (UILabel *) rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.backgroundColor = kClearColor;
        _rightLabel.textColor = kTableViewColor;
        _rightLabel.highlightedTextColor = kBlackColor;
        _rightLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _rightLabel;
}

- (UILabel *) subRightLabel
{
    if (!_subRightLabel) {
        _subRightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subRightLabel.backgroundColor = kClearColor;
        _subRightLabel.textColor = kTableViewColor;
        _subRightLabel.highlightedTextColor = kBlackColor;
        _subRightLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _subRightLabel;
}


- (UIImageView *) rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightImageView.backgroundColor = kClearColor;
        _rightImageView.userInteractionEnabled = YES;
        _rightImageView.layer.cornerRadius = 0.0f;
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.layer.borderWidth = 0.0f;
        _rightImageView.layer.borderColor = kWhiteColor.CGColor;
        _rightImageView.image = [UIImage imageNamed:@"btn_tab2"];
    }
    return _rightImageView;
}

- (UIImageView *) subRightImageView
{
    if (!_subRightImageView) {
        _subRightImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _subRightImageView.backgroundColor = kClearColor;
        _subRightImageView.userInteractionEnabled = YES;
        _subRightImageView.layer.cornerRadius = 0.0f;
        _subRightImageView.layer.masksToBounds = YES;
        _subRightImageView.layer.borderWidth = 0.0f;
        _subRightImageView.layer.borderColor = kWhiteColor.CGColor;
        _subRightImageView.image = [UIImage imageNamed:@"btn_tab2"];
    }
    return _subRightImageView;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.backgroundColor = kClearColor;
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.image = [UIImage imageNamed:@"btn_tab2"];
    }
    return _bgImageView;
}

- (UILabel *) timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.backgroundColor = kLightGrayColor;
        _timeLabel.textColor = kTableViewColor;
        _timeLabel.textColor = kWhiteColor;
        _timeLabel.highlightedTextColor = kBlackColor;
        _timeLabel.layer.cornerRadius = 5.0f;
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = HTFONTSIZE(kFontSize14);
    }
    return _timeLabel;
}


-(UIButton *)actionButtonOne
{
    if (!_actionButtonOne) {
        _actionButtonOne = [[UIButton alloc]initWithFrame:CGRectZero];
        [_actionButtonOne setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_actionButtonOne setTitleColor:kBlackColor forState:UIControlStateSelected];
        _actionButtonOne.titleLabel.font = HTFONTSIZE(kSystemFontSize14);
        _actionButtonOne.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_actionButtonOne addTarget:self action:@selector(buttonOneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButtonOne;
}


-(UIButton *)actionButtonTwo
{
    if (!_actionButtonTwo) {
        _actionButtonTwo = [[UIButton alloc]initWithFrame:CGRectZero];
        [_actionButtonTwo setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_actionButtonTwo setTitleColor:kWhiteColor forState:UIControlStateSelected];
        _actionButtonTwo.titleLabel.font = HTFONTSIZE(kSystemFontSize14);
        _actionButtonTwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_actionButtonTwo addTarget:self action:@selector(buttonTwoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButtonTwo;
}


-(IBAction)buttonOneAction:(id)sender
{
    
}

-(IBAction)buttonTwoAction:(id)sender
{
    
}


- (id)setBgImageWithCount:(NSInteger ) number at:(NSIndexPath *)indexPath
{
//    if (IS_IOS_7_OR_GREATER) {
//        self.backgroundView = nil;
//        //        self.backgroundColor = kClearColor;
//        return self;
//    }
    if (1 == number) {
        self.bgImageView.image = [[UIImage imageNamed:@"list_alone_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        self.bgImageView.highlightedImage = [[UIImage imageNamed:@"list_alone_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    } else {
        if (0 == indexPath.row) {
            self.bgImageView.image = [[UIImage imageNamed:@"list_top_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
            self.bgImageView.highlightedImage = [[UIImage imageNamed:@"list_top_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        } else if ((number - 1) == indexPath.row ) {
            self.bgImageView.image = [[UIImage imageNamed:@"list_bottom_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
            self.bgImageView.highlightedImage = [[UIImage imageNamed:@"list_bottom_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        } else {
            self.bgImageView.image = [[UIImage imageNamed:@"list_middle_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
            self.bgImageView.highlightedImage = [[UIImage imageNamed:@"list_middle_selected"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        }
    }
    return self;
}


@end


