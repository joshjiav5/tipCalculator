//
//  Bill.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "Bill.h"

@implementation Bill

- (NSString *)splitBillWithWays:(int)ways {
    return [self twoDigitStringWithFloat:(self.billAfterTip/(float)ways)];
}

#pragma mark - Helper
- (NSString *)twoDigitStringWithFloat:(float)number {
    return [NSString stringWithFormat:@"%.02f", (round( number * 100.0 ) / 100.0)];
}
@end
