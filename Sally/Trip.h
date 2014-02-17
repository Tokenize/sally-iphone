//
//  Trip.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward Declarations
@class Location;

@interface Trip : NSObject

@property NSUInteger tripId;
@property (readonly) NSString *name;
@property (readonly) NSString *description;
@property (readonly) NSDate *startAt;
@property (readonly) NSDate *endAt;
@property (readonly) NSArray *locations;

- (id)initWithName:(NSString *)aName description:(NSString *)aDescription startAt:(NSDate *)start endDate:(NSDate *)end;

- (void)addLocation:(Location *)newLocation;

@end
