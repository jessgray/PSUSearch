//
//  DirectoryViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/2/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@protocol DirectoryDelegete <NSObject> 

-(void)dismissMe;

@end

@interface DirectoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<DirectoryDelegete> delegate;
@property (nonatomic, strong) Model *tableModel;
@end
