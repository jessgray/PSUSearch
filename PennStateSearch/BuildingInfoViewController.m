//
//  BuildingInfoViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/10/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingInfoViewController.h"
#import "Constants.h"

@interface BuildingInfoViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic, assign) BOOL zoomablePhotos;
@end

@implementation BuildingInfoViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _buildingModel = [[BuildingModel alloc] init];
    }
    return self;
}

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
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *zoomPhotos = [preferences objectForKey:kZoomablePhotos];
    self.zoomablePhotos = [zoomPhotos boolValue];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.title = self.selectedBuilding;
    
    UIImage *image = self.selectedBuildingImage;
    _imageView = [[UIImageView alloc] initWithImage:image];
    [self.photoScrollView addSubview:self.imageView];
    
    self.photoScrollView.contentSize = image.size;
    
    // Make images zoomable/not zoomable based on user preferences
    if(self.zoomablePhotos) {
        self.photoScrollView.maximumZoomScale = 2.0;
        self.photoScrollView.minimumZoomScale = self.photoScrollView.bounds.size.width/image.size.width;
        self.photoScrollView.bounces = YES;
        self.photoScrollView.bouncesZoom = NO;
    } else {
        self.photoScrollView.maximumZoomScale = self.photoScrollView.bounds.size.width/image.size.width;
        self.photoScrollView.minimumZoomScale = self.photoScrollView.bounds.size.width/image.size.width;
    }
    
    self.photoScrollView.delegate = self;
    [self.photoScrollView zoomToRect:self.imageView.bounds animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
