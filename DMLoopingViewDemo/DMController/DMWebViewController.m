//
//  DMWebViewController.m
//  DMLoopingViewDemo
//
//  Created by yangdeming on 2020/6/2.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMWebViewController.h"
#import <WebKit/WebKit.h>

@interface DMWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [self.webView loadRequest:req];
}


@end
