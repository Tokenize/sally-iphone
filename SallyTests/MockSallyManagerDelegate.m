//
//  MockSallyManagerDelegate.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "MockSallyManagerDelegate.h"

@implementation MockSallyManagerDelegate

@synthesize fetchError;
@synthesize receivedTrips;

- (void)fetchingTripsFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceivedTrips:(NSArray *)trips
{
    self.receivedTrips = trips;
}

@end
