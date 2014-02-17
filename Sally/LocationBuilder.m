//
//  LocationBuilder.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "LocationBuilder.h"
#import "Location.h"

@implementation LocationBuilder

NSString *LocationBuilderErrors = @"LocationBuilderErrors";

- (NSArray *)locationsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData: unicodeNotation options: 0 error: &localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain: LocationBuilderErrors code: LocationBuilderInvalidJSONError userInfo: nil];
        }
        return nil;
    }
    
    NSArray *locations = [parsedObject objectForKey: @"locations"];
    
    if (locations == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain: LocationBuilderErrors code: LocationBuilderMissingDataError userInfo: nil];
        }
        return nil;
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity: [locations count]];
    
    for (NSDictionary *parsedLocation in locations) {
        NSString *timeString = [parsedLocation objectForKey: @"time"];
        NSString *directionString = [parsedLocation objectForKey: @"direction"];
        NSString *speedString = [parsedLocation objectForKey: @"speed"];
        NSNumber *latitude = [parsedLocation objectForKey: @"latitude"];
        NSNumber *longitude = [parsedLocation objectForKey: @"longitude"];
        
        Location *thisLocation = [[Location alloc] init];
        thisLocation.locationId = [[parsedLocation objectForKey: @"id"] integerValue];
        thisLocation.latitude = latitude;
        thisLocation.longitude = longitude;
        thisLocation.time = [self dateFromJSONDate: timeString];
        
        if (![speedString isKindOfClass: [NSNull class]]) {
            thisLocation.speed = [speedString integerValue];
        }
        
        if (![directionString isKindOfClass: [NSNull class]]) {
            thisLocation.direction = directionString;
        }
        
        [results addObject: thisLocation];
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
