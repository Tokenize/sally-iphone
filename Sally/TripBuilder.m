//
//  TripBuilder.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/15/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "TripBuilder.h"
#import "Trip.h"

@implementation TripBuilder

NSString *TripBuilderErrors = @"TripBuilderErrors";

- (NSArray *)tripsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData: unicodeNotation options: 0 error: &localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain: TripBuilderErrors code: TripBuilderInvalidJSONError userInfo: nil];
        }
        return nil;
    }
    
    NSArray *trips = [parsedObject objectForKey: @"trips"];
    
    if (trips == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain: TripBuilderErrors code: TripBuilderMissingDataError userInfo: nil];
        }
        return nil;
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity: [trips count]];
    
    for (NSDictionary *parsedTrip in trips) {
        NSString *nameString = [parsedTrip objectForKey: @"name"];
        NSString *descriptionString = [parsedTrip objectForKey: @"description"];
        NSString *startAtString = [parsedTrip objectForKey: @"start_at"];
        NSString *endAtString = [parsedTrip objectForKey: @"end_at"];
        
        NSDate *startAt = nil;
        NSDate *endAt = nil;
        NSString *name = nil;
        NSString *description = nil;
        
        if (![startAtString isKindOfClass: [NSNull class]]) {
            startAt = [self dateFromJSONDate: startAtString];
        }
        
        if (![endAtString isKindOfClass: [NSNull class]]) {
            endAt = [self dateFromJSONDate: endAtString];
        }
        
        if (![nameString isKindOfClass: [NSNull class]]) {
            name = nameString;
        }
        
        if (![descriptionString isKindOfClass: [NSNull class]]) {
            description = descriptionString;
        }
        
        Trip *thisTrip = [[Trip alloc] initWithName: name description: description startAt: startAt endDate: endAt];
        thisTrip.tripId = [[parsedTrip objectForKey: @"id"] longValue];
        
        if (thisTrip != nil) {
            [results addObject: thisTrip];
        }
        
    }
    
    return [results copy];
}

- (NSDate *)dateFromJSONDate:(NSString *)jsonDate
{
    if (jsonDate == nil) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [formatter setDateFormat: @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    [formatter setLocale: enUSPOSIXLocale];
    [formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
    
    NSDate *date = [formatter dateFromString: jsonDate];
    
    return date;
}

@end
