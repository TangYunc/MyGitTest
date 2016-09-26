//
//  RegisterViewController.h
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

//创建一个block类型
typedef void(^SetTextFieldTextBlock) (NSString *accountText,NSString *passwordText);

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    UIButton *_registerButton;
    AppDelegate *_appDelegate;
    UIButton *_loginButton;
}
//声明一个block属性
@property(nonatomic,copy)SetTextFieldTextBlock block;
//@property(nonatomic,strong)

@end
