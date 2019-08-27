//
//  DeviceSearchViewController.h
//  TumblyProject
//
//  Created by bumslap on 21/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
@class DeviceInfo;

NS_ASSUME_NONNULL_BEGIN

@interface DeviceSearchViewController : UIViewController {
    CBCentralManager *bluetoothManager;
    CBPeripheral *targetPeripheral;
    CBCharacteristic *targetCharacteristic;
    CBCharacteristic *uartRXCharacteristic;
    CBCharacteristic *uartTXCharacteristic;
    
    NSMutableArray *peripheralPool;
    
    BOOL isTargetPeripheralConnected;
    NSString *uartServiceUUIDString;
    NSString *uartTXCharacteristicUUIDString;
    NSString *uartRXCharacteristicUUIDString;

}


@end

NS_ASSUME_NONNULL_END
