//
//  BuildingModel.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/9/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingModel.h"

static NSString *const filename = @"Buildings.plist";

@interface BuildingModel ()
@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) NSMutableArray *buildingsWithImages;
@end

@implementation BuildingModel

- (id)init {
    self = [super init];
    if(self) {
        if([self fileExists]) {
            NSString *path = [self filePath];
            self.buildings = [NSMutableArray arrayWithContentsOfFile:path];
            [self sortByBuildingName:self.buildings];
            
            [self initBuildingsWithImages];
            [self sortByBuildingName:self.buildingsWithImages];
        } else {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:@"buildings" ofType:@"plist"];
            self.buildings = [NSMutableArray arrayWithContentsOfFile:path];
            [self sortByBuildingName:self.buildings];
            [self.buildings writeToFile:[self filePath] atomically:YES];
            
            [self initBuildingsWithImages];
            [self sortByBuildingName:self.buildingsWithImages];
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

- (NSString *)filePath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:filename];
}

- (BOOL)fileExists {
    NSString *path = [self filePath];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

#pragma mark - Public methods

- (NSInteger)countwithImages:(BOOL)showOnlyImages {
    if(showOnlyImages) {
        return [self.buildingsWithImages count];
    } else {
        return [self.buildings count];
    }
}

- (NSString *)buildingForIndex:(NSInteger)index withImages:(BOOL)showOnlyImages {
    NSDictionary *dictionary;
    
    if(showOnlyImages) {
        dictionary = [self.buildingsWithImages objectAtIndex:index];
    } else {
        dictionary = [self.buildings objectAtIndex:index];
    }
    
    NSString *building = [dictionary objectForKey:@"name"];
    return building;
}

- (UIImage *)buildingImageForIndex:(NSInteger)index withImages:(BOOL)showOnlyImages {
    
    NSDictionary *dictionary;
    
    if(showOnlyImages) {
        dictionary = [self.buildingsWithImages objectAtIndex:index];
    } else {
        dictionary = [self.buildings objectAtIndex:index];
    }
    
    NSString *buildingPhoto = [dictionary objectForKey:@"photo"];
    if(buildingPhoto.length == 0) {
        return nil;
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:buildingPhoto ofType:@".jpg"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        return image;
    }
}

- (void)sortByBuildingName:(NSMutableArray *)buildings {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [buildings sortUsingDescriptors:@[sortDescriptor]];
}

@end
