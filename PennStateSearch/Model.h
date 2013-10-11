//
//  Model.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/3/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHLDAPSearch.h"

@interface Model : NSObject

- (void)searchWithLast:(NSString*)lastName first:(NSString *)firstName accessId:(NSString*)accessId;
- (NSInteger)numResults;
- (NSString *)nameForIndex: (NSInteger)index;
- (NSString *)addressForIndex: (NSInteger)index;
- (NSString *)userIdForIndex: (NSInteger)index;
- (NSString *)emailForIndex: (NSInteger)index;
- (NSString *)campusForIndex: (NSInteger)index;
- (NSString *)majorForIndex: (NSInteger)index;
- (NSString *)classForIndex: (NSInteger)index;

@property NSInteger selectedIndex;
@end
