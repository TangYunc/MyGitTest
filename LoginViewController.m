//
//  LoginViewController.m
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewExt.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "EditPersonalInfoViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //给本界面添加一个手势，用于点击收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    //登录信息视图管理
    [self loginInfoViews];
}

    //登录信息视图管理
- (void)loginInfoViews{

    //账号用户名
    _accountNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth-50*2, 50)];
    _accountNumTF.backgroundColor = [UIColor yellowColor];
    _accountNumTF.autocapitalizationType = NO;
    _accountNumTF.textAlignment = NSTextAlignmentLeft;
    _accountNumTF.font = [UIFont boldSystemFontOfSize:12];
    _accountNumTF.textColor = [UIColor grayColor];
    _accountNumTF.placeholder = @"     手机号／邮箱／用户名";
    _accountNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountNumTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_accountNumTF];
    [_accountNumTF becomeFirstResponder];
    
    //密码
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(_accountNumTF.left, _accountNumTF.bottom+10, kScreenWidth-50*2, 50)];
    _passwordTF.backgroundColor = [UIColor yellowColor];
    _accountNumTF.autocapitalizationType = NO;
    _passwordTF.textAlignment = NSTextAlignmentLeft;
    _passwordTF.font = [UIFont boldSystemFontOfSize:16];
    _passwordTF.textColor = [UIColor grayColor];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.adjustsFontSizeToFitWidth = YES;
    _passwordTF.placeholder = @"     请输入您的密码";
    _passwordTF.borderStyle = UITextBorderStyleNone;
    //    _passwordTF.delegate = self;
    [self.view addSubview:_passwordTF];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(_passwordTF.left+10, _passwordTF.bottom+10, kScreenWidth-(_passwordTF.left+10)*2, 40);
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor cyanColor];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    NSArray *titleArr = @[@"无法登录？",@"新用户"];
    for (int i = 0 ; i<titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*(kScreenWidth-10-80-10), self.view.bottom-100, 80, 20);
        button.tag = 2016+i;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}



#pragma mark - 登陆按钮事件
- (void)loginButtonAction:(UIButton *)button{
    
    if (_accountNumTF.text.length == 0 || _passwordTF.text.length == 0) {
//        NSLog(@"账号和密码不能为空,登录失败");
        //弹出alert视图提示输入账号密码
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"账号和密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        //输入账号密码并且在在本地数据库中查询，看是否当前的账号密码存在且一致，如果存在。则登录成功跳转到主页面。如果不存在，则登录失败，弹出提示信息
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    UITextField *accountTF = [registerVC.view viewWithTag:2016];

    //创建用户信息实体对象
    NSEntityDescription *userInfo = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:_appDelegate.managedObjectContext];
   //创建查询对象
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //设置所有查询的实体对象
    [fetchRequest setEntity:userInfo];
    NSString *predicateString = [NSString stringWithFormat:@"self.user_accountNum like '*%@*'",accountTF.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    [fetchRequest setPredicate:predicate];
    NSArray *result = [_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    NSLog(@"result:%@",result);
        
    for (UserInfo *userInfo in result) {
//        NSLog(@"%@",userInfo);
//        NSLog(@"%@",userInfo.user_accountNum);
////        删除
//        [_appDelegate.managedObjectContext deleteObject:userInfo];
//        [_appDelegate saveContext];
 
        if (_accountNumTF.text != userInfo.user_accountNum || _passwordTF.text != userInfo.user_password) {
            UIAlertController *alertCtrol  = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"账户不正确" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertCtrol addAction:confirm];
            [self presentViewController:alertCtrol animated:YES completion:nil];
        }else if(_accountNumTF.text == userInfo.user_accountNum && _passwordTF.text == userInfo.user_password){
            NSLog(@"点击登陆成功");
            EditPersonalInfoViewController *editPersonalInfoVC = [[EditPersonalInfoViewController alloc] init];
            [self.navigationController pushViewController:editPersonalInfoVC animated:YES];
        
            }
        }
    }
}
#pragma mark - 手势事件
- (void)tapAction:(UITapGestureRecognizer *)tap{

    [_accountNumTF resignFirstResponder];
}


#pragma mark - 注册或者忘记密码按钮事件
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 2016) {
        NSLog(@"无法登录事件");
    }else{
        NSLog(@"注册成为新用户");
        RegisterViewController *registerVC = [[RegisterViewController alloc] init];
        //注册控制器block代码块的实现
        registerVC.block = ^(NSString *accountText,NSString *passwordText){
        //block块的实现
            _accountNumTF.text = accountText;
            _passwordTF.text = passwordText;
        };
        [self presentViewController:registerVC animated:YES completion:nil];
//        [self.navigationController pushViewController:registerVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
