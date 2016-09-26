//
//  PersonalInfo+CoreDataProperties.h
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/8.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonalInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *personal_nickName;
@property (nullable, nonatomic, retain) NSString *personal_gender;
@property (nullable, nonatomic, retain) NSString *personal_birthDay;
@property (nullable, nonatomic, retain) NSString *personal_weight;
@property (nullable, nonatomic, retain) NSString *personal_hobby;
@property (nullable, nonatomic, retain) NSString *personal_height;
@property (nullable, nonatomic, retain) NSString *personal_profession;
@property (nullable, nonatomic, retain) NSString *personal_company;
@property (nullable, nonatomic, retain) NSString *personal_school;
@property (nullable, nonatomic, retain) NSString *personal_hauntPlace;

@end

NS_ASSUME_NONNULL_END
