//
//  ViewController.m
//  MRKeyBoard_VIN
//
//  Created by MrXir on 2017/6/21.
//  Copyright © 2017年 LJS. All rights reserved.
//

#import "ViewController.h"
#import "MRKeyBoard.h"

@interface ViewController ()<MRKeyBoardDelegate>
{
    NSInteger i;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MRKeyBoard *keyBoard = [MRKeyBoard keyBoard];
    keyBoard.delegate = self;
    MRKeyBoard_AccessoryView *accessory = [MRKeyBoard_AccessoryView accessoryView];
    self.textField.inputView = keyBoard;
    self.textField.inputAccessoryView = accessory;
    [self.textField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    
    [[MRKeyBoardManager manager].finish addTarget:self action:@selector(didClickFinish:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textFieldDidEditing:(UITextField *)textField{
    
    if (textField.text.length > i) {
        
        //输入
        if (textField.text.length == 5 || textField.text.length == 10 || textField.text.length == 15) {
            NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
            [str insertString:@" " atIndex:textField.text.length - 1];
            self.textField.text = str;
        }else if (textField.text.length >= 20) {
            self.textField.text = [textField.text substringToIndex:20];
        }
        
        i = textField.text.length;
        
    }else if (textField.text.length < i) {
        
        //删除
        if (textField.text.length == 5 || textField.text.length == 10 || textField.text.length == 15) {
            self.textField.text = [NSString stringWithFormat:@"%@", textField.text];
            self.textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
        
        i = textField.text.length;
    }
}


#pragma mark - MRKeyBoardDelegate
- (void)didClickFinish:(UIButton *)finish {
    [self.textField resignFirstResponder];
}

- (void)didClickCustomKeyboardButtonTitle:(NSString *)buttonTitle {
    [self.textField insertText:buttonTitle];
}

- (void)didClickDeleteButton {
    [self.textField deleteBackward];
}

- (void)didClickCopyButton {
    
    if (self.textField.text.length) {
        [[UIPasteboard generalPasteboard] setString:self.textField.text];
    }
}

- (void)didClickViscosityButton {
    
    NSString *pasteString = [[UIPasteboard generalPasteboard] string];
    if (pasteString.length) {
        [self.textField insertText:pasteString];
    }
}




@end
