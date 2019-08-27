//
//  UserInfoManager.m
//  TumblyProject
//
//  Created by bumslap on 24/08/2019.
//  Copyright © 2019 bumslap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoManager.h"

@implementation UserInfoManager

+(UserInfoManager *) shared{
    static UserInfoManager *shared = nil;
    
    if (!shared) {
        
        shared = [[super allocWithZone:nil] init];
    }
    return shared;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    
    return [self shared];
}

-(id)init{
    
    self = [super init];
    if (self) {
        _isSender = NO;
        _uid = @"";
    }
    
    return self;
}

@end
