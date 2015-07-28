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
@property NSDictionary *JSONdictionary;
@property NSArray *resultEventsArray;
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
        self.JSONdictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.resultEventsArray = [self.JSONdictionary objectForKey:@"results"];
        [self.tableView reloadData];
    }]resume];

}

-(void)getDataFromMeetUp {
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=6d784d3f65707058127e51273520155c"];
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.JSONdictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.resultEventsArray = [self.JSONdictionary objectForKey:@"results"];
        [self.tableView reloadData];
    }]resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultEventsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetUpCell"];

    NSDictionary *event = [self.resultEventsArray objectAtIndex:indexPath.row];
    NSDictionary *venue = [event objectForKey:@"venue"];

    NSString *address = [venue objectForKey:@"address_1"];
    NSString *city = [venue objectForKey:@"city"];

    cell.textLabel.text = [event objectForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", address, city];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dVC = segue.destinationViewController;
    NSDictionary *event = [self.resultEventsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    dVC.event = event;
}



@end
