//
//  BuildingInfo.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/17/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingInfo.h"

@interface BuildingInfo ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *photo;
@end

@implementation BuildingInfo

- (id)initWithName:(NSString *)name photo:(UIImage *)photo {
    self = [super init];
    if (self) {
        _name = name;
        _photo = photo;
    }
    return self;
}

#pragma mark - NSCoding Protocol

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"buildingName"];
        _photo = [aDecoder decodeObjectForKey:@"buildingPhoto"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"buildingName"];
    [aCoder encodeObject:_photo forKey:@"buildingPhoto"];
}

@end
