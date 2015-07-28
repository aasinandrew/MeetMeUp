//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()
@property NSDictionary *JSONdictionary;
@property NSArray *resultArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMember];
}

-(void)getMember {


    NSString *firstPart = @"https://api.meetup.com/2/members.json?member_id=";
    NSString *secondPart = @"&key=6d784d3f65707058127e51273520155c";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", firstPart, self.memberID, secondPart]];

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.JSONdictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.resultArray = [self.JSONdictionary objectForKey:@"results"];
        NSDictionary *member = [self.resultArray objectAtIndex:0];
        self.nameLabel.text = [member objectForKey:@"name"];
        self.cityLabel.text = [member objectForKey:@"city"];

        NSDictionary *photo = [member objectForKey:@"photo"];
        NSURL *photourl = [NSURL URLWithString:photo[@"photo_link"]];

        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];

        self.title = [member objectForKey:@"name"];

    }]resume];
}

@end
