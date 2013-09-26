//
//  POSHomeViewController.m
//  POSOnline
//
//  Created by Quoc Nguyen on 9/25/13.
//  Copyright (c) 2013 Quoc Nguyen. All rights reserved.
//

#import "POSHomeViewController.h"
#import "POSRegisterViewController.h"

@interface POSHomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *regisButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@end

@implementation POSHomeViewController

#pragma mark - ViewCycle Life
- (void)viewDidLoad
{
  [super viewDidLoad];
  [self customizeButton];
}

#pragma mark - Utils

- (void)customizeButton
{
  NSArray *arryBtns = @[self.regisButton,self.signInButton];
  for (UIButton *btn in arryBtns) {
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f86060"]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#d2322d"]] forState:UIControlStateHighlighted];
  }
}

- (IBAction)onRegistButton:(UIButton *)sender {
  POSRegisterViewController *registVC = [[POSRegisterViewController alloc]init];
  [self presentViewController:registVC animated:YES completion:nil];
}


@end
