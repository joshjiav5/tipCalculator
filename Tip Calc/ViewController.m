//
//  ViewController.m
//  Tip Calc
//
//  Created by JoshJSZ on 1/19/15.
//  Copyright (c) 2015 JoshJia. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "CurrentUser.h"
#import "SplitBillCell.h"
#import "Helper.h"
#import "Bill.h"
#import "NSNumber+NiceFormatter.h"
#import "NSString+NiceInput.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIView *resultView;

@property (weak, nonatomic) IBOutlet UILabel *totalBillLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;

@property (weak, nonatomic) IBOutlet UITableView *splitBillTableView;

@property (weak, nonatomic) IBOutlet UISlider *tipSlider;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splitBillTableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipPercentageLabelHeightNormal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipPercentageLabelHeightZero;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultViewHeightNormal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultViewHeightZero;

@property (nonatomic, readonly) UITapGestureRecognizer *tapToDismissKeyboard;

@property (nonatomic) BOOL isZeroModeActive;
@property (nonatomic) BOOL isNormalModeActive;

@property (nonatomic) User *user;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.user = [CurrentUser currentUser];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViewStyle];
    [self setupSlider];
    [self addObservers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!self.user.billAmount.doubleValue) {
        [self doZeroModeActions];
    } else {
        self.amountTextField.text = self.user.billAmount;
        [self fillViewWithData];
        [self.splitBillTableView reloadData];
        [self doNormalMoldActions];
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeObservers];
}

- (void)setupViewStyle {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.splitBillTableView.backgroundView = nil;
    self.splitBillTableView.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:183.0/255.0 blue:60.0/255.0 alpha:1];
    
    self.amountTextField.placeholder = [Helper getLocalCurrencySymbol];
    if (self.user.isNumKeyboardOnly.boolValue) {
        self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    } else {
        self.amountTextField.keyboardType = UIKeyboardTypeDefault;
    }
}

- (void)doNormalMoldActions {
    if (!self.isNormalModeActive) {
        self.amountTextField.textAlignment = NSTextAlignmentRight;
        [self layoutViewNormalWithDuration:0.25f curve:UIViewAnimationCurveEaseOut];
        [self.view addGestureRecognizer:self.tapToDismissKeyboard];
        self.tapToDismissKeyboard.delegate = self;
        self.isNormalModeActive = YES;
        self.isZeroModeActive = NO;
    }
}

- (void)doZeroModeActions {
    if (!self.isZeroModeActive) {
        self.amountTextField.textAlignment = NSTextAlignmentCenter;
        [self layoutViewZeroWithDuration:0.2f curve:UIViewAnimationCurveEaseOut];
        [self.view removeGestureRecognizer:self.tapToDismissKeyboard];
        self.isZeroModeActive = YES;
        self.isNormalModeActive = NO;
    }
    
}

- (void)sizeToFitAllText {
    [self.amountTextField sizeToFit];
    [self.tipPercentageLabel sizeToFit];
    [self.tipAmountLabel sizeToFit];
    [self.totalBillLabel sizeToFit];
}

- (void)endEditing {
    [self.view endEditing:YES];
}

#pragma mark - Slider

- (void)setupSlider {
    self.tipSlider.maximumValue = self.user.maxTipSetting.floatValue;
    self.tipSlider.minimumValue = self.user.minTipSetting.floatValue;
    self.tipSlider.value = self.user.tipSetting.floatValue;
}

- (IBAction)tipSliderValueChanged:(UISlider *)sender {
    
    [self.user setTipSettingWithFloat:sender.value];
    NSLog(@"%f", sender.value);
    [self fillViewWithData];
    [self.splitBillTableView reloadData];
}


#pragma mark - Fill data

- (void)fillViewWithData {
    [self.user calculateBill];
    self.tipPercentageLabel.text = [self.user.tipSetting stringByAppendingString:@" %"];
    self.tipAmountLabel.text = [@"+ " stringByAppendingString:self.user.bill.tipAmount.roundedCurrencyString];
    self.totalBillLabel.text = self.user.bill.billAfterTip.roundedCurrencyString;
}

#pragma mark - Text Field
- (IBAction)amountTextFieldValueChanged:(UITextField *)sender {
    self.user.billAmount = sender.text;
    [self fillViewWithData];
    if (sender.text.length) {
        [self doNormalMoldActions];
    } else {
        [self doZeroModeActions];
    }
}

#pragma mark - Keyboard
- (void)keyboardWillChangeFrame:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    self.splitBillTableViewHeight.constant = keyboardFrameBeginRect.size.height;
    self.user.lastKeyboardHeight = keyboardFrameBeginRect.size.height;
    [self.view setNeedsUpdateConstraints];
    
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey];
    
    [self layoutWithDuration:duration.doubleValue
                       curve:curve.integerValue
                  completion:nil];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    [self.splitBillTableView reloadData];
}

#pragma mark - Gesture Recognizer

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    [self endEditing];
}

#pragma mark - Observers

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Auto Layout
- (void)layoutViewNormalWithDuration:(double)duration curve:(NSInteger)curve {
    [self.view setNeedsLayout];
    self.splitBillTableViewHeight.constant = self.user.lastKeyboardHeight;
    self.tipPercentageLabel.hidden = NO;
    
    if (self.tipPercentageLabelHeightZero.isActive) {
        self.tipPercentageLabelHeightZero.active = NO;
    }
    if (!self.tipPercentageLabelHeightNormal.isActive) {
        self.tipPercentageLabelHeightNormal.active = YES;
    }
    
    if (self.resultViewHeightZero.isActive) {
        self.resultViewHeightZero.active = NO;
    }
    if (!self.resultViewHeightNormal.isActive) {
        self.resultViewHeightNormal.active = YES;
    }
    
    [self layoutWithDuration:duration
                       curve:curve
                  completion:^(BOOL finished){
                      if (finished) {
                          self.tipSlider.hidden = NO;
                      }
                  }];
}

- (void)layoutViewZeroWithDuration:(double)duration curve:(NSInteger)curve {
    
    [self.view setNeedsLayout];
    
    [self.amountTextField becomeFirstResponder];
    self.tipPercentageLabel.hidden = YES;
    
    if (self.tipPercentageLabelHeightNormal.isActive) {
        self.tipPercentageLabelHeightNormal.active = NO;
    }
    if (!self.tipPercentageLabelHeightZero.isActive) {
        self.tipPercentageLabelHeightZero.active = YES;
    }
    
    if (self.resultViewHeightNormal.isActive) {
        self.resultViewHeightNormal.active = NO;
    }
    if (!self.resultViewHeightZero.isActive) {
        self.resultViewHeightZero.active = YES;
    }
    self.tipSlider.hidden = YES;
    
    [self layoutWithDuration:duration
                       curve:curve
                  completion:nil];
}

- (void)layoutWithDuration:(double)duration curve:(NSInteger)curve completion:(void (^)(BOOL finished))block {
    [UIView animateWithDuration:duration
                          delay:0
                        options:curve
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:block];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.user.maxSplitCount.integerValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SplitBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"splitBillCell" forIndexPath:indexPath];
    
    NSInteger divideBy = indexPath.row + 1;
    cell.divideByLabel.text = [NSString stringWithFormat:@"/ %ld", (long)divideBy];
    cell.priceLabel.text = [self.user.bill splitBillWithWays:divideBy].roundedCurrencyString;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height / 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize tapToDismissKeyboard = _tapToDismissKeyboard;
- (UITapGestureRecognizer *)tapToDismissKeyboard {
    if (!_tapToDismissKeyboard) {
        _tapToDismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    }
    return _tapToDismissKeyboard;
}


@end
