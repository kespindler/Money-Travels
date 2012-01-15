//
//  NewPersonViewController.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "NewPersonViewController.h"
#import "PersonObject.h"
#import "AppDelegate.h"

@implementation NewPersonViewController
@synthesize people;
@synthesize addPersonNameTextField;
@synthesize addPersonViewControllerDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.prompt = NSLocalizedString(@"Enter the name of the person you'd like to add.", @"navigation item prompt");
        UIBarButtonItem *btn;
        btn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)] autorelease];
        self.navigationItem.rightBarButtonItem = btn;
        btn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)] autorelease];
        self.navigationItem.leftBarButtonItem = btn;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)addButtonPressed {
    if (addPersonNameTextField.text.length) {
        AppDelegate *ad = [UIApplication sharedApplication].delegate;
        [self.people addObject:[ad newPersonWithName:addPersonNameTextField.text]];
        [ad saveData];
    }
    [addPersonViewControllerDelegate personWasAdded];
}

- (void)cancelButtonPressed {
    self.addPersonNameTextField.text = @"";
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.addPersonNameTextField = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [addPersonNameTextField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
   [addPersonNameTextField release];
   [super dealloc];
}


@end
