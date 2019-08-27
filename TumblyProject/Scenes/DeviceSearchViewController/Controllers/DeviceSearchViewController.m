//
//  DeviceSearchViewController.m
//  TumblyProject
//
//  Created by bumslap on 21/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "DeviceSearchViewController.h"
#import "DeviceSearchTableViewCell.h"
#import "DeviceConnectedViewController.h"
#import "DeviceInfo.h"


@interface DeviceSearchViewController () <UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) UITableView *deviceSearchTableView;
@property (nonatomic, strong) NSMutableArray *deviceList;

@end

@implementation DeviceSearchViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        peripheralPool = [[NSMutableArray alloc] init];
        uartServiceUUIDString = @"6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
        uartTXCharacteristicUUIDString = @"6E400003-B5A3-F393-E0A9-E50E24DCCA9E";
        uartRXCharacteristicUUIDString = @"6E400002-B5A3-F393-E0A9-E50E24DCCA9E";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUiComponents];
    [self setLayout];
    [self setBluetoothTools];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
}

- (void)setUiComponents {
    self.deviceSearchTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.deviceSearchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceSearchTableView.delegate = self;
    self.deviceSearchTableView.dataSource = self;
    [self.deviceSearchTableView registerClass:DeviceSearchTableViewCell.class
                       forCellReuseIdentifier:@"deviceSearchCell"];
    [self.view addSubview:self.deviceSearchTableView];
}

- (void)setLayout {
    [[self.deviceSearchTableView.topAnchor
      constraintEqualToAnchor:self.view.topAnchor]
     setActive:YES];
    [[self.deviceSearchTableView.leadingAnchor
      constraintEqualToAnchor:self.view.leadingAnchor]
     setActive:YES];
    [[self.deviceSearchTableView.trailingAnchor
      constraintEqualToAnchor:self.view.trailingAnchor]
     setActive:YES];
    [[self.deviceSearchTableView.bottomAnchor
      constraintEqualToAnchor:self.view.bottomAnchor]
     setActive:YES];
}

-(void)setBluetoothTools {
    bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DeviceSearchTableViewCell *cell = (DeviceSearchTableViewCell *)[_deviceSearchTableView dequeueReusableCellWithIdentifier:@"deviceSearchCell"];
    
    if (cell == nil) {
        cell = [[DeviceSearchTableViewCell alloc]initWithStyle:nil
                                               reuseIdentifier:@"deviceSearchCell"];
    }
    DeviceInfo *info = peripheralPool[indexPath.row];
    cell.deviceNameLabel.text = info.getPeripheral.name;
    cell.signalStrengthLabel.text = info.getSignalStrength;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return peripheralPool.count;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceInfo *info = peripheralPool[indexPath.row];
    targetPeripheral = info.getPeripheral;
    [bluetoothManager stopScan];
    [bluetoothManager connectPeripheral:targetPeripheral options:nil];
}

- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    NSMutableString *message;
    switch (central.state) {
    case CBManagerStatePoweredOn:
        message = [NSMutableString stringWithString:@"Bluetooth is On"];
        [bluetoothManager scanForPeripheralsWithServices:nil options:nil];
    case CBManagerStatePoweredOff:
        message = [NSMutableString stringWithString:@"Bluetooth is Off"];
    case CBManagerStateUnsupported:
        message = [NSMutableString stringWithString:@"Not Supported"];
    default:
        message = [NSMutableString stringWithString:@"Unknown Error"];

    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString *rssiValue = RSSI.stringValue;
    NSString *targetName = peripheral.name;
   
    NSLog(@"name is %@", targetName);
    DeviceInfo *targetInfo = [[DeviceInfo alloc] init:peripheral with:rssiValue];
    if (![targetName isEqualToString: @""] && targetName != nil) {
        if ([peripheralPool containsObject:targetInfo]) {
            NSInteger index = [peripheralPool indexOfObject:targetInfo];
            DeviceInfo *updateItem = peripheralPool[index];
            [updateItem setSignalStrength:rssiValue];
        } else {
            [peripheralPool addObject:targetInfo];
        }
        [self.deviceSearchTableView reloadData];
    } else {
        return;
    }
}

- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    isTargetPeripheralConnected = YES;
    DeviceConnectedViewController *connectedViewController = [[DeviceConnectedViewController alloc] initWithNibName:nil bundle:nil];
    connectedViewController.view.backgroundColor = UIColor.whiteColor;
    
    peripheral.delegate = connectedViewController;
    [peripheral discoverServices:nil];
    [self.navigationController pushViewController:connectedViewController animated:YES];
    
}

- (void)centralManager:(CBCentralManager *)central
didDisconnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error {
    isTargetPeripheralConnected = NO;
}


@end
