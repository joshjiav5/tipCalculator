//
//  NSString+NiceInput.m
//  Tip Calc
//
//  Created by JoshJSZ on 4/11/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "NSString+NiceInput.h"

@implementation NSString (NiceInput)

- (NSString *)amountString {
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}

- (NSString *)tipPercentageString {
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}


@end
