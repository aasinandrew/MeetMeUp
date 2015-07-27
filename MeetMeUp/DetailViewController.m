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
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSString *eventID;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = [self.dictionary objectForKey:@"name"];
    NSInteger rsvpCount = [[self.dictionary objectForKey:@"yes_rsvp_count"] integerValue];
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)rsvpCount];


    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[self.dictionary objectForKey:@"description"]];
    self.textView.attributedText = text;

    NSDictionary *groupDictionary = [self.dictionary objectForKey:@"group"];
    self.hostingInfo.text = [groupDictionary objectForKey:@"name"];

    self.eventID = [self.dictionary objectForKey:@"id"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onWebPageButtonPressed:(UIButton *)sender {

    WebViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];

    ivc.url = [self.dictionary objectForKey:@"event_url"];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentModalViewController:ivc animated:YES];

    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsViewController *cVC = segue.destinationViewController;
    cVC.eventID = self.eventID;
}


@end
