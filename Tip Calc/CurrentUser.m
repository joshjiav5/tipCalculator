//
//  CurrentUser.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "CurrentUser.h"
#import "Constants.h"

@implementation CurrentUser

static User *_currentUser;

+ (User *)currentUser {
    if (!_currentUser) {
        _currentUser = [[User alloc] init];
    }
    return _currentUser;
}

+ (void)saveCurrentUser {
    _currentUser.lastActiveDate = [[NSDate alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:[self currentUser]];
    [defaults setObject:encodedObject forKey:kDefaultUserID];
    [defaults synchronize];
}

+ (User *)loadCurrentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kDefaultUserID];
    if (encodedObject) {
        id userObj = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        if ([userObj isKindOfClass:[User class]]) {
            return userObj;
        }
    }
    
    return nil;
}

+ (void)loadCurrentUserWithoutTimeCheck {
    _currentUser = [self loadCurrentUser];
}

+ (void)loadCurrentUserWithTimeCheck {
    User *tmpUser = [self loadCurrentUser];
    if (![self timeCheckUserLastActive:tmpUser.lastActiveDate timeOut:tmpUser.timeOutTimeInMinute]) {
        tmpUser.billAmount = @"0";
    }
    _currentUser = tmpUser;
}

+ (BOOL)timeCheckUserLastActive:(NSDate *)lastActiveDate timeOut:(NSString *)timeOutTimeInMinute {
    NSDate *now = [[NSDate alloc] init];
    NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:lastActiveDate];
    double secondsInAMinute = 60;
    double minutesBetweenDates = distanceBetweenDates / secondsInAMinute;
    
    if (minutesBetweenDates < timeOutTimeInMinute.doubleValue) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
