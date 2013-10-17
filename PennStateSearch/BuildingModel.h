//
//  BuildingModel.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/9/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingModel : NSObject

- (NSInteger)countwithImages:(BOOL)showOnlyImages;
- (NSString *)buildingForIndex:(NSInteger)index withImages:(BOOL)showOnlyImages;
- (UIImage *)buildingImageForIndex:(NSInteger)index withImages:(BOOL)showOnlyImages;

@end
