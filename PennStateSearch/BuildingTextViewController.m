//
//  BuildingTextViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/31/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingTextViewController.h"
#import "BuildingInfoViewController.h"

@interface BuildingTextViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoButton;

@end

@implementation BuildingTextViewController

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
    
    self.title = self.buildingName;
    
    if(self.buildingPhoto == nil) {
        self.photoButton.style = UIBarButtonItemStylePlain;
        self.photoButton.title = nil;
    } else {
        self.photoButton.style = UIBarButtonItemStyleBordered;
        self.photoButton.title = @"Photo";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BuildingInfoViewController *viewController = segue.destinationViewController;
    viewController.selectedBuilding = self.buildingName;
    
    UIImage *image = [UIImage imageWithData:self.buildingPhoto];
    viewController.selectedBuildingImage = image;
    
}

@end
