//
//  TTAlertController.m
//  Tiaooo
//
//  Created by ClaudeLi on 2017/7/6.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "TTAlertController.h"

@interface TTAlertController ()<UIAlertViewDelegate, UIActionSheetDelegate>{
    BOOL    _isSheet;
    NSString *_Nullable _title;
    NSString *_Nullable _message;
}
@property (nonatomic, copy) NSString * _Nullable cancelButtonTitle;
@property (nonatomic, copy) NSString * _Nullable destructiveButtonTitle;

@property (nonatomic, strong) NSMutableArray *otherButtonTitles;
@property (nonatomic, strong) UIView            * _Nullable upView;  //  唤起alert的视图
@property (nonatomic, strong) UIViewController  * _Nullable upVc;    //  唤起alert的控制器
@end

@implementation TTAlertController

- (NSMutableArray *)otherButtonTitles{
    if (!_otherButtonTitles) {
        _otherButtonTitles = [NSMutableArray array];
    }
    return _otherButtonTitles;
}

- (instancetype)initAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [super init];
    if (self) {
        _isSheet = NO;
        _title = title;
        _message = message;
        _cancelButtonTitle = cancelButtonTitle;
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles)
        {
            [self.otherButtonTitles addObject:otherButtonTitles];
            NSString *otherString;
            while ((otherString = va_arg(args, NSString *)))
            {
                [self.otherButtonTitles addObject:otherString];
            }
        }
        va_end(args);
    }
    return self;
}

- (instancetype)initSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [super init];
    if (self) {
        _isSheet = YES;
        _title = title;
        _message = message;
        _destructiveButtonTitle = destructiveButtonTitle;
        _cancelButtonTitle = cancelButtonTitle;
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles)
        {
            [self.otherButtonTitles addObject:otherButtonTitles];
            NSString *otherString;
            while ((otherString = va_arg(args, NSString *)))
            {
                [self.otherButtonTitles addObject:otherString];
            }
        }
        va_end(args);
    }
    return self;
}

- (void)showInView:(UIView *)view{
    _upView = view;
    [self show];
}

- (void)showInViewController:(UIViewController *)viewController{
    _upVc = viewController;
    if (_upVc) {
        _upView = _upVc.view;
    }
    [self show];
}

- (void)show{
    if (_upView) {
        if (@available(iOS 8.0, *)) {
            if (!_upVc) {
                _upVc = self.viewController;
            }
            if (_upVc && !_isSheet) {
                [self showAlertController];
            }else{
                [self showAlertView];
            }
        }else{
            [self showAlertView];
        }
    }else{
        [self showAlertView];
    }
}


- (void)showAlertView{
    if (_isSheet) {
        UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:_title
                                                           delegate:self
                                                  cancelButtonTitle:_cancelButtonTitle
                                             destructiveButtonTitle:_destructiveButtonTitle
                                                  otherButtonTitles:nil];
        alert.actionSheetStyle = UIActionSheetStyleDefault;
        for (NSString *title in _otherButtonTitles) {
            [alert addButtonWithTitle:title];
        }
        if ([[NSThread currentThread] isMainThread]) {
            [alert showInView:_upView];
        }else{
            __weak __typeof(&*self)weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showInView:weakSelf.upView];
            });
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title
                                                        message:_message
                                                       delegate:self
                                              cancelButtonTitle:_cancelButtonTitle
                                              otherButtonTitles:nil];
        for (NSString *title in _otherButtonTitles) {
            [alert addButtonWithTitle:title];
        }
        if ([[NSThread currentThread] isMainThread]) {
            [alert show];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
            });
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self alertCallBack:buttonIndex];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self alertCallBack:buttonIndex];
}

- (void)alertCallBack:(NSInteger)buttonIndex{
    if (self.didClickIndexBlock) {
        self.didClickIndexBlock(buttonIndex);
    }
}

#pragma mark -
#pragma mark -- UIAlertController --
- (void)showAlertController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:_isSheet?UIAlertControllerStyleActionSheet:UIAlertControllerStyleAlert];
    NSInteger i = 0;
    __weak __typeof(&*self)weakSelf = self;
    if (_destructiveButtonTitle) {
        __block NSInteger weak_index = i;
        UIAlertAction *action = [UIAlertAction actionWithTitle:_destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
            if (weakSelf.didClickIndexBlock) {
                weakSelf.didClickIndexBlock(weak_index);
            }
        }];
        [alert addAction:action];
        i++;
    }
    if (_cancelButtonTitle) {
        __block NSInteger weak_index = i;
        UIAlertAction *action = [UIAlertAction actionWithTitle:_cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            if (weakSelf.didClickIndexBlock) {
                weakSelf.didClickIndexBlock(weak_index);
            }
        }];
        [alert addAction:action];
        i++;
    }
    if (_otherButtonTitles) {
        for (NSString *title in _otherButtonTitles) {
            __block NSInteger weak_index = i;
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                if (weakSelf.didClickIndexBlock) {
                    weakSelf.didClickIndexBlock(weak_index);
                }
            }];
            [alert addAction:action];
            i++;
        }
    }
    if ([[NSThread currentThread] isMainThread]) {
        [self showController:alert];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showController:alert];
        });
    }
}

- (void)showController:(UIAlertController *)alert{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alert
                                                         popoverPresentationController];
        popPresenter.sourceView = _upVc.view; // 这就是挂靠的对象
        popPresenter.sourceRect = _upVc.view.bounds;
        [_upVc presentViewController:alert animated:YES completion:nil];
    }else{
        [_upVc presentViewController:alert animated:YES completion:nil];
    }
}

- (UIViewController *)viewController{
    for (UIView *view = _upView; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
