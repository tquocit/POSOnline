//
//  BaseTableViewCell.m
//  MyBaseProject
//
//  Created by Torin on 21/3/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self == nil)
    return nil;
  
  //UI are not fully loaded at this point, so we need to dispatch_async
  dispatch_async(dispatch_get_main_queue(), ^{
    [self setupXYZ];
  });
  
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self == nil)
    return nil;
  
  //UI are not fully loaded at this point, so we need to dispatch_async
  dispatch_async(dispatch_get_main_queue(), ^{
    [self setupXYZ];
  });
  
  return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self == nil)
    return self;
  
  //UI are not fully loaded at this point, so we need to dispatch_async
  dispatch_async(dispatch_get_main_queue(), ^{
    [self setupXYZ];
  });

  return self;
}

- (void)setupXYZ
{
  self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)resetLayout
{
  if (self.lblSubtitle != nil && CGRectGetWidth(self.lblSubtitle.frame) > 0 && self.initialSubtitleFrame.size.width <= 0)
    self.initialSubtitleFrame = self.lblSubtitle.frame;
  
  if (self.lblTitle != nil && CGRectGetWidth(self.lblTitle.frame) > 0 && self.initialTitleFrame.size.width <= 0)
    self.initialTitleFrame = self.lblTitle.frame;
  
  if (self.imgView != nil && CGRectGetWidth(self.imgView.frame) > 0 && self.initialImageFrame.size.width <= 0)
    self.initialImageFrame = self.imgView.frame;
  
  [self.imgView setFrame:self.initialImageFrame];
  [self.lblTitle setFrame:self.initialTitleFrame];
  [self.lblSubtitle setFrame:self.initialSubtitleFrame];
}

- (void)configureWithData:(id)model
{
  DLog(@"WARNING: subclass to override this");
}

+ (CGFloat)getHeight
{
  return 44;
}

@end
