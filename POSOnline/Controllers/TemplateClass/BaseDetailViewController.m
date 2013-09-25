//
//  BaseDetailViewController.m
//  MyBaseProject
//
//  Created by Torin on 16/3/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "BaseDetailViewController.h"

@interface BaseDetailViewController ()

@end

@implementation BaseDetailViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //Link scrollview in case we forget
  if (self.scrollView == nil)
    for (UIScrollView *subview in self.view.subviews)
      if ([subview isKindOfClass:[UIScrollView class]])
        self.scrollView = subview;
  
  //Set scrollview delegate in case we forget
  self.scrollView.delegate = self;
  
  if (self.imageView == nil)
    DLog(@"WARNING: Image view is nil. Check IB linking.");
  self.imageView.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView.clipsToBounds = YES;
  self.imageViewOriginalFrame = self.imageView.frame;
  
  //Shadow below image
  self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
  self.imageView.layer.shadowOffset = CGSizeZero;
  self.imageView.layer.shadowOpacity = 0.4;
  self.imageView.layer.shadowRadius = 1;
}



#pragma mark - Action

//Override
- (IBAction)onBtnNavbarRight:(id)sender
{
  
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat offsetY = self.scrollView.contentOffset.y;
  
  if (offsetY <= 0 && CGRectGetHeight(self.imageViewOriginalFrame) > 0 && CGRectGetWidth(self.imageViewOriginalFrame) > 0)
  {
    CGRect newFrame = CGRectZero;
    newFrame.size.height = CGRectGetHeight(self.imageViewOriginalFrame) - offsetY;
    newFrame.size.width = newFrame.size.height / CGRectGetHeight(self.imageViewOriginalFrame) * CGRectGetWidth(self.imageViewOriginalFrame);
    newFrame.origin.x = CGRectGetMidX(self.imageViewOriginalFrame) - CGRectGetWidth(newFrame)/2;
    newFrame.origin.y = offsetY;
    self.imageView.frame = newFrame;
  }
}

@end
