//
//  TrackLocationsController.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-09-11.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "TrackLocationsController.h"
#import "SallyManager.h"
#import "SallyCommunicator.h"
#import "Trip.h"
#import "Location.h"

@interface TrackLocationsController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *locationSpinner;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) SallyManager *manager;

@end

@implementation TrackLocationsController

@synthesize trip;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];

    _manager = [[SallyManager alloc] init];
    _manager.communicator = [SallyCommunicator sharedSallyCommunicator];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;

    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;

        [_locationManager startUpdatingLocation];
    }
    else {
        NSLog(@"Location services is not enabled...");
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *latestLocation = [locations lastObject];

    Location *location = [[Location alloc] initWithDictionary: @{@"latitude": [NSNumber numberWithDouble: latestLocation.coordinate.latitude], @"longitude": [NSNumber numberWithDouble: latestLocation.coordinate.longitude], @"travelSpeed": [NSNumber numberWithDouble: latestLocation.speed], @"time": latestLocation.timestamp, @"tripId": [NSNumber numberWithUnsignedLong: trip.tripId]} error: nil];

    [_manager createLocation: location];

    if ([self.locationSpinner isAnimating]) {
        [self.locationSpinner stopAnimating];
    }
    else {
        [self.locationSpinner startAnimating];
    }
}

#pragma mark - SallyManagerDelegate methods

- (void)sallyManager:(SallyManager *)manager didCreateLocation:(Location *)location
{
    NSLog(@"Successfully created Location: [%@]", [location description]);
}

- (void)sallyManager:(SallyManager *)manager createLocationFailedWithError:(NSError *)error
{
    NSLog(@"Failed to Create Location, Error: %@", [error description]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
