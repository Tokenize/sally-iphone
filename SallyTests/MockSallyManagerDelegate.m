//
//  MockSallyManagerDelegate.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "MockSallyManagerDelegate.h"

@implementation MockSallyManagerDelegate

@synthesize error;
@synthesize receivedTrips;
@synthesize receivedLocations;
@synthesize trip;

- (void)fetchingTripsFailedWithError:(NSError *)fetchError
{
    self.error = fetchError;
}

- (void)didReceivedTrips:(NSArray *)trips
{
    self.receivedTrips = trips;
}

- (void)fetchingLocationsForTrip:(Trip *)trip failedWithError:(NSError *)fetchLocationError
{
    self.error = fetchLocationError;
}

- (void)didReceivedLocations:(NSArray *)locations
{
    self.receivedLocations = locations;
}

- (void)sallyManager:(id)manager didCreateTrip:(Trip *)createdTrip
{
    self.trip = createdTrip;
}

- (void)sallyManager:(id)manager createTripFailedWithError:(NSError *)createError
{
    self.error = createError;
}

@end
