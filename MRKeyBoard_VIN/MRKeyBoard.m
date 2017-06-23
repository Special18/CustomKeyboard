//
//  MRKeyBoard.m
//  Wave
//
//  Created by MrXir on 2017/6/19.
//  Copyright © 2017年 LJS. All rights reserved.
//

#import "MRKeyBoard.h"

@implementation MRKeyBoardManager

+ (MRKeyBoardManager *)manager {
    
    static MRKeyBoardManager *k_m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        k_m = [[MRKeyBoardManager alloc] init];
    });
    return k_m;
}

@end


@implementation MRKeyBoard

+ (MRKeyBoard *)keyBoard {
    
    MRKeyBoard *keyboard = [[NSBundle mainBundle] loadNibNamed:@"MRKeyBoard" owner:self options:nil].firstObject;
    [MRKeyBoardManager manager].keyBoard = keyboard;
    return keyboard;
}

@end


@implementation MRKeyBoard_AccessoryView

+ (MRKeyBoard_AccessoryView *)accessoryView {
    
    MRKeyBoard_AccessoryView *accessory = [[NSBundle mainBundle] loadNibNamed:@"MRKeyBoard" owner:self options:nil].lastObject;
    [MRKeyBoardManager manager].accessory = accessory;
    [MRKeyBoardManager manager].finish = accessory.finish;
    return accessory;
}

@end


@implementation MRKeyBoard_BaseButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

//加上一条下划线，产生3D效果
- (void)drawRect:(CGRect)rect {
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, height - 5 - 1)];
    [path addArcWithCenter:CGPointMake(5, height - 5 - 1) radius:5 startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    [path addLineToPoint:CGPointMake(width - 5, height - 1)];
    [path addArcWithCenter:CGPointMake(width - 5, height - 5 - 1) radius:5 startAngle:M_PI_2 endAngle:0 clockwise:NO];
    
    [path addLineToPoint:CGPointMake(width, height - 5)];
    [path addArcWithCenter:CGPointMake(width - 5, height - 5) radius:5 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(5, height)];
    [path addArcWithCenter:CGPointMake(5, height - 5) radius:5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path closePath];
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35].CGColor);
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
}

@end

@implementation MRKeyBoard_Button

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AudioServicesPlaySystemSound(self.soundId);
    
    [self setTitleColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1] forState:0];
    
    NSString *title = self.titleLabel.text;

    //坐标转换
    CGRect newRect = [self convertRect:self.bounds toView:nil];
    
    NSArray <__kindof UIWindow *>*windows = [[UIApplication sharedApplication] windows];
    
    __block UIWindow *keyboardWindow = nil;
    
    [windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.windowLevel > keyboardWindow.windowLevel) {
            keyboardWindow = obj;
        }
        
    }];
    
    SEL selector = @selector(didClickCustomKeyboardButtonTitle:);
    
    if ([[MRKeyBoardManager manager].keyBoard.delegate respondsToSelector:selector]) {
        [[MRKeyBoardManager manager].keyBoard.delegate didClickCustomKeyboardButtonTitle:title];
    }
    
    _popView = [MRKeyBoardPopView popView];
    [_popView showInView:keyboardWindow withFromButtonFrame:newRect withTile:title];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:0];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.027 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_popView removeFromSuperview];
    });
}

- (MRKeyBoardPopView *)popView {
    if (!_popView) {
        _popView = [MRKeyBoardPopView popView];
    }
    return _popView;
}

- (SystemSoundID)soundId {
    
    if (_soundId == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Keyboard_Click.aiff" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &_soundId);
    }
    return _soundId;
}

@end

@implementation MRKeyBoard_Delete


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AudioServicesPlaySystemSound(self.soundId);

    [self setTitleColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1] forState:0];
    
    SEL selector = @selector(didClickDeleteButton);
    
    if ([[MRKeyBoardManager manager].keyBoard.delegate respondsToSelector:selector]) {
        [[MRKeyBoardManager manager].keyBoard.delegate didClickDeleteButton];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self setTitleColor:[UIColor whiteColor] forState:0];
}
- (SystemSoundID)soundId {
    
    if (_soundId == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Keyboard_Click.aiff" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &_soundId);
    }
    return _soundId;
}
@end

@implementation MRKeyBoard_Copy

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AudioServicesPlaySystemSound(self.soundId);
    
    [self setTitleColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1] forState:0];
    
    SEL selector = @selector(didClickCopyButton);
    
    if ([[MRKeyBoardManager manager].keyBoard.delegate respondsToSelector:selector]) {
        [[MRKeyBoardManager manager].keyBoard.delegate didClickCopyButton];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setTitleColor:[UIColor whiteColor] forState:0];
}

- (SystemSoundID)soundId {
    
    if (_soundId == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Keyboard_Click.aiff" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &_soundId);
    }
    return _soundId;
}

@end

@implementation MRKeyBoard_Viscosity

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AudioServicesPlaySystemSound(self.soundId);
    
    [self setTitleColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1] forState:0];
    
    SEL selector = @selector(didClickViscosityButton);
    
    if ([[MRKeyBoardManager manager].keyBoard.delegate respondsToSelector:selector]) {
        [[MRKeyBoardManager manager].keyBoard.delegate didClickViscosityButton];
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setTitleColor:[UIColor whiteColor] forState:0];
}

- (SystemSoundID)soundId {
    
    if (_soundId == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Keyboard_Click.aiff" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &_soundId);
    }
    return _soundId;
}

@end
