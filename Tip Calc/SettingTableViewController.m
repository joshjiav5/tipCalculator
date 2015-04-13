//
//  SettingTableViewController.m
//  Tip Calc
//
//  Created by JoshJSZ on 4/12/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "SettingTableViewController.h"
#import "CurrentUser.h"
#import "Constants.h"

@interface SettingTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *defaultTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *minTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeOutTextField;
@property (weak, nonatomic) IBOutlet UISwitch *useNumKeyOnlySwitch;
@property (weak, nonatomic) IBOutlet UITextField *divideBillWithWaysTextField;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [CurrentUser currentUser];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViewStyle];
    [self fillViewWithData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSString *tip = self.defaultTipTextField.text;
    NSString *max = self.maxTipTextField.text;
    NSString *min = self.minTipTextField.text;
    
    if ([self isTipSettingValid:tip max:max min:min]) {
        self.user.tipSetting = tip.integerValue?tip:kDefaultUserTipPercentageValue;
        self.user.maxTipSetting = max.integerValue?max:kDefaultMaxTipPercentageValue;
        self.user.minTipSetting = min.integerValue?min:kDefaultMinTipPercentageValue;
    }
    
    self.user.maxSplitCount = self.divideBillWithWaysTextField.text.integerValue?self.divideBillWithWaysTextField.text:kDefaultMaxSplitCount;
    
    self.user.timeOutTimeInMinute = self.timeOutTextField.text;
    self.user.isNumKeyboardOnly = [NSNumber numberWithBool:self.useNumKeyOnlySwitch.on];
}

#pragma mark - View Style
- (void)setupViewStyle {
    self.navigationItem.title = @"Setting";
}

#pragma mark - Text Field
- (IBAction)textChengedInField:(UITextField *)sender {
    NSString *tip = self.defaultTipTextField.text;
    NSString *max = self.maxTipTextField.text;
    NSString *min = self.minTipTextField.text;
    
    if([self isTipSettingValid:tip max:max min:min]){
        self.defaultTipTextField.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.maxTipTextField.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.minTipTextField.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    } else {
        sender.textColor = [UIColor redColor];
    }
}

- (BOOL)isTipSettingValid:(NSString *)tip max:(NSString *)
max min:(NSString *)min {
    if ((max.integerValue - min.integerValue) >= tip.integerValue) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Fill Data
- (void)fillViewWithData {
    self.defaultTipTextField.text = self.user.tipSetting;
    self.maxTipTextField.text = self.user.maxTipSetting;
    self.minTipTextField.text = self.user.minTipSetting;
    self.timeOutTextField.text = self.user.timeOutTimeInMinute;
    self.divideBillWithWaysTextField.text = self.user.maxSplitCount;
    [self.useNumKeyOnlySwitch setOn:self.user.isNumKeyboardOnly.boolValue];
}

#pragma mark - Table View
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.defaultTipTextField becomeFirstResponder];
        } else if (indexPath.row == 1) {
            [self.maxTipTextField becomeFirstResponder];
        } else if (indexPath.row == 2) {
            [self.minTipTextField becomeFirstResponder];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.timeOutTextField becomeFirstResponder];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self.divideBillWithWaysTextField becomeFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
