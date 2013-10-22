//
//  Building+Name.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/22/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "Building+Name.h"

@implementation Building (Name)

- (NSString *)firstLetterOfName {
    NSString *letter = [self.name substringToIndex:1];
    return letter;
}

@end
