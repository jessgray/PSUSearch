//
//  BuildingModel.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/9/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingModel : NSObject

- (NSInteger)count;
- (NSString *)buildingForIndex:(NSInteger)index;
- (UIImage *)buildingImageForIndex:(NSInteger)index;

- (void)sortByBuildingName;
@end
