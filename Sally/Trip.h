//
//  Trip.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *description;
@property (readonly) NSDate *startAt;
@property (readonly) NSDate *endAt;

- (id)initWithName:(NSString *)aName description:(NSString *)aDescription startAt:(NSDate *)start endDate:(NSDate *)end;

@end
