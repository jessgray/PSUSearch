//
//  JGSViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/2/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "JGSViewController.h"
#import "DirectoryViewController.h"
#import "Model.h"

#define kKeyboardHeight 216

@interface JGSViewController () <DirectoryDelegete>
@property (strong, nonatomic) IBOutlet UIScrollView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accessIdTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;

- (IBAction)searchPressed:(id)sender;
- (IBAction)changeView:(id)sender;

@end

@implementation JGSViewController 

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _model = [[Model alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Penn State Directory Search";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Clear text values
    [self.firstNameTextField setText:@""];
    [self.lastNameTextField setText:@""];
    [self.accessIdTextField setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // Close the keyboard
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if([textField.placeholder isEqualToString:@"Last Name"]) {
        [self textFieldsCorrect:YES];
    }
    if([textField.placeholder isEqualToString:@"Access ID"]) {
        [self textFieldsCorrect:YES];
    }
    
    // Only set content offset if the keyboard will obscure the textField
    if (textField.frame.origin.y+textField.frame.size.height > self.view.frame.size.height - kKeyboardHeight) {
        [self.mainView setContentOffset:(CGPoint){self.mainView.contentInset.bottom, kKeyboardHeight} animated:YES];
    }
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if([textField.placeholder isEqualToString:@"First Name"] && (self.lastNameTextField.text.length == 0 && self.accessIdTextField.text.length == 0)) {
        [self textFieldsCorrect:NO];
    }
    if([textField.placeholder isEqualToString:@"Last Name"] && (self.lastNameTextField.text.length == 0 && self.accessIdTextField.text.length == 0)) {
        [self textFieldsCorrect:NO];
    }
    
    if([textField.placeholder isEqualToString:@"Access ID"] && (self.lastNameTextField.text.length == 0 && self.accessIdTextField.text.length == 0)) {
        [self textFieldsCorrect:NO];
    }
    
    // Only reset content offset if the keyboard was obscuring the textField
    if (textField.frame.origin.y+textField.frame.size.height > self.view.frame.size.height - kKeyboardHeight) {
        [self.mainView setContentOffset:(CGPoint){0, 0} animated:YES];
    }
    
    
}

- (void)textFieldsCorrect:(BOOL)correct {
    
    [self.errorMessage setText:@"You must provide at least a last name or access id!"];
    self.errorMessage.hidden = correct;
    
    UIColor *wrongColor = [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
    
    if(correct) {
        self.firstNameTextField.backgroundColor = [UIColor whiteColor];
        self.lastNameTextField.backgroundColor = [UIColor whiteColor];
        self.accessIdTextField.backgroundColor = [UIColor whiteColor];
    } else {
        self.lastNameTextField.backgroundColor = wrongColor;
        self.accessIdTextField.backgroundColor = wrongColor;
    }
}


- (IBAction)searchPressed:(id)sender {
    
    NSString *first, *last, *accessId;
    
    first = [self.firstNameTextField text];
    last = [self.lastNameTextField text];
    accessId = [self.accessIdTextField text];
    
    if(last.length == 0 && accessId.length == 0) {
        [self textFieldsCorrect:NO];
    } else {
        [self.model searchWithLast:last first:first accessId:accessId];
    }
    
}

- (IBAction)changeView:(id)sender {
    UISegmentedControl *segmentedControl = sender;
    NSInteger choice = segmentedControl.selectedSegmentIndex;
    if (choice == 0) {
        
    } else {
        
    }
    
}

#pragma mark - Delegate

-(void)dismissMe {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"DirectorySegue"]) {
        DirectoryViewController *directoryViewController = segue.destinationViewController;
        directoryViewController.delegate = self;
        directoryViewController.tableModel = self.model;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if(self.lastNameTextField.text.length == 0 && self.accessIdTextField.text.length == 0) {
        return NO;
    } else {
        return YES;
    }
}
    
@end
