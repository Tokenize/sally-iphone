//
//  SallyManager.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SallyManager.h"

@implementation SallyManager

@synthesize delegate;
@synthesize communicator;
@synthesize user;
@synthesize tripBuilder;

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
    [communicator fetchTripsForUser: user];
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

@end


