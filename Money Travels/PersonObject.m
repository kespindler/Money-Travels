//
//  PersonObject.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "PersonObject.h"

#define CoderKeyPersonName @"PersonObjectCoderKeyPersonName"
#define CoderKeyPersonId @"PersonObjectCoderKeyPersonId"

@implementation PersonObject

@synthesize name = _name;
@synthesize personId = _personId;

+ (PersonObject *)personWithName:(NSString *)newPersonName personId:(NSInteger)personId {
    PersonObject *pers = [[[self alloc] init] autorelease];
    pers.name = newPersonName;
    pers.personId = personId;
    return pers;
}

#pragma mark - NSCoding methods 
- (id)initWithCoder:(NSCoder *)coder { 
    self = [self init];
    self.name = [coder decodeObjectForKey:CoderKeyPersonName];
    self.personId = [coder decodeIntegerForKey:CoderKeyPersonId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:CoderKeyPersonName];
    [coder encodeInteger:self.personId forKey:CoderKeyPersonId];
}

- (void)dealloc {
    [_name release];
    [super dealloc];
}

@end
