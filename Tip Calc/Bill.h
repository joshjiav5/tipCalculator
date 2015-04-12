//
//  Bill.h
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bill : NSObject

@property (nonatomic, strong, readonly) NSNumber *billBeforeTip;
@property (nonatomic, strong, readonly) NSNumber *tipPercentage;
@property (nonatomic, strong, readonly) NSNumber *tipAmount;
@property (nonatomic, strong, readonly) NSNumber *billAfterTip;

- (id)initWithAmount:(NSString *)amount tipPercentage:(NSString *)tipPercentage;
- (NSNumber *)splitBillWithWays:(NSInteger)ways;

@end
