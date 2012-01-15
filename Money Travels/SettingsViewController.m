//
//  SettingsViewController.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController


@synthesize people;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"viewcontroller title");
        self.tabBarItem.image = [UIImage imageNamed:@"icn_tabbarsettings.png"];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.peopleTableView) {
        return people.count + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier] autorelease];
    }
    if (indexPath.row < people.count) {
        cell.textLabel.text = [[people objectAtIndex:indexPath.row] name];
    } else {
        cell.textLabel.text = NSLocalizedString(@"Add Person", @"cell text");
    }
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row < people.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == people.count) {
        NewPersonViewController *newPersonViewController = [[[NewPersonViewController alloc] init] autorelease];
        newPersonViewController.people = self.people;
        newPersonViewController.addPersonViewControllerDelegate = self;
        UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:newPersonViewController] autorelease];
        [self presentModalViewController:nc animated:YES];        
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [people removeObjectAtIndex:indexPath.row];
    [peopleTableView reloadData];
}

- (void)dealloc {
    [peopleTableView release];
    [super dealloc];
}

- (IBAction)resetButtonPressed:(id)sender {
    [people removeAllObjects];
    [peopleTableView reloadData];
}

- (void)personWasAdded {
    [self dismissViewControllerAnimated:YES completion:nil];
    [peopleTableView reloadData];
}

@end
