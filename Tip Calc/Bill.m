//
//  Bill.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "Bill.h"
#import "NSString+NiceInput.h"

@interface Bill ()

@property (nonatomic, strong, readwrite) NSNumber *billBeforeTip;
@property (nonatomic, strong, readwrite) NSNumber *tipPercentage;
@property (nonatomic, strong, readwrite) NSNumber *tipAmount;
@property (nonatomic, strong, readwrite) NSNumber *billAfterTip;

@end

@implementation Bill

- (id)initWithAmount:(NSString *)amount tipPercentage:(NSString *)tipPercentage {
    self = [super init];
    
    self.billBeforeTip = [[NSNumber alloc] initWithDouble:amount.amountString.doubleValue];
    self.tipPercentage = [[NSNumber alloc] initWithDouble:(tipPercentage.tipPercentageString.doubleValue / 100)];
    
    return self;
}

- (NSNumber *)splitBillWithWays:(NSInteger)ways {
    return [NSNumber numberWithFloat:(self.billAfterTip.floatValue / ways)];
}

#pragma mark - Setter and Getter

- (NSNumber *)checkInitNSNumber:(NSNumber *)num{
    if (!num) {
        num = [[NSNumber alloc] init];
    }
    return num;
}

@synthesize billBeforeTip = _billBeforeTip;
- (void)setBillBeforeTip:(NSNumber *)billBeforeTip {
    _billBeforeTip = billBeforeTip;
}

- (NSNumber *)billBeforeTip {
    return [self checkInitNSNumber:_billBeforeTip];
}

@synthesize tipPercentage = _tipPercentage;
- (void)setTipPercentage:(NSNumber *)tipPercentage {
    _tipPercentage = tipPercentage;
}

- (NSNumber *)tipPercentage {
    return [self checkInitNSNumber:_tipPercentage];
}

@synthesize tipAmount = _tipAmount;
- (void)setTipAmount:(NSNumber *)tipAmount {
    _tipAmount = tipAmount;
}

- (NSNumber *)tipAmount {
    return [[NSNumber alloc] initWithDouble:(self.billBeforeTip.doubleValue * self.tipPercentage.doubleValue)];
}

@synthesize billAfterTip = _billAfterTip;
- (void)setBillAfterTip:(NSNumber *)billAfterTip {
    _billAfterTip = billAfterTip;
}

- (NSNumber *)billAfterTip {
    return [[NSNumber alloc] initWithDouble:(self.billBeforeTip.doubleValue + self.tipAmount.doubleValue)];
}

@end
