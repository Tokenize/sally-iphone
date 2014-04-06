//
//  SallyManager.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "SallyManager.h"
#import "SallyManagerDelegate.h"
#import "SallyCommunicator.h"
#import "TripBuilder.h"
#import "LocationBuilder.h"
#import "Trip.h"
#import "User.h"

@implementation SallyManager

@synthesize delegate;
@synthesize communicator;
@synthesize user;
@synthesize tripBuilder;
@synthesize locationBuilder;

NSString *SallyManagerErrors = @"SallyManagerError";

- (void)setDelegate:(id<SallyManagerDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol: @protocol(SallyManagerDelegate)]) {
        [[NSException exceptionWithName: NSInvalidArgumentException
                                 reason: @"Delegate does not conform to the SallyManagerDelegate protocol"
                               userInfo: nil] raise];
    }
    
    delegate = newDelegate;
}

- (void)fetchTrips
{
    [communicator fetchTrips];
}

- (void)fetchingTripsFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain: SallyManagerErrors code: SallyManagerErrorTripFetchCode userInfo: errorInfo];
    
    [delegate fetchingTripsFailedWithError: reportableError];
}

- (void)receivedTripsJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *trips = [tripBuilder tripsFromJSON: objectNotation error: &error];
    
    if (!trips) {
        NSDictionary *errorInfo = nil;
        
        if (error) {
            errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
        }
        
        NSError *reportableError = [NSError errorWithDomain: SallyManagerErrors
                                                       code: SallyManagerErrorTripFetchCode
                                                   userInfo: errorInfo];
        
        [delegate fetchingTripsFailedWithError: reportableError];
    }
    else {
        [delegate didReceivedTrips: trips];
    }
}

- (void)fetchLocationsForTrip:(NSUInteger)tripID
{
    [communicator fetchLocationsForTrip: tripID];
}

- (void)fetchingLocationsForTrip:(Trip *)trip failedWithError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain: SallyManagerErrors code: SallyManagerErrorLocationFetchCode userInfo: errorInfo];
    
    [delegate fetchingLocationsForTrip: trip failedWithError: reportableError];
}

- (void)receivedLocationsJSON:(NSString *)objectNotation forTrip:(Trip *)trip
{
    NSError *error = nil;
    NSArray *locations = [locationBuilder locationsFromJSON: objectNotation error: &error];
    
    if (!locations) {
        NSDictionary *errorInfo = nil;
        
        if (error) {
            errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
        }
        
        NSError *reportableError = [NSError errorWithDomain: SallyManagerErrors
                                                       code: SallyManagerErrorLocationFetchCode
                                                   userInfo: errorInfo];
        
        [delegate fetchingLocationsForTrip: trip failedWithError: reportableError];
    }
    else {
        [delegate didReceivedLocations: locations];
    }
}

@end


