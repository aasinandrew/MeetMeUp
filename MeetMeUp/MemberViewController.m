//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) Member *member;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Member retrieveMember:self.memberID withCompletion:^(Member *member) {
        self.member = member;

    }];
}

- (void)setMember:(Member *)member {
    _member = member;
    [self.nameLabel performSelectorOnMainThread:@selector(setText:) withObject:self.member.name waitUntilDone:NO];
    [self.cityLabel performSelectorOnMainThread:@selector(setText:) withObject:self.member.city waitUntilDone:NO];
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.member.photoUrl]]] waitUntilDone:NO];
}

@end

