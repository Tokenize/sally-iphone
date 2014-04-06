//
//  SallyManager.h
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