//
//  Trip.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "Trip.h"
#import "Location.h"

@implementation Trip
{
    NSMutableArray *locationsList;
}

@synthesize tripId;
@synthesize name;
@synthesize description;
@synthesize startAt;
@synthesize endAt;

- (id)initWithName:(NSString *)aName description:(NSString *)aDescription startAt:(NSDate *)start endDate:(NSDate *)end
{
    if (aName == nil || start == nil) {
        return nil;
    }
    
    if (self = [super init]) {
        name = [aName copy];
        startAt = [start copy];
        description = [aDescription copy];
        endAt = [end copy];
        locationsList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addLocation:(Location *)newLocation
{
    [locationsList addObject: newLocation];
}

- (NSArray *)locations
{
    return locationsList;
}

@end
