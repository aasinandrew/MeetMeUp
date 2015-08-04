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
@property (nonatomic, strong)  NSMutableArray *comments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Comments";
    [Comments getCommentsWithEventID:self.event.eventID withCompletion:^(NSMutableArray *comments) {
        self.comments = comments;
    }];

}

- (void)setComments:(NSMutableArray *)comments {
    _comments = comments;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell"];
     Comments *comment = [self.comments objectAtIndex:indexPath.row];
    cell.textLabel.text = comment.name;
    cell.detailTextLabel.text = comment.comment;
    cell.detailTextLabel.numberOfLines = 2;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MemberViewController *mVC = segue.destinationViewController;
    Comments *comment = [self.comments objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    mVC.memberID = comment.memberID;
    
}



@end
