//
//  SallyCommunicatorDelegate.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-03-17.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward Declarations
@class SallyCommunicator;

@protocol SallyCommunicatorDelegate <NSObject>

- (void)sallyCommunicator:(SallyCommunicator *)communicator didSignInWithToken:(NSString *)token;
- (void)sallyCommunicator:(SallyCommunicator *)communicator signInFailedWithError:(NSError *)error;
- (void)sallyCommunicator:(SallyCommunicator *)communicator didFetchTrips:(NSArray *)trips;
- (void)sallyCommunicator:(SallyCommunicator *)communicator fetchTripsFailedWithError:(NSError *)error;

@end
