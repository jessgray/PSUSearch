//
//  DirectoryDetailViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/10/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface DirectoryDetailViewController : UITableViewController
@property (nonatomic, strong)Model *model;
@property NSInteger selectedIndex;
@end
