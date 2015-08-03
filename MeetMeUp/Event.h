//
//  Event.h
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 8/3/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property int rsvpCount;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *url;

-(instancetype)initWithEventsDictionary:(NSDictionary *)eventsDictionary venueDictionary:(NSDictionary *)venueDictionary groupDictionary:(NSDictionary *)groupDictionary;

+ (void)retrieveEventWithCompletion:(void(^)(NSMutableArray *events))complete;

+ (void)retrieveFilteredEvent:(NSString *)searchTerm  WithCompletion:(void(^) (NSMutableArray *events))complete;

@end
