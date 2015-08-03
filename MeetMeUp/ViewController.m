//
//  ViewController.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 7/27/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Event.h"

@interface ViewController () <UITextFieldDelegate>
@property NSDictionary *JSONdictionary;
@property (strong, nonatomic) NSArray *resultEventsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSString *searchTerm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Event retrieveEventWithCompletion:^(NSMutableArray *events) {
        self.resultEventsArray = events;
    }];

    self.searchTerm = @"";
}


- (void)setResultEventsArray:(NSArray *)resultEventsArray {
    _resultEventsArray = resultEventsArray;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    self.searchTerm = self.textField.text;
    [Event retrieveFilteredEvent:self.searchTerm WithCompletion:^(NSMutableArray *events) {
        self.resultEventsArray = events;
    }];

    [textField resignFirstResponder];
    return NO;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultEventsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetUpCell"];
    Event *e = [self.resultEventsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = e.name;
    cell.detailTextLabel.text = e.address;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dVC = segue.destinationViewController;
    Event *event = [self.resultEventsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    dVC.event = event;
}



@end
