//
//  Location.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/28/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface Location : MTLModel <MTLJSONSerializing>

@property NSUInteger locationId;
@property NSDate *time;
@property NSString *direction;
@property NSNumber *latitude;
@property NSNumber *longitude;
@property NSInteger speed;

@end