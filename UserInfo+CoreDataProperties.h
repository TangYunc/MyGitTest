//
//  UserInfo+CoreDataProperties.h
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/8.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfo.h"
#import "PersonalInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *user_accountNum;
@property (nullable, nonatomic, retain) NSString *user_password;
@property (nullable, nonatomic, retain) NSString *user_nickName;
@property (nullable, nonatomic, retain) PersonalInfo *personalInfo;

@end

NS_ASSUME_NONNULL_END
