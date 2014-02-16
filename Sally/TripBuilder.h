//
//  TripBuilder.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/15/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripBuilder : NSObject

extern NSString *TripBuilderErrors;

enum {
    TripBuilderInvalidJSONError,
    TripBuilderMissingDataError
};

- (NSArray *)tripsFromJSON:(NSString *)objectNotation error:(NSError **)error;

@end
