//
//  NSNumber+NiceFormatter.m
//  Tip Calc
//
//  Created by JoshJSZ on 4/11/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "NSNumber+NiceFormatter.h"

@implementation NSNumber (NiceFormatter)

- (NSString *)roundedCurrencyString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    numberFormatter.locale = [NSLocale currentLocale];
    return [numberFormatter stringFromNumber:self];
}

- (NSString *)tipPercentageString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    numberFormatter.locale = [NSLocale currentLocale];
    return [numberFormatter stringFromNumber:self];
}

@end
