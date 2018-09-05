//
//  UIViewController+THUD.m
//  Tiaooo
//
//  Created by ClaudeLi on 2018/2/3.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "UIViewController+THUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/message.h>

@implementation UIViewController (THUD)

- (void)setProgressHUD:(UIColor *)progressHUD{
    objc_setAssociatedObject(self, @selector(progressHUD), progressHUD, OBJC_ASSOCIATION_RETAIN);
}

- (MBProgressHUD *)progressHUD{
    return objc_getAssociatedObject(self, @selector(progressHUD));
}

- (void)bringHUDToFront{
    if (!self.progressHUD) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.userInteractionEnabled = NO;
        HUD.removeFromSuperViewOnHide = YES;
        self.progressHUD = HUD;
    }
    if (!self.progressHUD.superview) {
        [self.view addSubview:self.progressHUD];
    }
    [self.view bringSubviewToFront:self.progressHUD];
}

- (void)showProgress:(BOOL)canTouch{
    [self bringHUDToFront];
    if (!canTouch) {
        self.progressHUD.userInteractionEnabled = YES;
    }else{
        self.progressHUD.userInteractionEnabled = NO;
    }
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.labelText = nil;
    [self.progressHUD show:YES];
}

- (void)hideProgress{
    if (self.progressHUD) {
        [self.progressHUD hide:YES];
        [self.progressHUD removeFromSuperview];
        self.progressHUD = nil;
    }
}

// 文字提示窗口 默认1.5 可点击
- (void)showText:(NSString *)string{
    [self showText:string canTouch:YES];
}

- (void)showText:(NSString *)string canTouch:(BOOL)canTouch{
    [self showText:string delay:1.0f canTouch:canTouch];
}

- (void)showText:(NSString *)string delay:(NSTimeInterval)delay canTouch:(BOOL)canTouch{
    [self bringHUDToFront];
    if (!canTouch) {
        self.progressHUD.userInteractionEnabled = YES;
    }else{
        self.progressHUD.userInteractionEnabled = NO;
    }
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.labelText = string;
    [self.progressHUD show:YES];
    [self.progressHUD hide:YES afterDelay:delay];
}

// loading 带文字
- (void)showProgressWithText:(NSString *)string start:(BOOL)start{
    if (start) {
        [self bringHUDToFront];
        self.progressHUD.mode = MBProgressHUDModeIndeterminate;
        self.progressHUD.userInteractionEnabled = NO;
        self.progressHUD.labelText = string;
        [self.progressHUD show:YES];
    }else{
        self.progressHUD.labelText = string;
    }
}


@end
