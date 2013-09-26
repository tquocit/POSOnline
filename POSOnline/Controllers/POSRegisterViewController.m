//
//  POSRegisterViewController.m
//  POSOnline
//
//  Created by Quoc Nguyen on 9/26/13.
//  Copyright (c) 2013 Quoc Nguyen. All rights reserved.
//

#import "POSRegisterViewController.h"

@interface POSRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *shopCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation POSRegisterViewController

#pragma mark - ViewCycle Life

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.scrollView setContentSize:CGSizeMake(self.view.width, 600)];
  [self customizeButtons];
}

#pragma mark - Actions
- (IBAction)onRegistBtn:(UIButton*)sender {
  [self checkTextField];
}

- (IBAction)onClearBtn:(UIButton *)sender {
  NSArray *arrayTextFields = @[self.shopCodeTextField,self.emailTextField,self.shopNameTextField,self.userNameTextField,self.phoneTextField,self.passwordTextField,self.rePasswordTextField];
  for (UITextField *textField in arrayTextFields) {
    textField.text = @"";
  }
}

#pragma mark - Utils

- (void)customizeButtons
{
  [self.registButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:88.0/255 green:147.0/255 blue:206.0/255 alpha:1]] forState:UIControlStateNormal];
  [self.clearButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:136.0/255 green:136.0/255 blue:136.0/255 alpha:1]] forState:UIControlStateNormal];
}

- (void)checkTextField
{
  if ([self.shopCodeTextField.text isEqualToString:@""])
    [self showAlertView:@"Mã cơ sở kinh doanh trống"];
  else if ([self.emailTextField.text isEqualToString:@""])
    [self showAlertView:@"Email trống"];
  else if ([self.shopNameTextField.text isEqualToString:@""])
    [self showAlertView:@"Tên cơ sở kinh doanh trống"];
  else if ([self.userNameTextField.text isEqualToString:@""])
    [self showAlertView:@"Tên người liên lạc trống"];
  else if ([self.phoneTextField.text isEqualToString:@""])
    [self showAlertView:@"Số điện thoại trống"];
  else if ([self.passwordTextField.text isEqualToString:@""])
    [self showAlertView:@"Mật khấu trống"];
  else if ([self.rePasswordTextField.text isEqualToString:@""])
    [self showAlertView:@"Nhập lại mật khẩu trống"];
}

- (void)showAlertView:(NSString *)alertString
{
  UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:alertString delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  [self.view addSubview:alertView];
  [alertView show];
}
@end
