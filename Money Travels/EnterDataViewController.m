//
//  EnterDataViewController.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "EnterDataViewController.h"
#import "PersonObject.h"
#import "PaymentObject.h"

@implementation EnterDataViewController

@synthesize people;
@synthesize history;
@synthesize peopleTableView;
@synthesize amountTextField;
@synthesize boughtOrPaidSegmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Payment", @"viewcontroller title");
        self.tabBarItem.image = [UIImage imageNamed:@"icn_tabbaradd.png"];
//        self.navigationItem.prompt = NSLocalizedString(@"Select the person, whether that person bought or paid an amount, and the amount (in dollars)", nil);
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPeopleTableView:nil];
    [self setAmountTextField:nil];
    [self setBoughtOrPaidSegmentedControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [peopleTableView reloadData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    UIBarButtonItem *i1 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)] autorelease];
    [toolbar setItems:[NSArray arrayWithObjects:i1, nil]];
    textField.inputAccessoryView = toolbar;
}
#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[people objectAtIndex:indexPath.row] name];
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc {
    [peopleTableView release];
    [amountTextField release];
    [boughtOrPaidSegmentedControl release];
    [super dealloc];
}

- (IBAction)submitButtonPressed:(id)sender {
    CGFloat amount = [self.amountTextField.text floatValue];
    if (self.boughtOrPaidSegmentedControl.selectedSegmentIndex == BoughtOrPaidValueBought) {
        amount *= -1;
    }
    PersonObject *person = [self.people objectAtIndex:[self.peopleTableView indexPathForSelectedRow].row];
    PaymentObject *payment = [PaymentObject paymentObjectWithAmount:amount fromPerson:person];
    [self.history addObject:payment];
    self.amountTextField.text = @"";
}

@end
