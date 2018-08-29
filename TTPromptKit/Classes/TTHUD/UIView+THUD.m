//
//  UIView+THUD.m
//  Tiaooo
//
//  Created by ClaudeLi on 2018/2/3.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "UIView+THUD.h"
#import "UIViewController+THUD.h"
#import "TTHUDController.h"

@implementation UIView (THUD)

// 显示loading
- (void)showProgress:(BOOL)canTouch{
    if (self.viewController){
        [self.viewController showProgress:canTouch];
    }else{
        [TTHUD showProgress:canTouch];
    }
}

// 隐藏loading
- (void)hideProgress{
    if (self.viewController){
        [self.viewController hideProgress];
    }else{
        [TTHUD hideProgress];
    }
}

// 文字提示窗口 默认1.5 可点击
- (void)showText:(NSString *)string{
    if (self.viewController){
        [self.viewController showText:string];
    }else{
        [TTHUD showText:string];
    }
}

- (void)showText:(NSString *)string canTouch:(BOOL)canTouch{
    if (self.viewController){
        [self.viewController showText:string canTouch:canTouch];
    }else{
        [TTHUD showText:string canTouch:canTouch];
    }
}

- (void)showText:(NSString *)string delay:(NSTimeInterval)delay canTouch:(BOOL)canTouch{
    if (self.viewController){
        [self.viewController showText:string delay:delay canTouch:canTouch];
    }else{
        [TTHUD showText:string delay:delay canTouch:canTouch];
    }
}

- (void)showProgressWithText:(NSString *)string start:(BOOL)start{
    if (self.viewController){
        [self.viewController showProgressWithText:string start:start];
    }else{
        [TTHUD showProgressWithText:string start:start];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
