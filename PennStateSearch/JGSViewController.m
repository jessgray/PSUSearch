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

- (IBAction)searchPressed:(id)sender;

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


- (IBAction)searchPressed:(id)sender {
    
    NSString *first, *last, *accessId;
    
    first = [self.firstNameTextField text];
    last = [self.lastNameTextField text];
    accessId = [self.accessIdTextField text];
    
    [self.model searchWithLast:last first:first accessId:accessId];
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

#pragma mark - Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numResults];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil==cell) {  // this step not needed for prototype cells
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.model nameForIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model addressForIndex:indexPath.row];
    
    return cell;
}
    
@end
