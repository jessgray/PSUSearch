//
//  DirectoryViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/2/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()
- (IBAction)dismissPressed:(id)sender;

@end

@implementation DirectoryViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissPressed:(id)sender {
    
    [self.delegate dismissMe];
    
}
@end
