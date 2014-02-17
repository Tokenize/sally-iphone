//
//  FakeLocationBuilder.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "FakeLocationBuilder.h"

@implementation FakeLocationBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;

- (NSArray *)locationsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    self.JSON = objectNotation;
    return arrayToReturn;
}


@end
