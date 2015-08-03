//
//  Comments.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 8/3/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "Comments.h"

@implementation Comments

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _memberID = dictionary[@"member_id"];
        _name = dictionary[@"member_name"];
        _comment = dictionary[@"comment"];
    }
    return self;
}


+ (void)getCommentsWithEventID:(NSString *)eventID withCompletion:(void (^)(NSMutableArray * comments))complete {

    NSString *firstPart = @"https://api.meetup.com/2/event_comments.json?event_id=";
    NSString *secondPart = @"&key=6d784d3f65707058127e51273520155c";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", firstPart, eventID, secondPart]];

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *comments = [NSMutableArray new];
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *commentsDictionaries = [results objectForKey:@"results"];
        for (NSDictionary *d in commentsDictionaries) {
            Comments *c = [[Comments alloc]initWithDictionary:d];
            [comments addObject:c];
        }
        complete(comments);
    }]resume];
}

@end
