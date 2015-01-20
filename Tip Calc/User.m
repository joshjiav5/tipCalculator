//
//  User.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

- (Bill *)getBill:(NSString *)amount {
    Bill *bill = [[Bill  alloc] init];
    self.billAmountString = amount;
    
    bill.billBeforeTip = [amount floatValue];
    bill.tip = [amount floatValue] * [self getRealTipPercentage:self.tipSetting];
    bill.billAfterTip = bill.billBeforeTip + bill.tip;
    
    return bill;
}

#pragma mark - Helper
- (float)getRealTipPercentage:(NSNumber *)number {
    return ([number integerValue]/100.0);
}

#pragma mark - NSObject Coder

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.tipSetting forKey:@"tipSetting"];
    [encoder encodeObject:self.billAmountString forKey:@"billAmountString"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.tipSetting = [decoder decodeObjectForKey:@"tipSetting"];
        NSString *tmpString = [decoder decodeObjectForKey:@"billAmountString"];
        if (tmpString.length) {
            self.billAmountString = [NSString stringWithFormat:@"%@", tmpString];
        }
    }
    
    return self;
}

#pragma mark - Setter and Getter
//Setter and getter for tipSetting
//Tip amount will init to 15 by default
@synthesize tipSetting = _tipSetting;
- (NSNumber *)tipSetting {
    if (!_tipSetting) {
        _tipSetting = [[NSNumber alloc] initWithInteger:15];
    }
    return _tipSetting;
}

- (void)setTipSetting:(NSNumber *)tipSetting {
    if (!_tipSetting) {
        _tipSetting = [[NSNumber alloc] init];
    }
    
    _tipSetting = tipSetting;
}

@end
