//
//  FPMovieStatsVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/27/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMovieStatsVC.h"

@interface FPMovieStatsVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation FPMovieStatsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Setup
- (void)setupWebView
{
    self.webView.multipleTouchEnabled = NO;
    //self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
}

- (void)blankWebView
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

// MARK: Public Interface
- (void)loadULRString:(NSString *)URLString
{
    [self blankWebView];

    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

- (void)updateHeatmap
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"createHeatmap();"];
}

// MARK: UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
}

@end
