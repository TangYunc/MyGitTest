//
//  LoginViewController.h
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface LoginViewController : UIViewController
{
    UITextField *_accountNumTF;
    UITextField *_passwordTF;
    UIButton *_loginButton;
    AppDelegate *_appDelegate;
}
@end
