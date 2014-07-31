//
//  UITextField+DelegateBlocks.h
//

#import <UIKit/UIKit.h>


typedef BOOL (^UITextFieldShouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *string);
typedef void (^UITextFieldDidBeginEditingBlock)(UITextField *textField);
typedef void (^UITextFieldDidEndEditingBlock)(UITextField *textField);
typedef BOOL (^UITextFieldShouldBeginEditingBlock)(UITextField *textField);
typedef BOOL (^UITextFieldShouldClearBlock)(UITextField *textField);
typedef BOOL (^UITextFieldShouldEndEditingBlock)(UITextField *textField);
typedef BOOL (^UITextFieldShouldReturnBlock)(UITextField *textField);

@interface UITextField (DelegateBlocks)

-(id)useBlocksForDelegate;
-(void)onShouldChangeCharactersInRange:(UITextFieldShouldChangeCharactersInRangeBlock)block;
-(void)onDidBeginEditing:(UITextFieldDidBeginEditingBlock)block;
-(void)onDidEndEditing:(UITextFieldDidEndEditingBlock)block;
-(void)onShouldBeginEditing:(UITextFieldShouldBeginEditingBlock)block;
-(void)onShouldClear:(UITextFieldShouldClearBlock)block;
-(void)onShouldEndEditing:(UITextFieldShouldEndEditingBlock)block;
-(void)onShouldReturn:(UITextFieldShouldReturnBlock)block;

@end


@interface UITextFieldDelegateBlocks : NSObject <UITextFieldDelegate> {
    UITextFieldShouldChangeCharactersInRangeBlock _shouldChangeCharactersInRangeBlock;
    UITextFieldDidBeginEditingBlock _didBeginEditingBlock;
    UITextFieldDidEndEditingBlock _didEndEditingBlock;
    UITextFieldShouldBeginEditingBlock _shouldBeginEditingBlock;
    UITextFieldShouldClearBlock _shouldClearBlock;
    UITextFieldShouldEndEditingBlock _shouldEndEditingBlock;
    UITextFieldShouldReturnBlock _shouldReturnBlock;
}

@property(nonatomic, copy) UITextFieldShouldChangeCharactersInRangeBlock shouldChangeCharactersInRangeBlock;
@property(nonatomic, copy) UITextFieldDidBeginEditingBlock didBeginEditingBlock;
@property(nonatomic, copy) UITextFieldDidEndEditingBlock didEndEditingBlock;
@property(nonatomic, copy) UITextFieldShouldBeginEditingBlock shouldBeginEditingBlock;
@property(nonatomic, copy) UITextFieldShouldClearBlock shouldClearBlock;
@property(nonatomic, copy) UITextFieldShouldEndEditingBlock shouldEndEditingBlock;
@property(nonatomic, copy) UITextFieldShouldReturnBlock shouldReturnBlock;

@end