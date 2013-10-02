//
//  DirectoryViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/2/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DirectoryDelegete <NSObject>

-(void)dismissMe;

@end

@interface DirectoryViewController : UIViewController
@property (nonatomic, assign) id<DirectoryDelegete> delegate;
@end
