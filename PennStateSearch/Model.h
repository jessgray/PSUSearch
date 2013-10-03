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
@property (nonatomic, strong) RHLDAPSearch *searchURL;

- (void)searchWithLast:(NSString*)lastName first:(NSString *)firstName accessId:(NSString*)accessId;
- (NSInteger)numResults;
- (NSString *)nameForIndex: (NSInteger)index;
- (NSString *)addressForIndex: (NSInteger)index;
@end