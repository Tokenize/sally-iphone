//
//  User.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"firstName": @"first_name",
             @"lastName": @"last_name",
    };
}

@end
