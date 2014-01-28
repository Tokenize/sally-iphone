//
//  User.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize firstName;
@synthesize lastName;
@synthesize email;

- (id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName email:(NSString *)anEmail
{
    if (self = [super init]) {
        firstName = [aFirstName copy];
        lastName = [aLastName copy];;
        email = [anEmail copy];
    }
    return self;
}

@end
