//
//  BaseWebViewController.h
//  MyBaseProject
//
//  Created by Torin on 24/3/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : BaseViewController

@property (nonatomic, copy) NSString * url;
@property (nonatomic, readonly) UIWebView * webView;
@property (nonatomic, readonly) UIActivityIndicatorView * indicator;

@end
