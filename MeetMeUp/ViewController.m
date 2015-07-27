//
//  ViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property NSDictionary *meetUp;
@property NSArray *eventsArray;
@property NSDictionary *dictionary;
@property NSDictionary *subDictionary;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSString *searchTerm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromMeetUp];
    self.searchTerm = @"";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    self.searchTerm = self.textField.text;
    [self getDataFromTextField];
    [textField resignFirstResponder];
    return NO;
}


-(void)getDataFromTextField {

    NSString *searchTerm = self.searchTerm;
    NSString *firstPart = @"https://api.meetup.com/2/open_events.json?zip=60604&text=";
    NSString *secondPart = @"&time=,1w&key=6d784d3f65707058127e51273520155c";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@", firstPart, searchTerm, secondPart]];

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.meetUp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.eventsArray = [self.meetUp objectForKey:@"results"];
        [self.tableView reloadData];
    }]resume];

}

-(void)getDataFromMeetUp {
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=6d784d3f65707058127e51273520155c"];
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.meetUp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.eventsArray = [self.meetUp objectForKey:@"results"];
        [self.tableView reloadData];
    }]resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetUpCell"];
    self.dictionary = [self.eventsArray objectAtIndex:indexPath.row];
    self.subDictionary = [self.dictionary objectForKey:@"venue"];
    cell.textLabel.text = [self.dictionary objectForKey:@"name"];
    cell.detailTextLabel.text = [self.subDictionary objectForKey:@"address_1"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dVC = segue.destinationViewController;
    NSDictionary *dictionary = [self.eventsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    //dVC.title = self.tableView c
    //[self.dictionary objectForKey:@"name"];
    dVC.dictionary = dictionary;
    //dVC.subDictionary = self.dictionary;
}



@end
