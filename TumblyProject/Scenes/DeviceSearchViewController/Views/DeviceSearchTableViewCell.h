//
//  DeviceSearchTableViewCell.h
//  TumblyProject
//
//  Created by bumslap on 21/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceSearchTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *deviceNameLabel;
@property (nonatomic, strong) UILabel *signalStrengthLabel;

@end

NS_ASSUME_NONNULL_END
