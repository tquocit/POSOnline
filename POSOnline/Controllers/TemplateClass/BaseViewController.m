//
//  BaseViewController.m
//  MyBaseProject
//
//  Created by Torin on 1/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseWebViewController.h"

@class ADFormViewController;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (UIViewController*)initWithNib
{
    NSString *className = NSStringFromClass([self class]);
    self = [self initWithNibName:className bundle:nil];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self == nil)
        return self;
    
    self.shouldAvoidKeyboard = YES;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self trackCritercismBreadCrumb:__LINE__];
    
    NSString *className = NSStringFromClass([self class]);
    className = [className stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    [self trackAnalytics:className];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    DLog(@"Warning: Do not put any code in viewDidUnload. Deprecated since iOS 6.0");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self trackCritercismBreadCrumb:__LINE__];
    
    if (self.shouldAvoidKeyboard) {
        [self registerForKeyboardNotifications];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self trackCritercismBreadCrumb:__LINE__];
    
    for (NSString *notification in [self listNotificationInterests])
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:notification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self trackCritercismBreadCrumb:__LINE__];
    [self unregisterForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self trackCritercismBreadCrumb:__LINE__];
    
    if (self.parentViewController != nil) {
        [super viewDidDisappear:animated];
        return;
    }
    
    if (self.previousVCIsHome == NO) {
        [super viewDidDisappear:animated];
        return;
    }
    
    [super viewDidDisappear:animated];
}


#pragma mark - Rotations

//iOS 5.0 Rotations
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//}
//
////iOS 6.0 Rotations
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//- (NSUInteger) supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//}



#pragma mark - UI Helpers

- (UIViewController*)getViewControllerWithClassName:(NSString*)theClassName
{
    if ([theClassName length] <= 0)
        return nil;
    
    //Dynamically load the class
    Class theClass = NSClassFromString(theClassName);
    if (theClass == nil)
        return nil;
    
    NSObject* myViewController = [[theClass alloc] init];
    if (myViewController == nil)
        return nil;
    if ([myViewController isMemberOfClass:[UIViewController class]])
        return nil;
    
    return (UIViewController*)myViewController;
}

/*
 * Use a standard 'Back' button in navbar instead of title of previous view controller
 */
- (void)useStandardNavbarBackButton
{
    if (self.navigationController == nil)
        return;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"Back")
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:nil
                                                                     action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
}

- (void)setCustomNavbarLeftButtonTitle:(NSString*)title selector:(SEL)selector
{
    if (self.navigationController == nil)
        return;
    if ([title length] <= 0)
        return;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(title, title)
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:selector];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void)setCustomNavbarRightButtonTitle:(NSString*)title selector:(SEL)selector
{
    if (self.navigationController == nil)
        return;
    if ([title length] <= 0)
        return;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(title, title)
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:selector];
    self.navigationItem.rightBarButtonItem = barButton;
}

/*
 * Auto adjust content size for UIScrollView according to its subviews
 */
- (void)autoAdjustScrollViewContentSize
{
    UIScrollView *scrollView = nil;
    if ([self respondsToSelector:@selector(scrollView)])
        scrollView = [self valueForKey:@"scrollView"];
    if (scrollView == nil)
        return;
    
    CGFloat maxY = 0;
    for (UIView *subview in scrollView.subviews)
        if (maxY < CGRectGetMaxY(subview.frame))
            maxY = CGRectGetMaxY(subview.frame);
    maxY += LABEL_SPACING;
    
    //This to make it always scroll
    if (maxY <= scrollView.height)
        maxY = scrollView.height + 1;
    
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds), maxY);
}




#pragma mark - Helpers

- (void)showWebviewWithURL:(NSString *)urlString
{
    BaseWebViewController *vc = [[BaseWebViewController alloc] initWithNib];
    vc.url = urlString;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)trackCritercismBreadCrumb:(NSUInteger)lineNumber
{
    /* Too inefficient if user rarely enter their profile information
     NSArray * profiles = [[ADStorageManager sharedInstance] getAllClassModelObject:[ADCustomer class]];
     if ([profiles count] > 0)
     {
     ADCustomer * customer = [profiles objectAtIndex:0];
     if ([customer.name length] > 0)       [Crittercism setUsername:customer.name];
     if ([customer.email length] > 0)      [Crittercism setEmail:customer.email];
     if ([customer.gender length] > 0)     [Crittercism setGender:customer.gender];
     if ([customer.ID integerValue] > 0)   [Crittercism setValue:[customer.ID stringValue] forKey:@"id"];
     }
     */
    
    NSString *breadcrumb = [NSString stringWithFormat:@"%@:%d", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], lineNumber];
    [Crittercism leaveBreadcrumb:breadcrumb];
}

- (void)trackAnalytics:(NSString*)eventName
{
    //[Flurry logEvent:className];
}


#pragma mark - Actions

- (IBAction)onBtnBack:(id)sender
{
    if (self.navigationController == nil || self.navigationController.viewControllers[0] == self) {
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
    
    //Find the scrollView
    UIScrollView *scrollView = nil;
    if ([self respondsToSelector:@selector(scrollView)])
        scrollView = [self valueForKey:@"scrollView"];
    if ([self respondsToSelector:@selector(tableView)])
        scrollView = [self valueForKey:@"tableView"];
    if (scrollView == nil)
        return YES;
    
    //Scroll limits
    CGFloat visibleHeight = CGRectGetHeight(self.view.bounds) - 216;    //minus keyboard size
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat scrollToPointY = self.activeTextField.frame.origin.y - visibleHeight/2 - self.activeTextField.frame.size.height/2;
    if (scrollToPointY <= 0)
        scrollToPointY = 0;
    if (scrollToPointY + visibleHeight > contentHeight)
        scrollToPointY = contentHeight - visibleHeight;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [scrollView setContentOffset:CGPointMake(0, scrollToPointY) animated:YES];
    });
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.activeTextField = nil;
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - Keyboard events

- (void)onKeyboardWillShowNotification:(NSNotification *)sender
{
    CGSize kbSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [[[sender userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    UIScrollView *scrollView = nil;
    if ([self respondsToSelector:@selector(scrollView)])
        scrollView = [self valueForKey:@"scrollView"];
    if ([self respondsToSelector:@selector(tableView)])
        scrollView = [self valueForKey:@"tableView"];
    if ([self respondsToSelector:@selector(textView)])
        scrollView = [self valueForKey:@"textView"];
    
    //Adjust tableView or scrollView inset
    if (scrollView != nil)
    {
        [UIView animateWithDuration:duration delay:0 options:animationCurve animations:^{
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
            [scrollView setContentInset:edgeInsets];
            [scrollView setScrollIndicatorInsets:edgeInsets];
        } completion:nil];
        return;
    }
    
    //Shift the entire view
    CGRect selfViewFrame = self.view.bounds;
    selfViewFrame.origin.y = -kbSize.height;
    [UIView animateWithDuration:duration delay:0 options:animationCurve animations:^{
        self.view.frame = selfViewFrame;
    } completion:nil];
}

- (void)onKeyboardWillHideNotification:(NSNotification *)sender
{
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [[[sender userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    UIScrollView *scrollView = nil;
    if ([self respondsToSelector:@selector(scrollView)])
        scrollView = [self valueForKey:@"scrollView"];
    if ([self respondsToSelector:@selector(tableView)])
        scrollView = [self valueForKey:@"tableView"];
    if ([self respondsToSelector:@selector(textView)])
        scrollView = [self valueForKey:@"textView"];
    
    //Adjust tableView or scrollView inset
    if (scrollView != nil)
    {
        [UIView animateWithDuration:duration delay:0 options:animationCurve animations:^{
            
            UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
            [scrollView setContentInset:edgeInsets];
            [scrollView setScrollIndicatorInsets:edgeInsets];
        } completion:nil];
        return;
    }
    
    //Shift the entire view
    CGRect selfViewFrame = self.view.bounds;
    [UIView animateWithDuration:duration delay:0 options:animationCurve animations:^{
        self.view.frame = selfViewFrame;
    } completion:nil];
}



#pragma mark - Local notification helpers

- (void)sendNotification:(NSString *)notificationName
{
	[self sendNotification:notificationName body:nil type:nil];
}


- (void)sendNotification:(NSString *)notificationName body:(id)body
{
	[self sendNotification:notificationName body:body type:nil];
}

- (void)sendNotification:(NSString *)notificationName body:(id)body type:(id)type
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	NSMutableDictionary *dic = nil;
	if (body || type) {
		dic = [[NSMutableDictionary alloc] init];
		if (body) [dic setObject:body forKey:@"body"];
		if (type) [dic setObject:type forKey:@"type"];
	}
	NSNotification *n = [NSNotification notificationWithName:notificationName object:self userInfo:dic];
	[center postNotification:n];
}

- (NSArray *)listNotificationInterests
{
    return [NSArray array];
}

- (void)handleNotification:(NSNotification *)notification
{
    
}

@end
