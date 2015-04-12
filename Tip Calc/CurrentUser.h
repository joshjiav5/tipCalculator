//
//  CurrentUser.h
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CurrentUser : NSObject

+ (User *)currentUser;
+ (void)saveCurrentUser;
+ (void)loadCurrentUserWithTimeCheck;
+ (void)loadCurrentUserWithoutTimeCheck;

@end
