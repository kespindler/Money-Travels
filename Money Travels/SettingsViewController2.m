//
//  SettingsViewController2.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/15/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "SettingsViewController2.h"
#import "PaymentObject.h"
#import "PersonObject.h"

@implementation SettingsViewController2

@synthesize people = _people;
@synthesize history = _history;
@synthesize personToDelete = _personToDelete;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"viewcontroller title");
        self.tabBarItem.image = [UIImage imageNamed:@"icn_tabbarsettings.png"];
    }
    return self;
}

- (id)init {
    return [self initWithStyle:UITableViewStyleGrouped];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return SettingsSectionNumSections; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (section == SettingsSectionPeople) rows = self.people.count + 1;
    if (section == SettingsSectionReset) rows = 1;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger section = indexPath.section;
    if (section == SettingsSectionPeople) {
        if (indexPath.row < self.people.count) {
            cell.textLabel.text = [[self.people objectAtIndex:indexPath.row] name];
        } else {
            cell.textLabel.text = NSLocalizedString(@"Add Person", @"cell text");
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
    } else if (section == SettingsSectionReset) {
        cell.textLabel.text = NSLocalizedString(@"Reset", nil);
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canEdit = NO;
    NSInteger section = indexPath.section;
    if (section == SettingsSectionPeople) canEdit = (indexPath.row < self.people.count);
    return canEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.section == SettingsSectionPeople) {        
        self.personToDelete = [self.people objectAtIndex:indexPath.row];
        UIAlertView *alert = [[[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"Delete Person", nil)
                               message:[NSString stringWithFormat:NSLocalizedString(@"Are you sure you want to delete %@? All their data will be cleared from history.", nil), self.personToDelete.name]
                               delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                               otherButtonTitles:NSLocalizedString(@"Yes", nil), nil] autorelease];
        alert.tag = AlertViewTagDeletePerson;
        [alert show];
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    if (section == SettingsSectionPeople) {
        if (indexPath.row == self.people.count) {
            NewPersonViewController *newPersonViewController = [[[NewPersonViewController alloc] init] autorelease];
            newPersonViewController.people = self.people;
            newPersonViewController.addPersonViewControllerDelegate = self;
            UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:newPersonViewController] autorelease];
            [self presentModalViewController:nc animated:YES];        
        }
    } else if (section == SettingsSectionReset) {
        UIAlertView *alert = [[[UIAlertView alloc]
                               initWithTitle:NSLocalizedString(@"Reset", nil)
                               message:NSLocalizedString(@"Are you sure you want to clear all data?", nil)
                               delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                               otherButtonTitles:NSLocalizedString(@"Yes", nil), nil] autorelease];
        alert.tag = AlertViewTagReset;
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    NSInteger tag = alertView.tag;
    if (tag == AlertViewTagDeletePerson) {
        NSMutableIndexSet *paymentsToRemove = [NSMutableIndexSet indexSet];
        NSInteger index = 0;
        for (PaymentObject *p in self.history) {
            if (p.personId == self.personToDelete.personId) {
                [paymentsToRemove addIndex:index];
            }
            index++;
        }
        [self.history removeObjectsAtIndexes:paymentsToRemove];
        [self.people removeObject:self.personToDelete];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SettingsSectionPeople] withRowAnimation:UITableViewRowAnimationNone];
    } else if (tag == AlertViewTagReset) {
        [self.people removeAllObjects];
        [self.history removeAllObjects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SettingsSectionPeople] withRowAnimation:UITableViewRowAnimationNone];
    }
    //TODO: might wnat to save config here.
}

#pragma mark - NewPersonViewControllerDelegate methods
- (void)personWasAdded {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SettingsSectionPeople] withRowAnimation:UITableViewRowAnimationNone];
}



@end
