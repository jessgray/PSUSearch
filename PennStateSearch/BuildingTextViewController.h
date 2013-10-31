//
//  BuildingTextViewController.h
//  PennStateSearch
//
//  Created by Jessica Smith on 10/31/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingTextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, strong) NSString *buildingName;
@property (nonatomic, strong) NSData *buildingPhoto;

@property (nonatomic, copy) CompletionBlock completionBlock;

- (void)updateTextView;
@end
