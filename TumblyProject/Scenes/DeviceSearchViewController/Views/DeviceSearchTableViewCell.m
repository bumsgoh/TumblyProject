//
//  DeviceSearchTableViewCell.m
//  TumblyProject
//
//  Created by bumslap on 21/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import "DeviceSearchTableViewCell.h"

@implementation DeviceSearchTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUiComponents];
        [self setLayout];
    }
    return self;
}

- (void)setUiComponents {
    _deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _deviceNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _deviceNameLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.contentView addSubview:_deviceNameLabel];
    
    _signalStrengthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _signalStrengthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_signalStrengthLabel];
}

-(void)setLayout {
    [[_deviceNameLabel.centerYAnchor
      constraintEqualToAnchor:self.contentView.centerYAnchor]
     setActive:YES];
    [[_deviceNameLabel.leadingAnchor
      constraintEqualToAnchor:self.contentView.leadingAnchor
      constant:16]
     setActive:YES];
    
    [[_signalStrengthLabel.centerYAnchor
      constraintEqualToAnchor:self.contentView.centerYAnchor]
     setActive:YES];
    [[_signalStrengthLabel.trailingAnchor
      constraintEqualToAnchor:self.contentView.trailingAnchor
      constant:-8]
     setActive:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
