//
//  CommentsViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "CommentsViewController.h"
#import "MemberViewController.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSDictionary *JSONdictionary;
@property NSArray *resultArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Comments";
    [self getComments];
}

-(void)getComments {


    NSString *firstPart = @"https://api.meetup.com/2/event_comments.json?event_id=";
    NSString *secondPart = @"&key=6d784d3f65707058127e51273520155c";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", firstPart, self.eventID, secondPart]];

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.JSONdictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.resultArray = [self.JSONdictionary objectForKey:@"results"];
        [self.tableView reloadData];
    }]resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell"];
    NSDictionary *eventComment = [self.resultArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [eventComment objectForKey:@"member_name"];
    cell.detailTextLabel.text = [eventComment objectForKey:@"comment"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MemberViewController *mVC = segue.destinationViewController;
    NSDictionary *eventComment = [self.resultArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    NSInteger memberID = [[eventComment objectForKey:@"member_id"] integerValue];
    NSString *memberIDString = [NSString stringWithFormat:@"%ld", memberID];
    mVC.memberID = memberIDString;
    
}



@end
