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
#import "Trip.h"
#import "User.h"

@implementation SallyManager

@synthesize delegate;
@synthesize communicator;
@synthesize user;

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

#pragma mark - Trip Methods

- (void)fetchTrips
{
    [communicator fetchTrips];
}

- (void)createTrip:(Trip *)trip
{
    NSDictionary *tripParameters = [MTLJSONAdapter JSONDictionaryFromModel: trip];

    [self.communicator createTrip: tripParameters];
}

#pragma mark -

- (void)sallyCommunicator:(SallyCommunicator *)communicator didFetchTrips:(NSArray *)trips
{
    NSValueTransformer *tripsTransformer = [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass: Trip.class];

    [self.delegate didReceivedTrips: [tripsTransformer transformedValue: trips]];
}

- (void)sallyCommunicator:(SallyCommunicator *)communicator fetchTripsFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain: SallyManagerErrors code: SallyManagerErrorTripFetchCode userInfo: errorInfo];

    [delegate fetchingTripsFailedWithError: reportableError];
}

- (void)sallyCommunicator:(SallyCommunicator *)communicator didCreateTrip:(NSDictionary *)tripJSON
{
    Trip *trip = [MTLJSONAdapter modelOfClass: Trip.class fromJSONDictionary: tripJSON error: nil];

    [self.delegate sallyManager: self didCreateTrip: trip];
}

- (void)sallyCommunicator:(SallyCommunicator *)communicator createTripFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain: SallyManagerErrors code: SallyManagerErrorCreateTrip userInfo: errorInfo];

    [self.delegate sallyManager: self createTripFailedWithError: reportableError];
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

@end


