//
//  BaseNavigationController.m
//  MyBaseProject
//
//  Created by Torin on 1/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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
    
    // Add custom drop shadow for navigation bar
    UIImage *shadow = [UIImage imageNamed:@"navbar_bg_shadow"];
    if ([self.navigationBar respondsToSelector:@selector(shadowImage)]) {
        self.navigationBar.shadowImage = shadow;
    } else {
        UIImageView *shadowView = [[UIImageView alloc] initWithImage:shadow];
        shadowView.width = self.navigationBar.width;
        shadowView.top = self.navigationBar.height;
        [self.navigationBar insertSubview:shadowView atIndex:0];
    }
  
  return self;
}

@end
