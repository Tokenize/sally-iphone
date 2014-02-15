//
//  SallyManager.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SallyManagerDelegate.h"
#import "SallyCommunicator.h"

@interface SallyManager : NSObject

extern NSString *SallyManagerErrors;

enum {
    SallyManagerErrorTripFetchCode
};

#pragma mark - Properties

@property (weak, nonatomic) id<SallyManagerDelegate> delegate;
@property SallyCommunicator *communicator;
@property User *user;

#pragma mark - Trip Methods

- (void)fetchTrips;
- (void)fetchingTripsFailedWithError:(NSError *)error;

@end