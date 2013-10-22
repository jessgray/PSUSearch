//
//  BuildingModel.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/9/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingModel.h"
#import "BuildingInfo.h"
#import "DataManager.h"
#import "MyDataManager.h"
#import "Building.h"


@interface BuildingModel ()
@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) NSMutableArray *buildingsWithImages;
@end

@implementation BuildingModel

+ (id)sharedInstance {
    static id singleton = nil;
    if (!singleton) {
        singleton = [[self alloc] init];
    }
    return singleton;
}

- (id)init {
    self = [super init];
    if(self) {
        DataManager *dataManager = [DataManager sharedInstance];
        MyDataManager *myDataManager = [[MyDataManager alloc] init];
        dataManager.delegate = myDataManager;
        
        NSArray *results = [dataManager fetchManagedObjectsForEntity:@"Building" sortKeys:@[@"name"] predicate:nil];
        
        self.buildings = [results mutableCopy];
        [self sortByBuildingName:self.buildings];
        
        [self initBuildingsWithImages];
        [self sortByBuildingName:self.buildingsWithImages];
    }
    return self;
}

- (void)initBuildingsWithImages {
    
    self.buildingsWithImages = [[NSMutableArray alloc] init];
    
    for(int i=0; i < [self.buildings count]; i++) {
        UIImage *image = [self buildingImageForIndex:i withAllBuildings:YES];
        
        // Add any buildings with photos to the buildings with images array
        if(image != nil) {
            [self.buildingsWithImages addObject:self.buildings[i]];
        }
    }
}

#pragma mark - Public methods

- (NSInteger)countForBuildings:(BOOL)showAllBuildings {
    if(showAllBuildings) {
        return [self.buildings count];
    } else {
        return [self.buildingsWithImages count];
    }
}

- (NSString *)buildingForIndex:(NSInteger)index withAllBuildings:(BOOL)showAllBuildings {
    Building *building;
    
    if(showAllBuildings) {
        building = [self.buildings objectAtIndex:index];
    } else {
        building = [self.buildingsWithImages objectAtIndex:index];
    }
    
    return building.name;
}

- (UIImage *)buildingImageForIndex:(NSInteger)index withAllBuildings:(BOOL)showAllBuildings {
    Building *building;
    
    if(showAllBuildings) {
        building = [self.buildings objectAtIndex:index];
    } else {
        building = [self.buildingsWithImages objectAtIndex:index];
    }
    
    UIImage *image = [[UIImage alloc] initWithData:building.photo];
    
    // Check if there is an actual image or if the image doesn't exist
    CGImageRef cgref = [image CGImage];
    CIImage *cim = [image CIImage];
    if(cim == nil && cgref == NULL) {
        return nil;
    } else {
        return image;
    }
}

- (void)sortByBuildingName:(NSMutableArray *)buildings {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [buildings sortUsingDescriptors:@[sortDescriptor]];
}

@end
