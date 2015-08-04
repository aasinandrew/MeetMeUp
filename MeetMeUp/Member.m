//
//  Member.m
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 8/3/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "Member.h"

@implementation Member

-(instancetype)initWithName:(NSString *)name photo:(NSString *)url city:(NSString *)city {
    if (self = [super init]) {
        _name = [name copy];
        _photoUrl = [url copy];
        _city = [city copy];
    }
    return self;
}


+ (void)retrieveMember:(NSString *)memberID withCompletion:(void (^)(Member * member))complete {
    NSString *firstPart = @"https://api.meetup.com/2/members.json?member_id=";
    NSString *secondPart = @"&key=6d784d3f65707058127e51273520155c";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", firstPart, memberID, secondPart]];

    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *member = [results objectForKey:@"results"];
        Member *m = [Member new];
        for (NSDictionary *d in member) {
            if ([d objectForKey:@"name"]) {
                m.name = [d objectForKey:@"name"];
            }
            if ([d objectForKey:@"photo"]) {
                NSDictionary *dict = [d objectForKey:@"photo"];
                m.photoUrl = [dict objectForKey:@"photo_link"];
            }
            if ([d objectForKey:@"city"]) {
                m.city = [d objectForKey:@"city"];
            }
        }
        complete(m);
    }]resume];

}

@end
