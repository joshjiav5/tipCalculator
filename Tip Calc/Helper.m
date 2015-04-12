//
//  Helper.m
//  Tip Calc
//
//  Created by JoshJSZ on 4/12/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (NSString *)getLocalCurrencySymbol {
    NSNumberFormatter *fmtr = [[NSNumberFormatter alloc] init];
    fmtr.numberStyle = NSNumberFormatterCurrencyStyle;
    fmtr.locale = [NSLocale currentLocale];
    
    return [fmtr currencySymbol];
}

@end
