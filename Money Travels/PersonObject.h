//
//  PersonObject.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonObject : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger personId;

+ (PersonObject *)personWithName:(NSString *)newPersonName personId:(NSInteger)personId;

@end
