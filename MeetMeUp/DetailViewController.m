//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "CommentsViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostingInfo;
@property NSString *eventID;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.event objectForKey:@"name"];
    NSInteger rsvpCount = [[self.event objectForKey:@"yes_rsvp_count"] integerValue];
    self.countLabel.text = [NSString stringWithFormat:@"RSVP Count: %ld", (long)rsvpCount];


    NSString *descriptionText = [self.event objectForKey:@"description"];
    NSDictionary *groupDictionary = [self.event objectForKey:@"group"];
    self.hostingInfo.text = [groupDictionary objectForKey:@"name"];

    self.eventID = [self.event objectForKey:@"id"];

    [self.webView loadHTMLString:[descriptionText description] baseURL:nil];

}

- (IBAction)onWebPageButtonPressed:(UIButton *)sender {

    WebViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];

    ivc.url = [self.event objectForKey:@"event_url"];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentModalViewController:ivc animated:YES];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsViewController *cVC = segue.destinationViewController;
    cVC.eventID = self.eventID;
}


@end
