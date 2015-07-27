//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()
@property NSDictionary *dictionary;
@property NSArray *array;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getMember];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMember {


    NSString *firstPart = @"https://api.meetup.com/2/members.json?member_id=";
    NSString *secondPart = @"&key=6d784d3f65707058127e51273520155c";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", firstPart, self.memberID, secondPart]];
    NSString *urlstring = [url absoluteString];
    NSLog(urlstring);

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.array = [self.dictionary objectForKey:@"results"];
        NSDictionary * sub = [self.array objectAtIndex:0];
        self.nameLabel.text = [sub objectForKey:@"name"];
        self.cityLabel.text = [sub objectForKey:@"city"];

        NSDictionary *photosub = [sub objectForKey:@"photo"];
        NSURL *photourl = [NSURL URLWithString:photosub[@"photo_link"]];

        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];

        self.title = [sub objectForKey:@"name"];

    }]resume];


}

@end
