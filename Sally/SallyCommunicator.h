//
//  SallyCommunicator.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

// Forward declarations
@class Trip;
@class User;
@protocol SallyCommunicatorDelegate;

@interface SallyCommunicator : AFHTTPSessionManager

@property (nonatomic, weak) id<SallyCommunicatorDelegate>delegate;
@property NSMutableDictionary *parameters;

+ (SallyCommunicator *)sharedSallyCommunicator;

- (void)fetchTrips;
- (void)fetchLocationsForTrip:(NSUInteger)tripID;
- (void)createTrip:(NSDictionary *)tripAttributes;

- (void)signInWithEmail:(NSString *)email password:(NSString *)password;

@end
