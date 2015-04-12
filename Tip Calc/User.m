//
//  User.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "User.h"
#import "NSString+NiceInput.h"
#import "NSNumber+NiceFormatter.h"
#import "Constants.h"

@interface User ()

@property (nonatomic, strong, readwrite) Bill *bill;

@end

@implementation User

- (void)calculateBill {
    self.bill = [[Bill alloc] initWithAmount:self.billAmount tipPercentage:self.tipSetting];
}

- (void)setTipSettingWithFloat:(float)value {
    NSNumber *tipNum = [NSNumber numberWithFloat:value];
    self.tipSetting = [NSString stringWithFormat:@"%ld", (long)tipNum.integerValue];
}

#pragma mark - NSObject Coder

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.maxTipSetting forKey:@"maxTipSetting"];
    [encoder encodeObject:self.minTipSetting forKey:@"minTipSetting"];
    [encoder encodeObject:self.tipSetting forKey:@"tipSetting"];
    [encoder encodeObject:self.billAmount forKey:@"billAmount"];
    [encoder encodeObject:self.lastActiveDate forKey:@"lastActiveDate"];
    [encoder encodeObject:self.timeOutTimeInMinute forKey:@"timeOutTimeInMinute"];
    [encoder encodeObject:self.maxSplitCount forKey:@"maxSplitCount"];
    [encoder encodeObject:self.isNumKeyboardOnly forKey:@"isNumKeyboardOnly"];
    [encoder encodeObject:[NSNumber numberWithFloat:self.lastKeyboardHeight] forKey:@"lastKeyboardHeight"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.tipSetting = [decoder decodeObjectForKey:@"tipSetting"];
        self.maxTipSetting = [decoder decodeObjectForKey:@"maxTipSetting"];
        self.minTipSetting = [decoder decodeObjectForKey:@"minTipSetting"];
        self.billAmount = [decoder decodeObjectForKey:@"billAmount"];
        self.lastActiveDate = [decoder decodeObjectForKey:@"lastActiveDate"];
        self.timeOutTimeInMinute = [decoder decodeObjectForKey:@"timeOutTimeInMinute"];
        self.maxSplitCount = [decoder decodeObjectForKey:@"maxSplitCount"];
        self.isNumKeyboardOnly = [decoder decodeObjectForKey:@"isNumKeyboardOnly"];
        self.lastKeyboardHeight = [(NSNumber *)[decoder decodeObjectForKey:@"lastKeyboardHeight"] floatValue];
    }
    
    return self;
}

#pragma mark - Setter and Getter
- (NSString *)checkInitNSString:(NSString *)str defaultValue:(NSString *)defaultValue{
    if (!str) {
        str = defaultValue;
    }
    return str;
}

@synthesize tipSetting = _tipSetting;
- (NSString *)tipSetting {
    return [self checkInitNSString:_tipSetting defaultValue:kDefaultUserTipPercentageValue];
}

- (void)setTipSetting:(NSString *)tipSetting {
    _tipSetting = tipSetting.tipPercentageString;
}

@synthesize maxTipSetting = _maxTipSetting;
- (NSString *)maxTipSetting {
    return [self checkInitNSString:_maxTipSetting defaultValue:kDefaultMaxTipPercentageValue];
}

- (void)setMaxTipSetting:(NSString *)maxTipSetting {
    _maxTipSetting = maxTipSetting.tipPercentageString;
}

@synthesize minTipSetting = _minTipSetting;
- (NSString *)minTipSetting {
    return [self checkInitNSString:_minTipSetting defaultValue:kDefaultMinTipPercentageValue];
}

- (void)setMinTipSetting:(NSString *)minTipSetting {
    _minTipSetting = minTipSetting.tipPercentageString;
}

@synthesize billAmount = _billAmount;
- (NSString *)billAmount {
    return [self checkInitNSString:_billAmount defaultValue:@""];
}

- (void)setBillAmount:(NSString *)billAmount {
    _billAmount = billAmount.amountString;
}

@synthesize maxSplitCount = _maxSplitCount;
- (NSString *)maxSplitCount {
    return [self checkInitNSString:_maxSplitCount defaultValue:kDefaultMaxSplitCount];
}

- (void)setMaxSplitCount:(NSString *)maxSplitCount {
    _maxSplitCount = maxSplitCount;
}

@synthesize timeOutTimeInMinute = _timeOutTimeInMinute;
- (NSString *)timeOutTimeInMinute {
    return [self checkInitNSString:_timeOutTimeInMinute defaultValue:kDefaultTimeOutMinutes];
}

- (void)setTimeOutTimeInMinute:(NSString *)timeOutTimeInMinute {
    _timeOutTimeInMinute = timeOutTimeInMinute;
}

@synthesize isNumKeyboardOnly = _isNumKeyboardOnly;
- (NSNumber *)isNumKeyboardOnly {
    if (!_isNumKeyboardOnly) {
        _isNumKeyboardOnly = [[NSNumber alloc] initWithBool:YES];
    }
    return _isNumKeyboardOnly;
}

- (void)setIsNumKeyboardOnly:(NSNumber *)isNumKeyboardOnly {
    _isNumKeyboardOnly = isNumKeyboardOnly;
}

@end
