//
//  DeviceInfo.m
//  TumblyProject
//
//  Created by bumslap on 21/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "DeviceInfo.h"


@interface DeviceInfo()

@end

@implementation DeviceInfo

- (instancetype)init:(CBPeripheral *)peripheral with:(NSString *)strength {
    self = [super init];
    if (self) {
        targetPeripheral = peripheral;
        signalStrength = strength;
    }
    
    return self;
}
- (BOOL)isEqual:(id)object {
    DeviceInfo *target = object;
    BOOL hasSameIdentifier = [targetPeripheral.identifier.UUIDString isEqualToString:  target.getPeripheral.identifier.UUIDString];
    return hasSameIdentifier;
}

- (CBPeripheral *)getPeripheral {
    return targetPeripheral;
}

- (NSString *)getSignalStrength {
    return signalStrength;
}

- (void)setSignalStrength: (NSString *)strength {
    signalStrength = strength;
    return;
}



@end

