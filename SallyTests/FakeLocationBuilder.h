//
//  FakeLocationBuilder.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "LocationBuilder.h"

@interface FakeLocationBuilder : LocationBuilder

#pragma mark - Properties

@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;

@end
