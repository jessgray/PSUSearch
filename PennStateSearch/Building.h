//
//  Building.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/21/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Building : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSValue *latitude;
@property (nonatomic, retain) NSValue *longitude;
@property (nonatomic, retain) NSValue *opp_bldg_code;
@property (nonatomic, retain) NSValue *year_constructed;
@property (nonatomic, retain) NSData *photo;

@end
