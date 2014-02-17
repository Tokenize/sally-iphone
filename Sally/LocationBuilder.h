//
//  LocationBuilder.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationBuilder : NSObject

extern NSString *LocationBuilderErrors;

enum {
    LocationBuilderInvalidJSONError,
    LocationBuilderMissingDataError
};

- (NSArray *)locationsFromJSON:(NSString *)objectNotation error:(NSError **)error;

@end
