//
//  LightPatternSettingViewController.m
//  TumblyProject
//
//  Created by bumslap on 27/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "LightPatternSettingViewController.h"
#import "UserInfoManager.h"

@interface LightPatternSettingViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) UIBarButtonItem *applyButton;
@property (nonatomic, strong) UILabel *lightPatternLabel;
@property (nonatomic, strong) UIPickerView *lightPatternPickerView;

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UITextField *redTextField;
@property (nonatomic, strong) UITextField *greenTextField;
@property (nonatomic, strong) UITextField *blueTextField;

@property (nonatomic, strong) NSMutableArray *deviceList;
@property (nonatomic, strong) NSString *lightPatternString;


@property (nonatomic, strong) NSString *red;
@property (nonatomic, strong) NSString *green;
@property (nonatomic, strong) NSString *blue;
@property (nonatomic, strong) NSString *option;

@end

@implementation LightPatternSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUiComponents];
    [self setLayout];
    self.deviceList = [NSArray arrayWithObjects: @"디밍 효과", @"시계방향 회전", @"반시계방향 회전", @"디밍 랜덤", @"회전 랜덤", nil];
    
    // Do any additional setup after loading the view.
}

- (void)setUiComponents {
    self.lightPatternString = @"P2";
    self.option = @"63";
    
    self.applyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(applyButtonDidTap)];
    self.closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(closeButtonDidTap)];
    
    self.navigationItem.rightBarButtonItem = self.applyButton;
    self.navigationItem.leftBarButtonItem = self.closeButton;
    
    self.lightPatternLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.lightPatternLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.lightPatternLabel.textColor = [UIColor colorWithRed:87/255.f
                                                    green:37/255.f
                                                     blue:229/255.f
                                                    alpha:1.0];
    
    self.lightPatternLabel.text = @"효과를 선택하세요";
    self.lightPatternLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:self.lightPatternLabel];
    
    self.lightPatternPickerView = [UIPickerView new];
    self.lightPatternPickerView.delegate = self;
    self.lightPatternPickerView.dataSource = self;
     self.lightPatternPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.lightPatternPickerView];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.spacing = 16;
    
    [self.view addSubview:self.stackView];
    
    self.redTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.redTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.redTextField.textColor = UIColor.blackColor;
    self.redTextField.placeholder = @"red";
    
    self.greenTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.greenTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.greenTextField.textColor = UIColor.blackColor;
    self.greenTextField.placeholder = @"green";
    
    self.blueTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.blueTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.blueTextField.textColor = UIColor.blackColor;
    self.blueTextField.placeholder = @"blue";
    
    [self.stackView addArrangedSubview:_redTextField];
    [self.stackView addArrangedSubview:_greenTextField];
    [self.stackView addArrangedSubview:_blueTextField];
    
}

- (void)setLayout {
    
    [[self.lightPatternLabel.topAnchor
      constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor
      constant:24]
     setActive:YES];
    
    [[self.lightPatternLabel.leadingAnchor
      constraintEqualToAnchor:self.view.leadingAnchor
      constant:32]
     setActive:YES];
    
    [[self.lightPatternLabel.heightAnchor
      constraintEqualToConstant:20]
     setActive:YES];
    
    
    [[self.lightPatternPickerView.topAnchor
      constraintEqualToAnchor:self.lightPatternLabel.bottomAnchor
      constant:0]
     setActive:YES];
    [[self.lightPatternPickerView.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.stackView.topAnchor
      constraintEqualToAnchor:self.lightPatternPickerView.bottomAnchor
      constant:32]
     setActive:YES];
    [[self.stackView.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    
    
}

- (void)applyButtonDidTap {
    
    NSString *pattern = self.lightPatternString;
    
    NSString *red = self.redTextField.text;
    NSString *green = self.greenTextField.text;
    NSString *blue = self.blueTextField.text;
    
    if ([pattern isEqualToString:@""] || [red isEqualToString:@""] || [green isEqualToString:@""] || [blue isEqualToString:@""]) {
        return;
    }
    NSString *colors = [NSString stringWithFormat:@" %@ %@ %@ %@", red, green, blue, self.option];
    NSString *mergedWithColors = [pattern stringByAppendingString:colors];
    NSString *mergedString = [mergedWithColors stringByAppendingString:@" 5"];
    
    
    UserInfoManager.shared.lightPattern = mergedString;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeButtonDidTap {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.deviceList.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.deviceList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.lightPatternString = self.deviceList[row];
    switch (row) {
        case 0:
            self.lightPatternString = @"P2";
            self.option = @"63";
            break;
        case 1:
            self.lightPatternString = @"P3";
            self.option = @"0";
            break;
        case 2:
            self.lightPatternString = @"P3";
            self.option = @"1";
            break;
        case 3:
            self.lightPatternString = @"P4";
            self.option = @"0";
            break;
        case 4:
            self.lightPatternString = @"P1";
            self.option = @"0";
            break;
        default:
            self.lightPatternString = @"P2";
            self.option = @"0";
            break;
    }
}


@end
