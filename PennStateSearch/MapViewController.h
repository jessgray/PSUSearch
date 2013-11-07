//
//  MapViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 11/7/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) NSString *buildingName;
@property (nonatomic, strong) NSData *buildingPhoto;
@property (nonatomic, strong) NSValue *lat;
@property (nonatomic, strong) NSValue *lon;

@property CLLocationCoordinate2D mapCenter;
@property CLLocationCoordinate2D buildingCenter;

- (void)updateMapView;

@end
