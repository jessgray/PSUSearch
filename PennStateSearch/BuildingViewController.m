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
#import "BuildingTextViewController.h"
#import "BuildingPreferencesViewController.h"
#import "Constants.h"
#import "DataSource.h"
#import "MyDataManager.h"
#import "DataManager.h"
#import "Building.h"
#import "AddBuildingTableViewController.h"

static NSString * const kTitle = @"Campus Buildings";

@interface BuildingViewController ()
@property (strong, nonatomic) IBOutlet UITableView *buildingsTable;

@property (nonatomic, strong) BuildingModel *buildingModel;
@property (nonatomic, strong) NSString *selectedBuilding;
@property (nonatomic, strong) UIImage *selectedBuildingImage;
@property (nonatomic, assign) BOOL showingAllBuildings;
@property (nonatomic, strong) DataSource *dataSource;
@property (nonatomic, strong) MyDataManager *myDataManager;

// Search bar info
@property (nonatomic,strong) NSString *searchString;
@property NSInteger searchOption;

@end

@implementation BuildingViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        //_buildingModel = [[BuildingModel alloc] init];
        _myDataManager = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:@"firstLetterOfName" dataManagerDelegate:_myDataManager];
        
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
    self.dataSource.tableView = self.tableView;
    
    self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem, self.editButtonItem];
    
    // The following 3 lines of code support the Search Display Controller
    // the Search Display Controller will use the same data source
    self.searchDisplayController.searchResultsDataSource = self.dataSource;
    
    // set the scope buttons
    self.searchDisplayController.searchBar.scopeButtonTitles = @[@"All", @"One Word", @"Two Words"];
    
    // hide search bar
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *showAllBuildings = [preferences objectForKey:kShowAllBuildings];
    self.showingAllBuildings = [showAllBuildings boolValue];
    
    // Reload tableview with correct buildings
    NSPredicate *predicate;
    
    if(!self.showingAllBuildings){
        predicate = [NSPredicate predicateWithFormat:@"photo != nil"];
    } else {
        predicate = nil;
    }
    
    [_dataSource updateWithPredicate:predicate];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Editing Table View
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if(editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

#pragma mark - Data Source Cell Configurer
- (NSString*)cellIdentifierForObject:(id)object {
    return @"Cell";
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    Building *building = object;
    
    cell.textLabel.text = building.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //UITableViewCell *cell = [self.buildingsTable cellForRowAtIndexPath:[self.buildingsTable indexPathForSelectedRow]];
    
    if ([segue.identifier isEqualToString:@"PreferencesSegue"]) {
        BuildingPreferencesViewController *preferencesViewController = segue.destinationViewController;
        preferencesViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
        
    } else if ([segue.identifier isEqualToString:@"InfoSegue"]) {
        BuildingTextViewController *viewController = segue.destinationViewController;
        
        // Use dataSource tableview since it will always be the current one
        NSIndexPath *indexPath = [self.dataSource.tableView indexPathForSelectedRow];
        __block Building *building = [self.dataSource objectAtIndexPath:indexPath];

        viewController.buildingName = building.name;
        viewController.buildingPhoto = building.photo;
        viewController.infoString = building.info;
        viewController.completionBlock = ^(id obj) {
            if([obj isKindOfClass:[NSString class]]) {
                NSString *newInfo = obj;
                building.info = newInfo;
            } else {
                NSData *newPhoto = obj;
                building.photo = newPhoto;
            }
            [[DataManager sharedInstance] saveContext];
        };
    } else if ([segue.identifier isEqualToString:@"AddBuildingSegue"]) {
        AddBuildingTableViewController *addBuildingViewController = segue.destinationViewController;
        addBuildingViewController.completionBlock = ^(id obj) {
            [self dismissViewControllerAnimated:YES completion:NULL];
            if (obj) {
                NSDictionary *dictionary = obj;
                [self.myDataManager addBuilding:dictionary];
            }
        };
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier:@"InfoSegue" sender:nil];
    }
    
}

#pragma mark - Search Display Controller Delegate Methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    // remember the current search string and filter the search results
    self.searchString = searchString;
    [self filterSearch];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // remember the current search option and filter the search results
    self.searchOption = searchOption;
    [self filterSearch];
    return YES;
}

// construct the appropriate predicate based on the search string and search option (scope)
// then update data source using predicate
-(void)filterSearch {
    
    NSString *searchPredicateString;
    if (self.searchString.length>0) {
        searchPredicateString = [NSString stringWithFormat:@"name contains '%@'", self.searchString];
    } else {
        searchPredicateString = @"name contains ''";
    }
    
    NSString *search;
    switch (self.searchOption) {
        case 0:
            search = searchPredicateString;
            break;
        case 1:
            search = [NSString stringWithFormat:@"%@ && !(name contains ' ')", searchPredicateString];
            break;
        default:
            search = [NSString stringWithFormat:@"%@ && (name contains ' ')", searchPredicateString];
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:search];
    [self.dataSource updateWithPredicate:predicate];
    
}

// when we begin searching we switch tableViews
-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    self.dataSource.tableView = controller.searchResultsTableView;
}

// when we end searching we switch tableViews back to default
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    self.dataSource.tableView = self.tableView;
}

#pragma mark - Search Bar Delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.dataSource updateWithPredicate:nil];
    [self.tableView reloadData];
}


@end
