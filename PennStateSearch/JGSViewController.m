//
//  JGSViewController.m
//  PennStateSearch
//
//  Created by Jessica Smith on 10/2/13.
//  Copyright (c) 2013 Jessica Smith. All rights reserved.
//

#import "JGSViewController.h"
#import "DirectoryViewController.h"

#define kKeyboardHeight 216

@interface JGSViewController () <DirectoryDelegete>
@property (strong, nonatomic) IBOutlet UIScrollView *mainView;


@end

@implementation JGSViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    
    // Only set content offset if the keyboard will obscure the textField
    if (textField.frame.origin.y+textField.frame.size.height > self.view.frame.size.height - kKeyboardHeight) {
        [self.mainView setContentOffset:(CGPoint){self.mainView.contentInset.bottom, kKeyboardHeight} animated:YES];
    }
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    // Only reset content offset if the keyboard was obscuring the textField
    if (textField.frame.origin.y+textField.frame.size.height > self.view.frame.size.height - kKeyboardHeight) {
        [self.mainView setContentOffset:(CGPoint){0, 0} animated:YES];
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
    }
}

@end
