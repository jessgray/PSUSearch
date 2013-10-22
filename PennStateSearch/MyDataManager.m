//
//  MyDataManager.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/21/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "MyDataManager.h"
#import "DataManager.h"
#import "Building.h"

@implementation MyDataManager

- (NSString *)xcDataModelName {
    return @"Buildings";
}

- (void)createDatabaseFor:(DataManager *)dataManager {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"buildings" ofType:@"plist"];
    NSArray *buildingsArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSManagedObjectContext *managedObjectContext = dataManager.managedObjectContext;
    
    for (NSDictionary *dictionary in buildingsArray) {
        Building *building = [NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:managedObjectContext];
        
        building.name = [dictionary objectForKey:@"name"];
        building.latitude = [dictionary objectForKey:@"latitude"];
        building.longitude = [dictionary objectForKey:@"longitude"];
        building.opp_bldg_code = [dictionary objectForKey:@"opp_bldg_code"];
        building.year_constructed = [dictionary objectForKey:@"year_constructed"];
        NSString *photoName = [NSString stringWithFormat:@"%@.jpg", [dictionary objectForKey:@"photo"]];
        UIImage *photoImage = [UIImage imageNamed:photoName];
        building.photo = UIImageJPEGRepresentation(photoImage, 1.0);
    }
}

@end
