//
//  TrackLocationsController.h
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-09-11.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SallyManagerDelegate.h"

@interface TrackLocationsController : UIViewController<CLLocationManagerDelegate, SallyManagerDelegate>

@property (nonatomic) Trip *trip;

@end
