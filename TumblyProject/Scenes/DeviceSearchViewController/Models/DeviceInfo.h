//
//  DeviceInfo.m
//  TumblyProject
//
//  Created by bumslap on 21/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceInfo : NSObject {
    CBPeripheral *targetPeripheral;
    NSString *signalStrength;
}
- (instancetype)init:(CBPeripheral *)peripheral with:(NSString *)strength;
- (CBPeripheral *)getPeripheral;
- (NSString *)getSignalStrength;
- (void)setSignalStrength: (NSString *)strength;
@end
