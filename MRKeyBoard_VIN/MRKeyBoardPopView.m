//
//  MRKeyBoardPopView.m
//  Wave
//
//  Created by MrXir on 2017/6/20.
//  Copyright © 2017年 LJS. All rights reserved.
//

#import "MRKeyBoardPopView.h"

@implementation MRKeyBoardPopView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
}

+ (MRKeyBoardPopView *)popView {
    
    MRKeyBoardPopView *popView = [[NSBundle mainBundle] loadNibNamed:@"MRKeyBoardPopView" owner:self options:nil].lastObject;
    return popView;
}

- (void)showInView:(UIView *)view withFromButtonFrame:(CGRect)frame withTile:(NSString *)title {
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    x = frame.origin.x + (frame.size.width / 2) - 25;
    y = frame.origin.y - 66;
    
    self.titleLabel.text = title;
    self.frame = CGRectMake(x, y, 50, 60);
    [view addSubview:self];
    
}

@end
