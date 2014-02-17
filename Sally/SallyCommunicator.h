//
//  SallyCommunicator.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward declarations
@class Trip;
@class User;

@interface SallyCommunicator : NSObject

- (void)fetchTripsForUser:(User *)user;
- (void)fetchLocationsForTrip:(Trip *)trip;

@end
