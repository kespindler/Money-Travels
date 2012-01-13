//
//  PersonObject.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonObject : NSObject

@property (nonatomic, copy) NSString *name;

+ (PersonObject *)personWithName:(NSString *)newPersonName;

@end
