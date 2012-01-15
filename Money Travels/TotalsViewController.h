//
//  TotalsViewController.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    TotalsSectionsPeople,
    TotalsSectionsDirections,//unused for now.
    TotalsSectionsNumSections,
};

@interface TotalsViewController : UITableViewController

@property (nonatomic, assign) NSArray *people;
@property (nonatomic, assign) NSArray *history;

@end
