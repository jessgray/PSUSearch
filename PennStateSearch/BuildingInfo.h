//
//  BuildingInfo.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/17/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingInfo : NSObject <NSCoding>
- (id)initWithName:(NSString *)name photo:(UIImage *)photo;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) UIImage *photo;
@end
