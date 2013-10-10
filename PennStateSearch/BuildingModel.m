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
@end

@implementation BuildingModel

- (id)init {
    self = [super init];
    if(self) {
        if([self fileExists]) {
            NSString *path = [self filePath];
            self.buildings = [NSMutableArray arrayWithContentsOfFile:path];
            
            [self sortByBuildingName];
        } else {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:@"buildings" ofType:@"plist"];
            self.buildings = [NSMutableArray arrayWithContentsOfFile:path];
            [self sortByBuildingName];
            [self.buildings writeToFile:[self filePath] atomically:YES];
        }
    }
    return self;
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

- (NSInteger)count {
    return [self.buildings count];
}

- (NSString *)buildingForIndex:(NSInteger)index {
    NSDictionary *dictionary = [self.buildings objectAtIndex:index];
    NSString *building = [dictionary objectForKey:@"name"];
    return building;
}

- (UIImage *)buildingImageForIndex:(NSInteger)index {
    NSDictionary *dictionary = [self.buildings objectAtIndex:index];
    NSString *buildingPhoto = [dictionary objectForKey:@"photo"];
    if(buildingPhoto.length == 0) {
        return nil;
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:buildingPhoto ofType:@".jpg"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        return image;
    }
}

- (void)sortByBuildingName {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [self.buildings sortUsingDescriptors:@[sortDescriptor]];
}

@end
