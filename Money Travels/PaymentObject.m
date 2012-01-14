//
//  PaymentObject.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "PaymentObject.h"

@implementation PaymentObject

@synthesize amount;
@synthesize person;

+ (PaymentObject *)paymentObjectWithAmount:(CGFloat)theAmount fromPerson:(PersonObject *)fromPerson {
    PaymentObject *paymentObject = [[[[self class] alloc] init] autorelease];
    paymentObject.amount = theAmount;
    paymentObject.person = fromPerson;
    return paymentObject;
}

@end
