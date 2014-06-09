//
//  BaseTableViewCell.h
//  Discount
//
//  Created by allen.wang on 5/29/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+(ASI).h"
#import "UIColor+extend.h"
#import "UIImage+extend.h"
#import "UIImageLabelEx.h"
#import "UIView+extend.h"

@interface BaseTableViewCornerCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (id)setCellsCount:(NSInteger ) number at:(NSIndexPath *)indexPath;

- (id)setCellsGroupCount:(NSInteger ) number at:(NSIndexPath *)indexPath;

@end

@interface BaseTableViewCell : BaseTableViewCornerCell
@property (nonatomic, retain) UILabel *topLabel;
@property (nonatomic, retain) UILabel *subLabel;
@property (nonatomic, retain) UIImageView *leftImageView;
@property (nonatomic, retain) UITextField *textField;

- (void) configWithType:(int) type;

@end



@interface BaseSingleTableViewCell : BaseTableViewCornerCell

@property (nonatomic, retain) UILabel *topLabel;

@end

@interface BaseNewTableViewCell : BaseTableViewCornerCell
@property (nonatomic, retain) UILabel *topLabel;
@property (nonatomic, retain) UILabel *subLabel;
@property (nonatomic, retain) UIImageView *leftImageView;

@property (nonatomic, retain) UILabel     * rightLabel;
@property (nonatomic, retain) UILabel     * subRightLabel;
@property (nonatomic, retain) UIImageView * rightImageView;
@property (nonatomic, retain) UIImageView * subRightImageView;

@property (nonatomic, retain) UIButton * actionButtonOne;
@property (nonatomic, retain) UIButton * actionButtonTwo;

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UILabel     *timeLabel;


- (id)setBgImageWithCount:(NSInteger ) number at:(NSIndexPath *)indexPath;
@end


@interface BaseSportTableViewCell : BaseNewTableViewCell

@property (nonatomic, retain) UIImageLabelEx *topLabelEx, *topRigithEx;
@property (nonatomic, retain) UIImageLabelEx *middleLabelEx, *subRightEx;
@end
