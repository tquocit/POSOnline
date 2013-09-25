//
//  BaseDetailViewController.h
//  MyBaseProject
//
//  Created by Torin on 16/3/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LABEL_SPACING             5

@interface BaseDetailViewController : BaseViewController <UIScrollViewDelegate>

@property (nonatomic, assign) CGRect imageViewOriginalFrame;
@property (nonatomic, weak) IBOutlet UIImageView * imageView;
@property (nonatomic, weak) IBOutlet UIScrollView * scrollView;

@end
