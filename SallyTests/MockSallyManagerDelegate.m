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

- (void)sallyManager:(SallyManager *)manager fetchLocationsForTripFailedWithError:(NSError *)fetchError
{
    self.error = fetchError;
}

- (void)sallyManager:(SallyManager *)manager didFetchLocationsForTrip:(NSArray *)locations
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

- (void)sallyManager:(SallyManager *)manager didCreateLocation:(Location *)createdLocation
{
    self.location = createdLocation;
}

- (void)sallyManager:(SallyManager *)manager createLocationFailedWithError:(NSError *)createError
{
    self.error = createError;
}

@end
