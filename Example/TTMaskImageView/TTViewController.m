//
//  TTViewController.m
//  TTMaskImageView
//
//  Created by claudeli@yeah.net on 10/11/2018.
//  Copyright (c) 2018 claudeli@yeah.net. All rights reserved.
//

#import "TTViewController.h"
#import <TTMaskImageView/TTMaskImageView.h>

@interface TTViewController (){
    TTMaskImageView *_maskView;
}

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak __typeof(&*self)weakSelf = self;

    _maskView = [[TTMaskImageView alloc] initWithCount:1];
    
    _maskView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    _maskView.imageView.backgroundColor = [UIColor blackColor];
    
    [_maskView showHUDWithFrame:CGRectMake(100, 100, 100, 100) image:[UIImage imageNamed:@""]];
    [_maskView setClickTagBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf hideView];
        }
    }];
    [self.view addSubview:_maskView];
}

- (void)hideView{
    if (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
