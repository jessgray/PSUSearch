//
//  BuildingPreferencesViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/17/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingPreferencesViewController : UITableViewController
@property (nonatomic, copy) void (^CompletionBlock)(void);
@end
