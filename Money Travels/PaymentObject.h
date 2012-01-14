//
//  PaymentObject.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonObject.h"

@interface PaymentObject : NSObject

@property (nonatomic) CGFloat amount;
@property (nonatomic, assign) PersonObject *person;

+ (PaymentObject *)paymentObjectWithAmount:(CGFloat)theAmount fromPerson:(PersonObject *)fromPerson;
@end
