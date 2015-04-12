//
//  NSNumber+NiceFormatter.h
//  Tip Calc
//
//  Created by JoshJSZ on 4/11/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (NiceFormatter)

- (NSString *)roundedCurrencyString;
- (NSString *)tipPercentageString;

@end
