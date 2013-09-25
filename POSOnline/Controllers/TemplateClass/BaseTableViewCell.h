//
//  BaseTableViewCell.h
//  MyBaseProject
//
//  Created by Torin on 21/3/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) UIViewController * parentVC;
@property (nonatomic, strong) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblSubtitle;

@property (nonatomic, assign) CGRect initialImageFrame;
@property (nonatomic, assign) CGRect initialTitleFrame;
@property (nonatomic, assign) CGRect initialSubtitleFrame;

+ (CGFloat)getHeight;
- (void)resetLayout;
- (void)configureWithData:(id)model;

@end
