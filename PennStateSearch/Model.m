//
//  Model.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/3/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "Model.h"

@interface Model ()
@property (nonatomic, strong) RHLDAPSearch *searchURL;
@property (strong, nonatomic)NSArray *searchResult;
@end

@implementation Model

- (id)init {
    self = [super init];
    [self initSearchUrl];
    return self;
}

- (void)initSearchUrl {
    self.searchURL = [[RHLDAPSearch alloc] initWithURL:@"ldap://ldap.psu.edu:389"];
}

- (void)searchWithLast:(NSString*)lastName first:(NSString *)firstName accessId:(NSString*)accessId {
    
    NSError *error = [[NSError alloc] init];
    
    // Construct query to send to ldap
    NSString *query = @"(&";
    
    if([lastName length] > 0) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(sn=%@)", lastName]];
    }
    if([firstName length] > 0) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(givenName=%@*)", firstName]];
    }
    if([accessId length] > 0) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(uid=%@)", accessId]];
    }
    
    query = [query stringByAppendingString:@")"];
                 
    self.searchResult = [self.searchURL searchWithQuery:query withinBase:@"dc=psu,dc=edu" usingScope:RH_LDAP_SCOPE_SUBTREE error: &error];
}


- (NSInteger)numResults {
    return [self.searchResult count];
}

- (NSString *)nameForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *name = [dictionary objectForKey:@"displayName"][0];
    return name;
}

- (NSString *)addressForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *delimitedAddress = [dictionary objectForKey:@"postalAddress"][0];
    
    // Remove $ delimeters from the address
    NSArray *array = [delimitedAddress componentsSeparatedByString:@"$"];
    NSString *address = [array componentsJoinedByString:@" "];
    
    return address;
}

- (NSString *)userIdForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *uid = [dictionary objectForKey:@"uid"][0];
    return uid;
}

- (NSString *)emailForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *email = [dictionary objectForKey:@"psMailID"][0];
    return email;
}


- (NSString *)campusForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *campus = [dictionary objectForKey:@"psCampus"][0];
    return campus;
}

- (NSString *)majorForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *major = [dictionary objectForKey:@"psCurriculum"][0];
    return major;
}

- (NSString *)classForIndex: (NSInteger)index {
    NSDictionary *dictionary = [self.searchResult objectAtIndex:index];
    NSString *class = [dictionary objectForKey:@"title"][0];
    return class;
}


@end
