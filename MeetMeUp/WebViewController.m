//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}

- (IBAction)xButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if (webView.canGoBack) {
        self.backButton.enabled = YES;
    }
    else {
        self.backButton.enabled = NO;
    }
    if (webView.canGoForward) {
        self.forwardButton.enabled = YES;
    }
    else {
        self.forwardButton.enabled = NO;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}

@end
