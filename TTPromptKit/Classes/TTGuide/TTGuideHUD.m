//
//  TTGuideHUD.m
//  Tiaooo
//
//  Created by ClaudeLi on 2018/8/11.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "TTGuideHUD.h"

@implementation TTGuideHUD

- (instancetype)init{
    self = [super init];
    if (self) {
        self.count = 1;
        self.frame = [UIScreen mainScreen].bounds;
        [self _setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = 1;
        [self _setUp];
    }
    return self;
}

- (instancetype)initWithCount:(NSInteger)count{
    self = [super init];
    if (self) {
        self.count = count;
        self.frame = [UIScreen mainScreen].bounds;
        [self _setUp];
    }
    return self;
}

- (void)_setUp{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.imageView];
    self.userInteractionEnabled = YES;
    [self performSelector:@selector(addTap) withObject:nil afterDelay:0.5];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (void)addTap{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction{
    _count--;
    if (_count == 0) {
        __weak __typeof(&*self)weakSelf = self;
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (self.clickTagBlock) {
                self.clickTagBlock(weakSelf.count);
            }
        }];
    }else{
        if (self.clickTagBlock) {
            self.clickTagBlock(_count);
        }
    }
}

- (void)setCount:(NSInteger)count{
    _count = count;
}

- (void)showHUDWithFrame:(CGRect)frame
                   image:(UIImage *)image{
    self.imageView.frame = frame;
    self.imageView.image = image;
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end
