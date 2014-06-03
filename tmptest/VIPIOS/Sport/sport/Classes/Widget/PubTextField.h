//
//  PubTextField.h
//

#import <UIKit/UIKit.h>

typedef enum{
    PubTextFieldStyleOne = 0,
    PubTextFieldStyleTop,
    PubTextFieldStyleMiddle,
    PubTextFieldStyleBottom,
} PubTextFieldStyle;


#define kPubTextFieldHeight 40
#define kPubTextFieldHeight2 42


@interface PubTextField : UIView

@property (nonatomic, retain) UITextField *pubTextField;

- (BOOL)becomeFirstResponder;

- (BOOL)resignFirstResponder;

- (void) enableEdit:(BOOL) flag;

- (id)initWithFrame:(CGRect)frame
         indexTitle:(NSString *)indexTile
        placeHolder:(NSString *)placeHolder
  pubTextFieldStyle:(PubTextFieldStyle)pubFieldStyle;

@end
