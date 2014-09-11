//
//  TripsController.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-09-10.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SallyManagerDelegate.h"

@interface TripsController : UITableViewController<SallyManagerDelegate>

@property (nonatomic) NSString *authenticationToken;

@end
