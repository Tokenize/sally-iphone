//
//  User.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface User : MTLModel <MTLJSONSerializing>

@property (readonly) NSString *firstName;
@property (readonly) NSString *lastName;
@property (readonly) NSString *email;

@end