//
//  SallyManager.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward Declarations (Protocols)
@protocol SallyManagerDelegate;

// Forward Declarations (Classes)
@class LocationBuilder;
@class SallyCommunicator;
@class Trip;
@class TripBuilder;
@class User;

@interface SallyManager : NSObject

extern NSString *SallyManagerErrors;

enum {
    SallyManagerErrorTripFetchCode,
    SallyManagerErrorLocationFetchCode
};

#pragma mark - Properties

@property (weak, nonatomic) id<SallyManagerDelegate> delegate;
@property SallyCommunicator *communicator;
@property User *user;
@property TripBuilder *tripBuilder;
@property LocationBuilder *locationBuilder;

#pragma mark - Trip Methods

- (void)fetchTrips;
- (void)fetchingTripsFailedWithError:(NSError *)error;
- (void)receivedTripsJSON:(NSString *)objectNotation;

#pragma mark - Location Methods

- (void)fetchLocationsForTrip:(NSUInteger)tripID;
- (void)fetchingLocationsForTrip:(Trip *)trip failedWithError:(NSError *)error;
- (void)receivedLocationsJSON:(NSString *)objectNotation forTrip:(Trip *)trip;

@end