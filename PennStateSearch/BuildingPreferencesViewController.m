//
//  BuildingPreferencesViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/17/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingPreferencesViewController.h"
#import "Constants.h"

@interface BuildingPreferencesViewController ()
- (IBAction)dismiss:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *zoomPhotosCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *showAllBuildingsCell;
@property (weak, nonatomic) IBOutlet UISwitch *zoomPhotosSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *showAllBuildingsSwitch;

@end

@implementation BuildingPreferencesViewController

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
    
    // Show user preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *zoomBool = [preferences objectForKey:kZoomablePhotos];
    NSNumber *showBuildingsBool = [preferences objectForKey:kShowAllBuildings];
    
    self.zoomPhotosSwitch.on = [zoomBool boolValue];
    self.showAllBuildingsSwitch.on = [showBuildingsBool boolValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Add titles/subtitles to static table cells
    //self.zoomPhotosCell.textLabel.text = @"Zoomable Photos";
    //self.zoomPhotosCell.detailTextLabel.text = @"Enables photo zooming";
    
    //self.showAllBuildingsCell.textLabel.text = @"Show All Buildings";
    //self.showAllBuildingsCell.detailTextLabel.text = @"Shows all buildings with/without photos";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)dismiss:(id)sender {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:self.zoomPhotosSwitch.isOn forKey:kZoomablePhotos];
    [preferences setBool:self.showAllBuildingsSwitch.isOn forKey:kShowAllBuildings];
    [preferences synchronize];
    
    self.CompletionBlock();
}
@end
