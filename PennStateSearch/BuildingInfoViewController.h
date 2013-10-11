//
//  BuildingInfoViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/10/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingModel.h"

@interface BuildingInfoViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, strong) BuildingModel *buildingModel;

@property (nonatomic, strong) NSString *selectedBuilding;
@property (nonatomic, strong) UIImage *selectedBuildingImage;
@end
