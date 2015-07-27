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
@property NSDictionary *dictionary;
@property NSDictionary *sub;
@property NSArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getComments];
}

-(void)getComments {


    NSString *firstPart = @"https://api.meetup.com/2/event_comments.json?event_id=";
    NSString *secondPart = @"&key=6d784d3f65707058127e51273520155c";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", firstPart, self.eventID, secondPart]];
    //NSString *urlstring = [url absoluteString];
    //NSLog(urlstring);

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.array = [self.dictionary objectForKey:@"results"];
        [self.tableView reloadData];
    }]resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell"];
    NSDictionary * dictionary = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionary objectForKey:@"member_name"];
    cell.detailTextLabel.text = [dictionary objectForKey:@"comment"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MemberViewController *mVC = segue.destinationViewController;
    NSDictionary *dictionary = [self.array objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    NSInteger memberID = [[dictionary objectForKey:@"member_id"] integerValue];
    NSString *string = [NSString stringWithFormat:@"%ld", memberID];
    mVC.memberID = string;
    
}



@end
