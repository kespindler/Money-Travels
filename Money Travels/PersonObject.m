//
//  PersonObject.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "PersonObject.h"

@implementation PersonObject

@synthesize name;

+ (PersonObject *)personWithName:(NSString *)newPersonName {
    PersonObject *pers = [[[self alloc] init] autorelease];
    pers.name = newPersonName;
    return pers;
}

- (void)dealloc {
    [name release];
    [super dealloc];
}

@end
