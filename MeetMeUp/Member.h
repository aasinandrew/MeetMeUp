//
//  Member.h
//  MeetMeUp
//
//  Created by Andrew  Nguyen on 8/3/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSString *city;

-(instancetype)initWithName:(NSString *)name photo:(NSString *)url city:(NSString *)city;
+(void)retrieveMember:(NSString *)memberID withCompletion:(void(^)(Member *member))complete;

@end
