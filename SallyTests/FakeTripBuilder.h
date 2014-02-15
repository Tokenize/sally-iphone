//
//  FakeTripBuilder.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/15/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "TripBuilder.h"
#import "TripBuilder.h"

@interface FakeTripBuilder : TripBuilder

#pragma mark - Properties

@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;

@end
