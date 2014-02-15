//
//  FakeTripBuilder.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/15/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "FakeTripBuilder.h"

@implementation FakeTripBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;

- (NSArray *)tripsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    self.JSON = objectNotation;
    return arrayToReturn;
}

@end
