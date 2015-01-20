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

@property (nonatomic, strong) NSNumber *tipSetting;
@property (nonatomic, strong) NSString *billAmountString;

- (Bill *)getBill:(NSString *)amount;

@end
