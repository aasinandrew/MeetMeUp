//
//  Comments.h
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 8/3/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject
@property (strong, nonatomic) NSString *memberID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comment;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)getCommentsWithEventID:(NSString *)eventID withCompletion:(void (^)(NSMutableArray * comments))complete;

@end
