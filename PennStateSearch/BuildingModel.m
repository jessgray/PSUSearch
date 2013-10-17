//
//  BuildingModel.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/9/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingModel.h"
#import "BuildingInfo.h"

static NSString *const filename = @"buildings.archive";
static NSString *const filenameOnlyPhotos = @"buildingsOnlyPhotos.archive";

@interface BuildingModel ()
@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) NSMutableArray *buildingsInfoArray;
@property (nonatomic, strong) NSMutableArray *buildingsWithImages;
@property (nonatomic, strong) NSMutableArray *buildingsWithImagesInfoArray;
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
        if([self filesExist]) {
            // Unarchive buildings array
            NSString *buildingsPath = [self buildingsFilePath];
            self.buildings = [NSKeyedUnarchiver unarchiveObjectWithFile:buildingsPath];
            [self sortByBuildingName:self.buildings];
        
            // Unarchive buildings with images array
            NSString *buildingsOnlyPhotosPath = [self buildingsOnlyImagesFilePath];
            self.buildingsWithImages = [NSKeyedUnarchiver unarchiveObjectWithFile:buildingsOnlyPhotosPath];
            [self sortByBuildingName:self.buildingsWithImages];
        } else {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:@"buildings" ofType:@"plist"];
            
            // Create and archive all buildings array
            self.buildings = [NSMutableArray arrayWithContentsOfFile:path];
            [self sortByBuildingName:self.buildings];
            [self.buildings writeToFile:[self buildingsFilePath] atomically:YES];
            
            _buildingsInfoArray = [NSMutableArray array];
            for (NSDictionary *dict in self.buildings) {
                BuildingInfo *info = [[BuildingInfo alloc] initWithName:dict[@"name"] photo:dict[@"photo"]];
                [_buildingsInfoArray addObject:info];
            }
            
            [NSKeyedArchiver archiveRootObject:_buildingsInfoArray toFile:[self buildingsFilePath]];
            
            
            // Create and archive buildings with images array
            [self initBuildingsWithImages];
            [self sortByBuildingName:self.buildingsWithImages];
            [self.buildingsWithImages writeToFile:[self buildingsOnlyImagesFilePath] atomically:YES];
            
            _buildingsWithImagesInfoArray = [NSMutableArray array];
            for (NSDictionary *dict in self.buildingsWithImages) {
                BuildingInfo *info = [[BuildingInfo alloc] initWithName:dict[@"name"] photo:dict[@"photo"]];
                [_buildingsWithImagesInfoArray addObject:info];
            }
            
            [NSKeyedArchiver archiveRootObject:_buildingsWithImagesInfoArray toFile:[self buildingsOnlyImagesFilePath]];
            
        }
    }
    return self;
}

- (void)initBuildingsWithImages {
    
    self.buildingsWithImages = [[NSMutableArray alloc] init];
    
    for(int i=0; i < [self.buildings count]; i++) {
        NSDictionary *dictionary = [self.buildings objectAtIndex:i];
        NSString *photo = [dictionary objectForKey:@"photo"];
        
        // Add any buildings with photos to the buildings with images array
        if(photo.length > 0) {
            [self.buildingsWithImages addObject:self.buildings[i]];
        }
    }
}

#pragma mark - File System

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)buildingsFilePath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:filename];
}

- (NSString *)buildingsOnlyImagesFilePath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:filenameOnlyPhotos];
}

- (BOOL)filesExist {
    NSString *buildingsPath = [self buildingsFilePath];
    NSString *buildingsOnlyPhotosPath = [self buildingsOnlyImagesFilePath];
    return ([[NSFileManager defaultManager] fileExistsAtPath:buildingsPath] && [[NSFileManager defaultManager] fileExistsAtPath:buildingsOnlyPhotosPath]);
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
    BuildingInfo *info;
    
    if(showAllBuildings) {
        info = [self.buildingsInfoArray objectAtIndex:index];
    } else {
        info = [self.buildingsWithImagesInfoArray objectAtIndex:index];
    }
    
    NSString *building = info.name;
    return building;
}

- (UIImage *)buildingImageForIndex:(NSInteger)index withAllBuildings:(BOOL)showAllBuildings {
    BuildingInfo *info;
    
    if(showAllBuildings) {
        info = [self.buildingsInfoArray objectAtIndex:index];
    } else {
        info = [self.buildingsWithImagesInfoArray objectAtIndex:index];
    }
    
    UIImage *image = info.photo;
    
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
