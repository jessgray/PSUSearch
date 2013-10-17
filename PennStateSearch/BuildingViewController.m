//
//  BuildingViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/10/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingViewController.h"
#import "BuildingModel.h"
#import "BuildingInfoViewController.h"

@interface BuildingViewController ()
@property (strong, nonatomic) IBOutlet UITableView *buildingsTable;
@property (nonatomic, strong) BuildingModel *buildingModel;
@property (nonatomic, strong) NSString *selectedBuilding;
@property (nonatomic, strong) UIImage *selectedBuildingImage;
@end

@implementation BuildingViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _buildingModel = [[BuildingModel alloc] init];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateTitle {
        self.title = @"Campus Buildings";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateTitle];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.buildingModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    // Decide which prototype cell to use for buildings
    UIImage *buildingPhoto = [self.buildingModel buildingImageForIndex:indexPath.row];
    
    if(buildingPhoto != nil) {
        CellIdentifier = @"ImageCell";
    } else {
        CellIdentifier = @"NoImageCell";
    }
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(nil==cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.buildingModel buildingForIndex:indexPath.row];

    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UITableViewCell *cell = [self.buildingsTable cellForRowAtIndexPath:[self.buildingsTable indexPathForSelectedRow]];
    
    if ([segue.identifier isEqualToString:@"PreferencesSegue"]) {
    
    } else if ([segue.identifier isEqualToString:@"InfoSegue"]) {
        BuildingInfoViewController *viewController = segue.destinationViewController;
        viewController.buildingModel = self.buildingModel;
        viewController.selectedBuilding = cell.textLabel.text;
        viewController.selectedBuildingImage = [self.buildingModel buildingImageForIndex:[self.buildingsTable indexPathForSelectedRow].row];
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
