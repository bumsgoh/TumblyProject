//
//  DeviceConnectedViewController.h
//  TumblyProject
//
//  Created by bumslap on 22/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceConnectedViewController : UIViewController {
    NSString *uartServiceUUIDString;
    NSString *uartTXCharacteristicUUIDString;
    NSString *uartRXCharacteristicUUIDString;
    
    CBCharacteristic *uartRXCharacteristic;
    CBCharacteristic *uartTXCharacteristic;
}

@end

NS_ASSUME_NONNULL_END
