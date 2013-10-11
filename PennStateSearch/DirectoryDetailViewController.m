//
//  DirectoryDetailViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/10/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "DirectoryDetailViewController.h"

@interface DirectoryDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *userIdCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *campusCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *majorCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *classCell;

@end

@implementation DirectoryDetailViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = [self.model nameForIndex:self.selectedIndex];
    
    [self populateTableCells];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)populateTableCells {
    
    NSInteger index = self.selectedIndex;
    
    self.userIdCell.textLabel.text = [self.model userIdForIndex:index];
    self.emailCell.textLabel.text = [self.model emailForIndex:index];
    self.addressCell.textLabel.text = [self.model addressForIndex:index];
    self.campusCell.textLabel.text = [self.model campusForIndex:index];
    self.majorCell.textLabel.text = [self.model majorForIndex:index];
    self.classCell.textLabel.text = [self.model classForIndex:index];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
