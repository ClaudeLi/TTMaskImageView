//
//  TTViewController.m
//  TTPromptKit
//
//  Created by claudeli@yeah.net on 08/28/2018.
//  Copyright (c) 2018 claudeli@yeah.net. All rights reserved.
//

#import "TTViewController.h"
#import <TTPromptKit/TTPromptKit.h>

@interface TTViewController (){
    TTAlertController *alert;
}

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showProgress:YES];
    
    [self performSelector:@selector(next) withObject:nil afterDelay:1.5];
}

- (void)next{
    [self showText:@"哈哈" delay:2 canTouch:YES];
}

- (IBAction)alert1:(id)sender {
    [TTAlert alertInView:self.view
                   title:@"你好"
                 message:@"message"
          completeHelper:^(NSInteger clickIndex) {
              NSLog(@"%ld", clickIndex);
          }
             cancelTitle:@"cancel"
             otherTitles:@"other1",@"other2",@"other3", nil];
}

- (IBAction)alert2:(id)sender {
    alert = [[TTAlertController alloc] initAlertWithTitle:@"你好"
                                            message:@"message"
                                  cancelButtonTitle:@"cancel"
                                  otherButtonTitles:@"other1",@"other2",@"other3", nil];
    [alert setDidClickIndexBlock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    [alert showInView:self.view];
}

- (IBAction)sheet1:(id)sender {
    alert = [[TTAlertController alloc]
                          initSheetWithTitle:@"Hello sheet"
                          message:@"message"
                          cancelButtonTitle:@"cancel"
                          destructiveButtonTitle:@"destructiveButton"
                          otherButtonTitles:@"other1",@"other2",@"other3", nil];
    [alert setDidClickIndexBlock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    [alert showInView:self.view];
}

- (IBAction)sheet2:(id)sender {
    alert = [[TTAlertController alloc]
                          initSheetWithTitle:@"Hello sheet"
                          message:@"message"
                          cancelButtonTitle:@"cancel"
                          destructiveButtonTitle:@"destructiveButton"
                          otherButtonTitles:@"other1",@"other2",@"other3", nil];
    [alert setDidClickIndexBlock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    [alert showInView:self.view];
}

- (IBAction)guide:(id)sender {
    TTGuideHUD *gd = [[TTGuideHUD alloc] initWithCount:1];
    gd.imageView.backgroundColor = [UIColor redColor];
    [gd showHUDWithFrame:CGRectMake(300, 200, 100, 80)
                   image:[UIImage imageNamed:@"test"]];
    __block TTGuideHUD *hud = gd;
    [gd setClickTagBlock:^(NSInteger index) {
        if (index == 0) {
            [hud removeFromSuperview];
            hud = nil;
        }
    }];
    [self.view addSubview:gd];
}


- (IBAction)hud:(id)sender {
    [self showText:@"Hello HUD"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
