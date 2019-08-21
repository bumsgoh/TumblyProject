//
//  DeviceConnectedViewController.m
//  TumblyProject
//
//  Created by bumslap on 22/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "DeviceConnectedViewController.h"

@interface DeviceConnectedViewController () <CBPeripheralDelegate>

@property (nonatomic, strong) UILabel *connectedLabel;
@property (nonatomic, strong) UIImageView *bluetoothImageView;
@property (nonatomic, strong) UIView *bluetoothBackgroundView;
@property (nonatomic, strong) CAShapeLayer *pulsatingLayer;
@end

@implementation DeviceConnectedViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        uartServiceUUIDString = @"6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
        uartTXCharacteristicUUIDString = @"6E400003-B5A3-F393-E0A9-E50E24DCCA9E";
        uartRXCharacteristicUUIDString = @"6E400002-B5A3-F393-E0A9-E50E24DCCA9E";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCircleLayers];
    [self setUiComponents];
    
    [self setLayout];
   
}

- (void)setUiComponents {
    self.connectedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.connectedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.connectedLabel.textColor = [UIColor colorWithRed:87/255.f green:37/255.f blue:229/255.f alpha:1.0];
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

-(CAShapeLayer *)createCircleLayer {
    CGFloat fullCircle = 2 * M_PI;

    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *circularPath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:100 startAngle:0 endAngle:fullCircle clockwise:YES];
    layer.path = circularPath.CGPath;
    layer.strokeColor = [UIColor colorWithRed:87/255.f green:37/255.f blue:229/255.f alpha:0.6].CGColor;
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
    
//    CAShapeLayer *trackLayer = [self createCircleShapeLayer];
//    [view.layer.addSublayer(trackLayer)
//

}

-(void)animatePulsatingLayer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(1.2);
    animation.toValue = @(1.3);
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.autoreverses = YES;
    animation.repeatCount = INFINITY;

//    [self.pulsatingLayer setValue:animation.toValue forKeyPath:animation.keyPath];

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
    NSLog(@"success");
    for(CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:uartTXCharacteristicUUIDString]) {
            uartTXCharacteristic = characteristic;
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
           // [peripheral readValueForCharacteristic:characteristic];
            
            
        } else if ([characteristic.UUID.UUIDString isEqualToString:uartRXCharacteristicUUIDString]) {
            uartRXCharacteristic = characteristic;
           // [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            [peripheral readValueForCharacteristic:characteristic];
            
            
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Decode the characteristic data
        NSData *data = characteristic.value;
      
        NSString* myString;
        myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(myString);
    });
//    if ([characteristic.UUID.UUIDString isEqualToString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"]) {
//        //NSString *updatedValue = characteristic.value;
//        NSLog(characteristic.value);
//}
}




@end
