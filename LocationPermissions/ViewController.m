//
//  ViewController.m
//  LocationPermissions
//
//  Created by Manuel Marcos Regalado on 08/09/2015.
//  Copyright (c) 2015 manuel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UILabel           *locationManagerStatusLabel;
@property (nonatomic, strong)          CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManagerStatusLabel.text = [self convertAuthorizationStatusToString:[CLLocationManager authorizationStatus]];
}

- (void)dealloc {
    
    _locationManagerStatusLabel = nil;
    _locationManager            = nil;
}

- (IBAction)requestAuthorizationButtonTapped:(id)sender {

    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];

    switch (authorizationStatus) {
            
        case kCLAuthorizationStatusNotDetermined:
            [_locationManager requestWhenInUseAuthorization];
            break;
            
        case kCLAuthorizationStatusRestricted:
            break;
            
        case kCLAuthorizationStatusDenied:
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_locationManager requestAlwaysAuthorization];
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    _locationManagerStatusLabel.text = [self convertAuthorizationStatusToString:[CLLocationManager authorizationStatus]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Location Manager Error: %@", error.localizedDescription);
}

- (NSString*)convertAuthorizationStatusToString:(CLAuthorizationStatus)authorizationStatus {
    
    NSString *result = nil;
    
    switch (authorizationStatus) {
            
        case kCLAuthorizationStatusNotDetermined:
            result = @"Authorization Status Not Determined";
            break;
            
        case kCLAuthorizationStatusRestricted:
            result = @"Authorization Status Restricted";
            break;
            
        case kCLAuthorizationStatusDenied:
            result = @"Authorization Status Denied";
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            result = @"Authorization Status Authorized Always";
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            result = @"Authorization Status Authorized When In Use";
            break;
            
        default:
            result = @"Authorization Status Not Determined";
    }
    
    return result;
}

@end
