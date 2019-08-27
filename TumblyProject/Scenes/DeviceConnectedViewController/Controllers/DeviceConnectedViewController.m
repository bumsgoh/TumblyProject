//
//  DeviceConnectedViewController.m
//  TumblyProject
//
//  Created by bumslap on 22/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "DeviceConnectedViewController.h"
#import "UserInfoManager.h"

@interface DeviceConnectedViewController () <CBPeripheralDelegate>

@property (nonatomic, strong) UILabel *connectedLabel;
@property (nonatomic, strong) UIImageView *bluetoothImageView;
@property (nonatomic, strong) UIView *bluetoothBackgroundView;
@property (nonatomic, strong) CAShapeLayer *pulsatingLayer;
@property (nonatomic, strong) UITapGestureRecognizer *bluetoothSignalGestureRecognizer;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation DeviceConnectedViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        uartServiceUUIDString = @"6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
        uartTXCharacteristicUUIDString = @"6E400003-B5A3-F393-E0A9-E50E24DCCA9E";
        uartRXCharacteristicUUIDString = @"6E400002-B5A3-F393-E0A9-E50E24DCCA9E";
        //TODO: Load light pattern

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    if (!UserInfoManager.shared.isSender) {
        [[[self.ref child:@"users"] child: UserInfoManager.shared.uid] observeEventType:(FIRDataEventTypeChildChanged) withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            [self sendSignalToTargetDevice];
        }];
    }
    [self setupCircleLayers];
    [self setUiComponents];
    [self setLayout];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setPrefersLargeTitles:NO];
   
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.ref removeAllObservers];
}

- (void)setUiComponents {
     //self.navigationController.navigationItem.rightBarButtonItem =
    self.bluetoothSignalGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bluetoothImageViewDidTap)];
    
    self.connectedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.connectedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.connectedLabel.textColor = [UIColor colorWithRed:87/255.f
                                                    green:37/255.f
                                                    blue:229/255.f
                                                    alpha:1.0];
    self.connectedLabel.text = @"연결되었습니다";
    self.connectedLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:self.connectedLabel];
    
    self.bluetoothBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bluetoothBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bluetoothBackgroundView.layer.cornerRadius = 100;
    self.bluetoothBackgroundView.backgroundColor = UIColor.whiteColor;
    self.bluetoothBackgroundView.layer.borderWidth = 2;
    self.bluetoothBackgroundView.layer.borderColor = [UIColor colorWithRed:87/255.f green:37/255.f blue:229/255.f alpha:1.0].CGColor;
    [self.view addSubview:self.bluetoothBackgroundView];
    
    self.bluetoothImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bluetoothImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bluetoothImageView.image = [UIImage imageNamed:@"bluetooth"];
    self.bluetoothImageView.backgroundColor = UIColor.clearColor;
    self.bluetoothImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bluetoothImageView.userInteractionEnabled = YES;
    [self.bluetoothImageView addGestureRecognizer:self.bluetoothSignalGestureRecognizer];
    [self.bluetoothBackgroundView addSubview:self.bluetoothImageView];
    
    
}

- (void)setLayout {
    
    [[_connectedLabel.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];

    [[_connectedLabel.bottomAnchor constraintEqualToAnchor:self.bluetoothBackgroundView.topAnchor
                                               constant:-64] setActive:YES];
      
    [[_bluetoothBackgroundView.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor]
     setActive:YES];
    [[_bluetoothBackgroundView.centerYAnchor
      constraintEqualToAnchor:self.view.centerYAnchor]
     setActive:YES];
    [[_bluetoothBackgroundView.widthAnchor
      constraintEqualToConstant:200]
     setActive:YES];
    [[_bluetoothBackgroundView.heightAnchor
      constraintEqualToConstant:200]
     setActive:YES];
    
    [[_bluetoothImageView.centerXAnchor
     constraintEqualToAnchor:self.bluetoothBackgroundView.centerXAnchor]
     setActive:YES];
    [[_bluetoothImageView.centerYAnchor
      constraintEqualToAnchor:self.bluetoothBackgroundView.centerYAnchor]
     setActive:YES];
    [[_bluetoothImageView.widthAnchor
      constraintEqualToConstant:70]
     setActive:YES];
    [[_bluetoothImageView.heightAnchor
      constraintEqualToConstant:70]
     setActive:YES];
}

-(void)bluetoothImageViewDidTap {
   // [self sendSignalToTargetDevice];
    
    [[[[self.ref child:@"users"] child:UserInfoManager.shared.uid] child:@"isOn"]
     setValue:@true];
}

-(CAShapeLayer *)createCircleLayer {
    CGFloat fullCircle = 2 * M_PI;
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *circularPath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:100 startAngle:0 endAngle:fullCircle clockwise:YES];
    layer.path = circularPath.CGPath;
    layer.strokeColor = [UIColor colorWithRed:87/255.f
                                        green:37/255.f
                                        blue:229/255.f
                                        alpha:0.6].CGColor;
    layer.lineWidth = 1;
    layer.fillColor = UIColor.whiteColor.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.position = self.view.center;
    return layer;
}

-(void)setupCircleLayers {
    self.pulsatingLayer = [self createCircleLayer];
    [self.view.layer addSublayer:self.pulsatingLayer];
    [self animatePulsatingLayer];
}

-(void)animatePulsatingLayer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(1.2);
    animation.toValue = @(1.3);
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.autoreverses = YES;
    animation.repeatCount = INFINITY;
    [self.pulsatingLayer addAnimation:animation forKey:@"pulsing"];
}

- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error {
    for(CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    for(CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:uartTXCharacteristicUUIDString]) {
            uartTXCharacteristic = characteristic;
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            [peripheral readValueForCharacteristic:characteristic];
            targetPeripheral = peripheral;
        } else if ([characteristic.UUID.UUIDString isEqualToString:uartRXCharacteristicUUIDString]) {
            uartRXCharacteristic = characteristic;
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = characteristic.value;
        NSString* readDataString;
        readDataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        if ([readDataString isEqualToString:@"@@M_WAKEUP"]) {
            BOOL isSender = UserInfoManager.shared.isSender;
            NSString *uid = UserInfoManager.shared.uid;
            if (isSender == YES) {
                [[self.ref child:@"users"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    NSDictionary *userInfo = [[NSDictionary alloc] init];
                    userInfo = snapshot.value;//[snapshot.value valueForKey:@"users"];
                    NSLog(@"info is %@", userInfo);
                    for (NSString *targetUid in userInfo) {
                        if(![targetUid isEqualToString:uid]) {
                            NSString *isOn = [[userInfo valueForKey:targetUid] valueForKey:@"isOn"];
                            NSLog(@"a is %@", isOn );
                            if([isOn isEqualToString:@"YES"]) {
                                [[[[self.ref child:@"users"] child:targetUid] child:@"isOn"]
                                 setValue:@"NO"];
                            } else {
                                [[[[self.ref child:@"users"] child:targetUid] child:@"isOn"]
                                 setValue:@"YES"];
                            }
                        }
                    }
                }];
            } else {
                [self sendSignalToTargetDevice];
            }
        }
    });
}

-(void)sendSignalToTargetDevice {
    NSString *lightPattern = @"P1 0 0 0 0 6";
    NSData *encodedData = [lightPattern dataUsingEncoding:NSASCIIStringEncoding];
    [targetPeripheral writeValue:encodedData forCharacteristic:uartRXCharacteristic type:(CBCharacteristicWriteWithResponse)];
}



@end
