//
//  ViewController.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "ViewController.h"
#import "CurrentUser.h"

#import "Bill.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *totalBillTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipSelectionSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic) User *user;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.user = [CurrentUser currentUser];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    if ([self.user.tipSetting integerValue] == 15) {
        self.tipSelectionSegmentedControl.selectedSegmentIndex = 0;
    } else if ([self.user.tipSetting integerValue] == 18) {
        self.tipSelectionSegmentedControl.selectedSegmentIndex = 1;
    } else if ([self.user.tipSetting integerValue] == 20) {
        self.tipSelectionSegmentedControl.selectedSegmentIndex = 2;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.totalBillTextField becomeFirstResponder];
}

- (IBAction)tipAmountValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.user.tipSetting = [NSNumber numberWithInteger:15];
    } else if (sender.selectedSegmentIndex == 1) {
        self.user.tipSetting = [NSNumber numberWithInteger:18];
    }   else if (sender.selectedSegmentIndex == 2) {
        self.user.tipSetting = [NSNumber numberWithInteger:20];
    }
    
    [self updateView];
    
}

- (IBAction)totalBillChanged:(UITextField *)sender {
    [self updateView];
}


- (void)updateView {
    Bill *newBill = [[Bill alloc] init];
    
    newBill = [self.user getBill:self.totalBillTextField.text];
    
    self.tipLable.text = [newBill twoDigitStringWithFloat:newBill.tip];
    self.totalLabel.text = [newBill twoDigitStringWithFloat:newBill.billAfterTip];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
