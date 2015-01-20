//
//  Bill.h
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bill : NSObject

@property (nonatomic) float billBeforeTip;
@property (nonatomic) float tip;
@property (nonatomic) float billAfterTip;

- (NSString *)splitBillWithWays:(int)ways;
- (NSString *)twoDigitStringWithFloat:(float)number;

@end
