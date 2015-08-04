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

    self.title = self.event.name;
    self.countLabel.text = [NSString stringWithFormat:@"RSVP Count: %d", self.event.rsvpCount];
    self.hostingInfo.text = self.event.groupName;
    self.eventID = self.event.eventID;

    NSString *descriptionText = self.event.eventDescription;
    [self.webView loadHTMLString:[descriptionText description] baseURL:nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WebPage"]) {
        WebViewController *wVC = segue.destinationViewController;
        wVC.url = self.event.url;
    }
    else {
        CommentsViewController *cVC = segue.destinationViewController;
        cVC.event = self.event;
    }
}

@end
