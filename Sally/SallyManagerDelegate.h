//
//  SallyManagerDelegate.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward Declarations
@class Trip;

@protocol SallyManagerDelegate <NSObject>

- (void)fetchingTripsFailedWithError:(NSError *)error;
- (void)fetchingLocationsForTrip:(Trip *)trip failedWithError:(NSError *)error;

- (void)didReceivedTrips:(NSArray *)trips;
- (void)didReceivedLocations:(NSArray *)locations;

@end
