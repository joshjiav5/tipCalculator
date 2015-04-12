//
//  User.h
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bill.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *tipSetting;
@property (nonatomic, strong) NSString *maxTipSetting;
@property (nonatomic, strong) NSString *minTipSetting;
@property (nonatomic, strong) NSString *billAmount;
@property (nonatomic, strong) NSString *maxSplitCount;
@property (nonatomic, strong) NSString *timeOutTimeInMinute;
@property (nonatomic, strong) NSNumber *isNumKeyboardOnly;
@property (nonatomic, strong) NSDate *lastActiveDate;
@property (nonatomic) float lastKeyboardHeight;
@property (nonatomic, strong, readonly) Bill *bill;

- (void)calculateBill;
- (void)setTipSettingWithFloat:(float)value;

@end
