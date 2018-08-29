//
//  TTGuideHUD.h
//  Tiaooo
//
//  Created by ClaudeLi on 2018/8/11.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTGuideHUD : UIView

/**
 提示个数
 */
@property (nonatomic, assign) NSInteger count;  // default 1

/**
 提示图片视图
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 点击回调, 下标index
 */
@property (nonatomic, copy) void(^clickTagBlock)(NSInteger index);


/**
 个数初始化
 */
- (instancetype)initWithCount:(NSInteger)count;

/**
 显示

 @param frame 图片frame
 @param image 提示图片
 */
- (void)showHUDWithFrame:(CGRect)frame
                   image:(UIImage *)image;

@end
