//
//  UserInfo.h
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UserInfo : NSManagedObject
@property(nonatomic,retain)NSString * user_accountNum;
@property(nonatomic,retain)NSString * user_password;
@property(nonatomic,retain)NSString * user_nickName;
@end
