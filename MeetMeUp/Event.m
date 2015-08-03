//
//  Event.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 8/3/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "Event.h"

@implementation Event

-(instancetype)initWithEventsDictionary:(NSDictionary *)eventsDictionary venueDictionary:(NSDictionary *)venueDictionary groupDictionary:(NSDictionary *)groupDictionary {
    if (self = [super init]) {
        _name = eventsDictionary[@"name"];
        _address = venueDictionary[@"address_1"];
        _rsvpCount = (int)[eventsDictionary[@"yes_rsvp_count"]integerValue];
        _eventDescription = eventsDictionary[@"description"];
        _groupName = groupDictionary[@"name"];
        _eventID =  eventsDictionary[@"id"];
        _url = eventsDictionary[@"event_url"];
        
    }
    return self;
}

+ (void)retrieveEventWithCompletion:(void(^)(NSMutableArray *events))complete {
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94539&text=mobile&time=,1w&key=6d784d3f65707058127e51273520155c"];
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *events = [NSMutableArray new];
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *eventsDictionaries = [results objectForKey:@"results"];
        for (NSDictionary *d in eventsDictionaries) {
            Event *e = [[Event alloc]initWithEventsDictionary:d venueDictionary:d[@"venue"] groupDictionary:d[@"group"]];
            [events addObject:e];
        }
        complete(events);
    }]resume];
}

+ (void)retrieveFilteredEvent:(NSString *)searchTerm WithCompletion:(void (^)(NSMutableArray *))complete {
        NSString *firstPart = @"https://api.meetup.com/2/open_events.json?zip=94539&text=";
        NSString *secondPart = @"&time=,1w&key=6d784d3f65707058127e51273520155c";
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@", firstPart, searchTerm, secondPart]];
    
        [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSMutableArray *events = [NSMutableArray new];
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *eventsDictionaries = [results objectForKey:@"results"];
            for (NSDictionary *d in eventsDictionaries) {
                Event *e = [[Event alloc]initWithEventsDictionary:d venueDictionary:d[@"venue"] groupDictionary:d[@"group"]];
                [events addObject:e];
            }
            complete(events);
        }]resume];

}

@end
