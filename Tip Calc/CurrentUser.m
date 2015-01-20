//
//  CurrentUser.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "CurrentUser.h"
#import "TipCalcConst.h"

@implementation CurrentUser

static User *_currentUser;

+ (User *)currentUser {
    if (!_currentUser) {
        _currentUser = [[User alloc] init];
    }
    return _currentUser;
}

+ (void)saveCurrentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:[self currentUser]];
    [defaults setObject:encodedObject forKey:kTipCalcDefaultUserKey];
    [defaults synchronize];
}

+ (void)loadCurrentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kTipCalcDefaultUserKey];
    if (encodedObject) {
        _currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    }
}

@end
