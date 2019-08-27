//
//  UserInfoManager.h
//  TumblyProject
//
//  Created by bumslap on 24/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

@property (nonatomic) BOOL isSender;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *lightPattern;

+(UserInfoManager *) shared;

@end
