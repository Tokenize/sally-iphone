//
//  User.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (readonly) NSString *firstName;
@property (readonly) NSString *lastName;
@property (readonly) NSString *email;

- (id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName email:(NSString *)email;

@end
