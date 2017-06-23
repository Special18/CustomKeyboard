//
//  MRKeyBoard.h
//  Wave
//
//  Created by MrXir on 2017/6/19.
//  Copyright © 2017年 LJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MRKeyBoardPopView.h"

@protocol MRKeyBoardDelegate <NSObject>

@optional

/**点击键盘上数组和字母按钮的代理方法**/
- (void)didClickCustomKeyboardButtonTitle:(NSString *)buttonTitle;

/**点击键盘上删除按钮的代理方法**/
- (void)didClickDeleteButton;

/**点击键盘上复制按钮的代理方法**/
- (void)didClickCopyButton;

/**点击键盘上粘贴按钮的代理方法**/
- (void)didClickViscosityButton;
@end


@class MRKeyBoard;
@class MRKeyBoard_AccessoryView;
@interface MRKeyBoardManager : NSObject

@property (nonatomic, strong) MRKeyBoard *keyBoard;

@property (nonatomic, strong) MRKeyBoard_AccessoryView *accessory;

@property (nonatomic, strong) UIButton *finish;

+ (MRKeyBoardManager *)manager;

@end


@interface MRKeyBoard : UIView

@property (nonatomic, weak) id<MRKeyBoardDelegate> delegate;

+ (MRKeyBoard *)keyBoard;

@end

//显示文字部分
@interface MRKeyBoard_AccessoryView : UIView

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *finish;

+ (MRKeyBoard_AccessoryView *)accessoryView;

@end


@interface MRKeyBoard_BaseButton : UIButton

@end

//数字和字母按钮
@interface MRKeyBoard_Button : MRKeyBoard_BaseButton

@property (nonatomic, strong) MRKeyBoardPopView *popView;

@property (nonatomic, assign) SystemSoundID soundId;

@end

//删除按钮
@interface MRKeyBoard_Delete : MRKeyBoard_BaseButton

@property (nonatomic, assign) SystemSoundID soundId;

@end

//复制
@interface MRKeyBoard_Copy : MRKeyBoard_BaseButton

@property (nonatomic, assign) SystemSoundID soundId;

@end

//粘贴
@interface MRKeyBoard_Viscosity : MRKeyBoard_BaseButton

@property (nonatomic, assign) SystemSoundID soundId;

@end
