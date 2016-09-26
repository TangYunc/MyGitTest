//
//  UserInfo.m
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@dynamic user_accountNum;
@dynamic user_password;
@dynamic user_nickName;

- (NSString *)description{

    return [NSString stringWithFormat:@"accountNum:%@,password:%@,nickNmae:%@",self.user_accountNum,self.user_password,self.user_nickName];
}
@end
