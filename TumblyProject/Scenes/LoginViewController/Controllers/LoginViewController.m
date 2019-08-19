//
//  LoginViewController.m
//  TumblyProject
//
//  Created by bumslap on 19/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIView *signInBackgroundView;

@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UITextField *loginIdTextField;

@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextField *loginPasswordTextField;

@property (nonatomic, strong) UIView *idTextFieldDivider;
@property (nonatomic, strong) UIView *passwordTextFieldDivider;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *signUpTextLabel;

@property (nonatomic, strong) UILabel *appTitleLabel;
@property (nonatomic, strong) UILabel *appSmallLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUiComponents];
    [self setLayout];
    // Do any additional setup after loading the view.
}

- (void)setUiComponents {
    self.signInBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.signInBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.signInBackgroundView.layer.cornerRadius = 30;
    self.signInBackgroundView.backgroundColor = [UIColor colorWithRed:87/255.f green:37/255.f blue:229/255.f alpha:1.0];
    [self.view addSubview:self.signInBackgroundView];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.idLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.idLabel.font = [UIFont boldSystemFontOfSize:16];
    self.idLabel.text = @"Email";
    self.idLabel.textAlignment = NSTextAlignmentLeft;
    [self.signInBackgroundView addSubview:self.idLabel];
    
    self.loginIdTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.loginIdTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginIdTextField.backgroundColor = UIColor.clearColor;
    self.loginIdTextField.placeholder = @"아이디를 입력해주세요";
    self.loginIdTextField.textAlignment = NSTextAlignmentLeft;
    self.loginIdTextField.textContentType = UITextContentTypeEmailAddress;
    self.loginIdTextField.autocapitalizationType = NO;
    self.loginIdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"아이디를 입력해주세요" attributes:@{NSForegroundColorAttributeName: UIColor.whiteColor}];

    self.loginIdTextField.clearButtonMode = YES;
    [self.signInBackgroundView addSubview:self.loginIdTextField];
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordLabel.font = [UIFont boldSystemFontOfSize:16];
    self.passwordLabel.text = @"Password";
    self.passwordLabel.textAlignment = NSTextAlignmentLeft;
    [self.signInBackgroundView addSubview:self.passwordLabel];
    
    self.loginPasswordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.loginPasswordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginPasswordTextField.backgroundColor = UIColor.clearColor;
    self.loginPasswordTextField.textAlignment = NSTextAlignmentLeft;
    self.loginPasswordTextField.textContentType = UITextContentTypePassword;
    self.loginPasswordTextField.secureTextEntry = YES;
    self.loginPasswordTextField.clearButtonMode = YES;
    self.loginPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"비밀번호를 입력해주세요" attributes:@{NSForegroundColorAttributeName: UIColor.whiteColor}];
    [self.signInBackgroundView addSubview:self.loginPasswordTextField];
    
    self.idTextFieldDivider = [[UIView alloc] initWithFrame:CGRectZero];
    self.idTextFieldDivider.translatesAutoresizingMaskIntoConstraints = NO;
    self.idTextFieldDivider.backgroundColor = UIColor.lightGrayColor;
    [self.signInBackgroundView addSubview:self.idTextFieldDivider];
    
    self.passwordTextFieldDivider = [[UIView alloc] initWithFrame:CGRectZero];
    self.passwordTextFieldDivider.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordTextFieldDivider.backgroundColor = UIColor.lightGrayColor;
    [self.signInBackgroundView addSubview:self.passwordTextFieldDivider];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loginButton setTitle:@"시작하기" forState:UIControlStateNormal];
    [self.loginButton setTintColor:UIColor.whiteColor];
    [self.loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor colorWithRed:61/255.f green:28/255.f blue:106/255.f alpha:1.0];
    self.loginButton.layer.cornerRadius = 10;
    [self.loginButton addTarget:self
                         action: @selector(loginButtonDidTap)
               forControlEvents:UIControlEventTouchUpInside];
    [self.signInBackgroundView addSubview:self.loginButton];
    
    self.signUpTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.signUpTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.signUpTextLabel.font = [UIFont systemFontOfSize:16];
    self.signUpTextLabel.text = @"아직 회원이 아니신가요?";
    self.signUpTextLabel.textColor = UIColor.whiteColor;
    self.signUpTextLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.signUpTextLabel];
    
    self.appTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.appTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.appTitleLabel.font = [UIFont boldSystemFontOfSize:36];
    self.appTitleLabel.text = @"Log in";
    self.appTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.appTitleLabel];
    
    self.appSmallLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.appSmallLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.appSmallLabel.font = [UIFont boldSystemFontOfSize:18];
    self.appSmallLabel.textColor = UIColor.darkGrayColor;
    self.appSmallLabel.textAlignment = NSTextAlignmentLeft;
    self.appSmallLabel.text = @"Tumbly";
    [self.view addSubview:self.appSmallLabel];
    
}

- (void)setLayout {
    
    [[self.signInBackgroundView.topAnchor
      constraintEqualToAnchor:self.appTitleLabel.bottomAnchor
      constant:24]
     setActive:YES];
    [[self.signInBackgroundView.leadingAnchor
      constraintEqualToAnchor:self.view.leadingAnchor]
     setActive:YES];
    [[self.signInBackgroundView.trailingAnchor
      constraintEqualToAnchor:self.view.trailingAnchor]
      setActive:YES];
    [[self.signInBackgroundView.bottomAnchor
      constraintEqualToAnchor:self.view.bottomAnchor]
      setActive:YES];
    
    [[self.idLabel.topAnchor
      constraintEqualToAnchor:self.signInBackgroundView.topAnchor
      constant:64]
     setActive:YES];
    [[self.idLabel.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.idLabel.heightAnchor
      constraintEqualToConstant:36]
     setActive:YES];
    [[self.idLabel.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.loginIdTextField.topAnchor
      constraintEqualToAnchor:self.idLabel.bottomAnchor
      constant:8]
     setActive:YES];
    [[self.loginIdTextField.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.loginIdTextField.heightAnchor
      constraintEqualToConstant:24]
     setActive:YES];
    [[self.loginIdTextField.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.idTextFieldDivider.topAnchor
      constraintEqualToAnchor:self.loginIdTextField.bottomAnchor
      constant:8]
     setActive:YES];
    [[self.idTextFieldDivider.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.idTextFieldDivider.heightAnchor
      constraintEqualToConstant:1]
     setActive:YES];
    [[self.idTextFieldDivider.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];

    [[self.passwordLabel.topAnchor
      constraintEqualToAnchor:self.idTextFieldDivider.bottomAnchor
      constant:24]
     setActive:YES];
    [[self.passwordLabel.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.passwordLabel.heightAnchor
      constraintEqualToConstant:24]
     setActive:YES];
    [[self.passwordLabel.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.loginPasswordTextField.topAnchor
      constraintEqualToAnchor:self.passwordLabel.bottomAnchor
      constant:8]
     setActive:YES];
    [[self.loginPasswordTextField.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.loginPasswordTextField.heightAnchor
      constraintEqualToConstant:36]
     setActive:YES];
    [[self.loginPasswordTextField.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.passwordTextFieldDivider.topAnchor
      constraintEqualToAnchor:self.loginPasswordTextField.bottomAnchor
      constant:8]
     setActive:YES];
    [[self.passwordTextFieldDivider.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.passwordTextFieldDivider.heightAnchor
      constraintEqualToConstant:1]
     setActive:YES];
    [[self.passwordTextFieldDivider.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.signUpTextLabel.topAnchor
      constraintEqualToAnchor:self.passwordTextFieldDivider.bottomAnchor
      constant:16]
     setActive:YES];
    [[self.signUpTextLabel.trailingAnchor
      constraintEqualToAnchor:self.passwordTextFieldDivider.trailingAnchor]
     setActive:YES];
    
    [[self.loginButton.topAnchor
      constraintEqualToAnchor:self.signUpTextLabel.bottomAnchor
      constant:8]
     setActive:YES];
    [[self.loginButton.trailingAnchor
      constraintEqualToAnchor:self.passwordTextFieldDivider.trailingAnchor
      constant:8]
     setActive:YES];
    [[self.loginButton.widthAnchor
      constraintEqualToAnchor:self.passwordTextFieldDivider.widthAnchor
      multiplier:0.5]
     setActive:YES];
    [[self.loginButton.heightAnchor
      constraintEqualToConstant:40]
     setActive:YES];
    
    [[self.appSmallLabel.topAnchor
      constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor
      constant:100]
     setActive:YES];
    [[self.appSmallLabel.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.appSmallLabel.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
    [[self.appTitleLabel.topAnchor
      constraintEqualToAnchor:self.appSmallLabel.bottomAnchor
      constant:4]
     setActive:YES];
    [[self.appTitleLabel.widthAnchor
      constraintEqualToAnchor:self.view.widthAnchor
      multiplier:0.8]
     setActive:YES];
    [[self.appTitleLabel.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    
}

- (void)loginButtonDidTap {}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
