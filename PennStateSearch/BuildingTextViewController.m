//
//  BuildingTextViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/31/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "BuildingTextViewController.h"
#import "BuildingInfoViewController.h"

@interface BuildingTextViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BuildingTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.buildingName;
    
    NSMutableArray *toolbarButtons = [self.navigationItem.rightBarButtonItems mutableCopy];
    [toolbarButtons addObject:self.editButtonItem];
    
    // Either hide or show photo button
    if(self.buildingPhoto == nil) {
        [toolbarButtons removeObject:self.photoButton];
    } else {
        if(![toolbarButtons containsObject:self.photoButton]) {
            [toolbarButtons addObject:self.photoButton];
        }
    }
    [self.navigationItem setRightBarButtonItems:toolbarButtons];
    
    self.textView.text = self.infoString;
    
    // Change color of placeholder text if it exists
    if([self.textView.text isEqualToString:[NSString stringWithFormat:@"Add a description for %@", self.buildingName]]) {
        self.textView.textColor = [UIColor lightGrayColor];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BuildingInfoViewController *viewController = segue.destinationViewController;
    viewController.selectedBuilding = self.buildingName;
    
    UIImage *image = [UIImage imageWithData:self.buildingPhoto];
    viewController.selectedBuildingImage = image;
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (!self.editing) {
        [self.textView resignFirstResponder];
    } else {
        [self.textView becomeFirstResponder];
    }
}


#pragma mark - Notification Handlers
- (void)keyboardWasShown: (NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGRect frame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize keyboardSize = frame.size;
    self.textView.frame = CGRectMake(0.0, 0.0, self.textView.bounds.size.width, (self.textView.frame.size.height + [[self.navigationController navigationBar] frame].size.height) - keyboardSize.height);
    
    // Remove placeholder text
    if([self.textView.text isEqualToString:[NSString stringWithFormat:@"Add a description for %@", self.buildingName]]) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor blackColor];
    }
}

- (void)keyboardWillBeHidden: (NSNotification *)notification {
    self.textView.frame = CGRectMake(0.0, 0.0, self.textView.bounds.size.width, self.view.bounds.size.height);
    
    // Add placeholder text
    if([self.textView.text isEqualToString:@""]) {
        self.textView.text = [NSString stringWithFormat:@"Add a description for %@", self.buildingName];
        self.textView.textColor = [UIColor lightGrayColor];
    }
}

- (void)updateTextView {
    self.textView.text = self.infoString;
}


#pragma mark - TextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if(!self.editing) {
        [self setEditing:YES animated:YES];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.completionBlock(self.textView.text);
}


























@end
