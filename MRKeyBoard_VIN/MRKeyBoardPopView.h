//
//  MRKeyBoardPopView.h
//  Wave
//
//  Created by MrXir on 2017/6/20.
//  Copyright © 2017年 LJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRKeyBoardPopView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (MRKeyBoardPopView *)popView;

- (void)showInView:(UIView *)view withFromButtonFrame:(CGRect)frame withTile:(NSString *)title;

@end
