//
//  TTHUDController.h
//  Tiaooo
//
//  Created by ClaudeLi on 2018/2/3.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TTHUD [TTHUDController HUD]

@interface TTHUDController : NSObject

+ (TTHUDController *)HUD;

/**
 显示菊花loading
 
 @param canTouch canTouch
 */
- (void)showProgress:(BOOL)canTouch;

/**
 隐藏loading
 */
- (void)hideProgress;

/**
 文字提示, 默认显示1.5s,可点击
 
 @param string 文字
 */
- (void)showText:(NSString *)string;

/**
 文字提示
 
 @param string   文字
 @param canTouch canTouch
 */
- (void)showText:(NSString *)string canTouch:(BOOL)canTouch;

/**
 文字提示
 
 @param string 文字
 @param delay 时长
 @param canTouch canTouch
 */
- (void)showText:(NSString *)string delay:(NSTimeInterval)delay canTouch:(BOOL)canTouch;

/**
 菊花样式文字提示, 默认不可点击,结束时需要调用 -hideProgress
 
 @param string 文字
 @param start 开始
 */
- (void)showProgressWithText:(NSString *)string start:(BOOL)start;

@end
