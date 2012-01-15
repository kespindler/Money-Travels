//
//  HelpViewController.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "HelpViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Help", @"viewcontroller title");
        self.tabBarItem.image = [UIImage imageNamed:@"icn_tabbarhelp.png"];
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
    for (UIView *s in self.view.subviews) {
        if ([s isKindOfClass:UILabel.class]) {
            s.layer.cornerRadius = 3.0f;
            s.layer.shadowOpacity = 0.6f;
            s.layer.shadowRadius = 3.0f;
            s.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        }
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
