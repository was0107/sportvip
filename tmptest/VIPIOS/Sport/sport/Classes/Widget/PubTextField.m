//
//  PubTextField.m
//

#import "PubTextField.h"
#import "UITextField+DelegateBlocks.h"

#define kIndexLabelWidth         60.0f
#define kIndexLabelHeight        20.0f
#define kIndexLabelLeftPadding   12.0f
#define kIndexLabelRightPadding  24.0f
#define kIndexLabelTopPadding    3.0f
#define kIndexLabelBottomPadding 12.0f

#define kTextFieldWidth          225.0f
#define kTextFieldHeight         34.0f

@interface PubTextField ()

@property (nonatomic, retain) UILabel *indexLabel;
@property (nonatomic, retain) UIImageView *fieldBackground;
@property (nonatomic, assign) PubTextFieldStyle fieldStyle;

@end

@implementation PubTextField
@synthesize indexLabel = _indexLabel;
@synthesize fieldBackground = _fieldBackground;
@synthesize fieldStyle = _fieldStyle;

- (void)dealloc
{
    [_indexLabel release];
    [_fieldBackground release];
    [_pubTextField release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.borderStyle = UITextBorderStyleNone;
//        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        [self addSubview:[self indexLabel]];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame indexTitle:(NSString *)indexTile placeHolder:(NSString *)placeHolder pubTextFieldStyle:(PubTextFieldStyle)pubFieldStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:[self fieldBackground]];
        [self addSubview:[self indexLabel]];
        [self addSubview:[self pubTextField]];
        self.pubTextField.placeholder = [NSString stringWithFormat:@" %@",placeHolder];
        self.indexLabel.text = indexTile;
        self.fieldStyle = pubFieldStyle;
        
        [self.pubTextField useBlocksForDelegate];
        [self initialBlocks];
        
//        if (IS_IOS_7_OR_GREATER)
        {
            self.backgroundColor = kWhiteColor;
        }
    }
    
    return self;
}

- (UITextField *)pubTextField
{
    if (!_pubTextField) {
        if (IS_IOS_7_OR_GREATER) {
            _pubTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.bounds.origin.x + kIndexLabelLeftPadding + kIndexLabelWidth + kIndexLabelRightPadding, self.bounds.origin.y + kIndexLabelTopPadding, kTextFieldWidth, kTextFieldHeight)];
        } else {
            
            _pubTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.bounds.origin.x + kIndexLabelLeftPadding + kIndexLabelWidth + kIndexLabelRightPadding, self.bounds.origin.y + 10, kTextFieldWidth, 20)];
        }
        _pubTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _pubTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _pubTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pubTextField.textColor = kDarkGrayColor;
        _pubTextField.font = HTFONTSIZE(kSystemFontSize15);
    }
    
    return _pubTextField;
}

- (UILabel *)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + kIndexLabelLeftPadding, self.bounds.origin.y + 10, kIndexLabelWidth + 20, kIndexLabelHeight)];
        _indexLabel.backgroundColor = kClearColor;
        _indexLabel.font = HTFONTSIZE(kFontSize15);
        _indexLabel.textColor = [UIColor getColor:kTitleFontColor];
    }
    
    return _indexLabel;
}

- (UIImageView *)fieldBackground
{
    if (!_fieldBackground) {
        _fieldBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height)];
    }
    
    return _fieldBackground;
}

- (void)setFieldStyle:(PubTextFieldStyle)fieldStyle
{
//    return;
    switch (fieldStyle) {
        case PubTextFieldStyleOne:
        {
            if (!IS_IOS_7_OR_GREATER) {
                [_fieldBackground setImage:[UIImage imageNamed:@"list_alone_normal"]];
            } else {
                
                UIImage *bgImage = [[UIImage imageNamed:@"register_line_icon"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
                UIImageView *bgImageLine = [[UIImageView alloc] initWithFrame:CGRectMake(-20.0f, 0.0f, 320.0f, 1.0f)];
                bgImageLine.image = bgImage;
                [_fieldBackground addSubview:bgImageLine];
                [bgImageLine release];
                
                
                UIImageView *bgImageLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(-20.0f, self.bounds.size.height-1, 340.0f, 1.0f)];
                bgImageLine1.image = bgImage;
                [_fieldBackground addSubview:bgImageLine1];
                [bgImageLine1 release];
            }
        }
            break;
        case PubTextFieldStyleTop:
        {
            if (!IS_IOS_7_OR_GREATER) {
                [_fieldBackground setImage:[UIImage imageNamed:@"list_top_normal"]];
            }
            else {
                UIImage *bgImage = [[UIImage imageNamed:@"register_line_icon"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
                UIImageView *bgImageLine = [[UIImageView alloc] initWithFrame:CGRectMake(-20.0f, 0.0f, 340.0f, 1.0f)];
                bgImageLine.image = bgImage;
                [_fieldBackground addSubview:bgImageLine];
                [bgImageLine release];
            }
        }
            break;
        case PubTextFieldStyleMiddle:
        {
            if (!IS_IOS_7_OR_GREATER) {
                [_fieldBackground setImage:[UIImage imageNamed:@"list_middle_normal"]];
            }
            else {
                UIImage *bgImage = [[UIImage imageNamed:@"register_line_icon"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
                UIImageView *bgImageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
                bgImageLine.image = bgImage;
                [_fieldBackground addSubview:bgImageLine];
                [bgImageLine release];
            }
        }
            break;
        case PubTextFieldStyleBottom:
        {
            if (!IS_IOS_7_OR_GREATER) {
                [_fieldBackground setImage:[UIImage imageNamed:@"list_bottom_normal"]];

            } else {
                
                UIImage *bgImage = [[UIImage imageNamed:@"register_line_icon"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
                UIImageView *bgImageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
                bgImageLine.image = bgImage;
                [_fieldBackground addSubview:bgImageLine];
                [bgImageLine release];
                
                
                UIImageView *bgImageLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(-20.0f, self.bounds.size.height-1, 340.0f, 1.0f)];
                bgImageLine1.image = bgImage;
                [_fieldBackground addSubview:bgImageLine1];
                [bgImageLine1 release];
            }
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)becomeFirstResponder
{
    return [self.pubTextField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.pubTextField resignFirstResponder];
}


- (void) enableEdit:(BOOL) flag
{
    [self.pubTextField setTextAlignment:(flag ?  NSTextAlignmentLeft : NSTextAlignmentRight)];
    [self.pubTextField setEnabled:flag];
}

- (void)initialBlocks
{
    [self.pubTextField onShouldBeginEditing:^BOOL(UITextField *textField) {
        return YES;
    }];
    
    [self.pubTextField onDidBeginEditing:^(UITextField *textField){
        
    }];
    
    [self.pubTextField onShouldEndEditing:^(UITextField *textField){
        return YES;
    }];
    
    [self.pubTextField onDidEndEditing:^(UITextField *textField) {
        
    }];
    
    [self.pubTextField onShouldChangeCharactersInRange:^BOOL(UITextField *textField, NSRange range, NSString *string) {
        return NO;
    }];
    
    [self.pubTextField onShouldClear:^BOOL(UITextField *textField) {
        return YES;
    }];
    
    [self.pubTextField onShouldReturn:^BOOL(UITextField *textField) {
        return YES;
    }];
}

@end
