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
#import "BuildingPreferencesViewController.h"
#import "Constants.h"
#import "DataSource.h"
#import "MyDataManager.h"
#import "Building.h"

static NSString * const kTitle = @"Campus Buildings";

@interface BuildingViewController ()
@property (strong, nonatomic) IBOutlet UITableView *buildingsTable;

@property (nonatomic, strong) BuildingModel *buildingModel;
@property (nonatomic, strong) NSString *selectedBuilding;
@property (nonatomic, strong) UIImage *selectedBuildingImage;
@property (nonatomic, assign) BOOL showingAllBuildings;
@property (nonatomic, strong) DataSource *dataSource;

@end

@implementation BuildingViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        //_buildingModel = [[BuildingModel alloc] init];
        MyDataManager *myDataManager = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:@"firstLetterOfName" dataManagerDelegate:myDataManager];
        
        _dataSource.delegate = self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = kTitle;
    
    self.tableView.dataSource = self.dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *showAllBuildings = [preferences objectForKey:kShowAllBuildings];
    self.showingAllBuildings = [showAllBuildings boolValue];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Data Source Cell Configurer
- (NSString*)cellIdentifierForObject:(id)object {
    Building *building = object;
    
    UIImage *image = [[UIImage alloc] initWithData:building.photo];
    
    // Return correct cell type based on if there is an image or not
    CGImageRef cgref = [image CGImage];
    CIImage *cim = [image CIImage];
    if(cim == nil && cgref == NULL) {
        return @"NoImageCell";
    } else {
        return @"ImageCell";
    }
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    Building *building = object;
    
    cell.textLabel.text = building.name;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
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
    return [self.buildingModel countForBuildings:self.showingAllBuildings];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    // Decide which prototype cell to use for buildings
    UIImage *buildingPhoto = [self.buildingModel buildingImageForIndex:indexPath.row withAllBuildings:self.showingAllBuildings];
    
    if(buildingPhoto != nil) {
        CellIdentifier = @"ImageCell";
    } else {
        CellIdentifier = @"NoImageCell";
    }
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(nil==cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.buildingModel buildingForIndex:indexPath.row withAllBuildings:self.showingAllBuildings];

    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //UITableViewCell *cell = [self.buildingsTable cellForRowAtIndexPath:[self.buildingsTable indexPathForSelectedRow]];
    
    if ([segue.identifier isEqualToString:@"PreferencesSegue"]) {
        BuildingPreferencesViewController *preferencesViewController = segue.destinationViewController;
        preferencesViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
        
    } else if ([segue.identifier isEqualToString:@"InfoSegue"]) {
        BuildingInfoViewController *viewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Building *building = [self.dataSource objectAtIndexPath:indexPath];
        
        viewController.buildingModel = self.buildingModel;
        viewController.selectedBuilding = building.name;
        UIImage *image = [UIImage imageWithData:building.photo];
        viewController.selectedBuildingImage = image;
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
