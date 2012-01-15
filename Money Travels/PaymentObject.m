//
//  PaymentObject.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "PaymentObject.h"

#define EncodingKeyPersonId @"PaymentObjectCoderKeyPersonId"
#define EncodingKeyAmount @"PaymentObjectCoderKeyAmount"

@implementation PaymentObject

@synthesize amount = _amount;
@synthesize personId = _personId;

+ (PaymentObject *)paymentObjectWithAmount:(CGFloat)theAmount fromPerson:(PersonObject *)fromPerson {
    PaymentObject *paymentObject = [[[[self class] alloc] init] autorelease];
    paymentObject.amount = theAmount;
    paymentObject.personId = fromPerson.personId;
    return paymentObject;
}

#pragma mark - NSCoding methods
- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.amount = [coder decodeIntegerForKey:EncodingKeyAmount];
    self.personId = [coder decodeIntegerForKey:EncodingKeyPersonId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInteger:self.personId forKey:EncodingKeyPersonId];
    [coder encodeInteger:self.amount forKey:EncodingKeyAmount];
}


@end
