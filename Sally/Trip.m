//
//  Trip.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "Trip.h"
#import "Location.h"

NSString * const TripErrorDomain = @"TripErrorDomain";

@implementation Trip
{
    NSMutableArray *locationsList;
}

@synthesize tripId;
@synthesize name;
@synthesize description;
@synthesize startAt;
@synthesize endAt;

- (id)init {
    if (self = [super init]) {
        locationsList = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tripID": @"trip_id",
             @"startAt": @"start_at",
             @"endAt": @"end_at"
    };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

#pragma mark - Transformers

+ (NSValueTransformer *)startAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)endAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

#pragma mark - Validations

- (BOOL)validateName:(NSString **)tripName error:(NSError **)error {
    if (*tripName != nil) {
        return YES;
    }
    else {
        if (error != NULL) {
            *error = [NSError errorWithDomain: TripErrorDomain code: TripErrorMissingName userInfo: nil];
        }
        return NO;
    }
}

- (BOOL)validateStartAt:(NSString **)tripStartAt error:(NSError **)error {
    if (*tripStartAt != nil) {
        return YES;
    }
    else {
        if (error != nil) {
            *error = [NSError errorWithDomain: TripErrorDomain code: TripErrorMissingStartAt userInfo: nil];
        }
    }
    return NO;
}

#pragma mark -

- (id)initWithName:(NSString *)aName description:(NSString *)aDescription startAt:(NSDate *)start endDate:(NSDate *)end
{
    if (aName == nil || start == nil) {
        return nil;
    }
    
    if (self = [super init]) {
        name = [aName copy];
        startAt = [start copy];
        description = [aDescription copy];
        endAt = [end copy];
        locationsList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addLocation:(Location *)newLocation
{
    [locationsList addObject: newLocation];
}

- (NSArray *)locations
{
    return locationsList;
}

@end
