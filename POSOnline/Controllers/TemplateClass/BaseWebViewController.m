//
//  BaseWebViewController.m
//  MyBaseProject
//
//  Created by Torin on 24/3/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () <UIWebViewDelegate>
@property (nonatomic, weak) UIWebView * webView;
@property (nonatomic, weak) UIActivityIndicatorView * indicator;
@end

@implementation BaseWebViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  //WebView
  UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:webView];
  self.webView = webView;
  
  //Indicator
  UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  indicator.center = self.view.contentCenter;
  indicator.color = [UIColor grayColor];
  [self.view addSubview:indicator];
  
  //Not valid
  if ([self.url hasPrefix:@"http"] == NO) {
    [self.indicator stopAnimating];
    return;
  }
  
  //Remove webview shadow when bounce
  [self.webView removeTopBottomShadow];

  NSURL * nsurl = [NSURL URLWithString:self.url];
  NSURLRequest * request = [NSURLRequest requestWithURL:nsurl];
  [self.webView loadRequest:request];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [self.indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [self.indicator stopAnimating];
}

@end
