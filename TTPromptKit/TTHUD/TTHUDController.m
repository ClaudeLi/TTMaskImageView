//
//  TTHUDController.m
//  Tiaooo
//
//  Created by ClaudeLi on 2018/2/3.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "TTHUDController.h"
#import <MBProgressHUD/MBProgressHUD.h>

static TTHUDController *manager;
@interface TTHUDController ()

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation TTHUDController

+ (TTHUDController *)HUD{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TTHUDController alloc] init];
    });
    return manager;
}

- (MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        _progressHUD.userInteractionEnabled = NO;
        _progressHUD.removeFromSuperViewOnHide = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_progressHUD];
    }
    return _progressHUD;
}

- (void)showProgress:(BOOL)canTouch{
    [self hideProgress];
    if (!canTouch) {
        self.progressHUD.userInteractionEnabled = YES;
    }else{
        self.progressHUD.userInteractionEnabled = NO;
    }
    [self.progressHUD show:YES];
}

- (void)hideProgress{
    if (_progressHUD) {
        [_progressHUD hide:YES];
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
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
    [self hideProgress];
    if (!canTouch) {
        self.progressHUD.userInteractionEnabled = YES;
    }else{
        self.progressHUD.userInteractionEnabled = NO;
    }
    self.progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = string;
    [_progressHUD show:YES];
    [_progressHUD hide:YES afterDelay:delay];
}

// loading 带文字
- (void)showProgressWithText:(NSString *)string start:(BOOL)start{
    if (start) {
        [self hideProgress];
        self.progressHUD.mode = MBProgressHUDModeIndeterminate;
        _progressHUD.userInteractionEnabled = NO;
        _progressHUD.labelText = string;
        [_progressHUD show:YES];
    }else{
        _progressHUD.labelText = string;
    }
}

@end
