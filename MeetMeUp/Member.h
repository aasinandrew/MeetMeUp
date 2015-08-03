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

-(instancetype)initWithName:(NSString *)name photo:(NSString *)url;
+(void)retrieveMember:(NSString *)memberID withCompletion:(void(^)(Member *member))complete;

@end
