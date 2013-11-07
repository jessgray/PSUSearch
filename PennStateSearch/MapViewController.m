//
//  MapViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 11/7/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "MapViewController.h"
#import "BuildingInfoViewController.h"

#define kDistance 500

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self updateMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMapView {
    // ----- Region
    
    NSNumber *latitude = (NSNumber*)self.lat;
    NSNumber *longitude = (NSNumber *)self.lon;

    self.mapCenter = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapCenter, kDistance, kDistance);
    [self.mapView setRegion:region];
    
    // ----- Annotations
    [self.mapView removeAnnotations:[self.mapView annotations]];
    
    MKPointAnnotation *building = [[MKPointAnnotation alloc] init];
    
    self.buildingCenter = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    
    [building setCoordinate:self.buildingCenter];
    [building setTitle: self.buildingName];
    [self.mapView addAnnotation:building];
}

#pragma mark - MapView Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annoView"];
    
    if (!annoView) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annoView"];
        annoView.canShowCallout = YES;
        
        if(self.buildingPhoto != nil) {
            //UIButton *disclosure = ;
            annoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        
    } else {
        [annoView setAnnotation:annotation];
    }
    
    return annoView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"MapToPhotoSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"MapToPhotoSegue"]) {
        BuildingInfoViewController *buildingPhotoController = segue.destinationViewController;
        buildingPhotoController.selectedBuilding = self.buildingName;
        
        UIImage *image = [UIImage imageWithData:self.buildingPhoto];
        buildingPhotoController.selectedBuildingImage = image;
    }
}



























    

@end
