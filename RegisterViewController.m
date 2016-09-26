//
//  RegisterViewController.m
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIViewExt.h"
#import "UserInfo.h"
#import "AppDelegate.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册账户";
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //注册视图信息
    [self registerViewInfo];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];

}
    //注册视图信息
- (void)registerViewInfo{

    NSArray *titleLabelArr = @[@"用户名",@"密 码",@"确认密码"];
    for (int i = 0; i<titleLabelArr.count; i++) {
        UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30+i*(40+10), 80, 40)];
        //registerLabel.tag = 2016+i;
        registerLabel.textAlignment = NSTextAlignmentCenter;
        registerLabel.font = [UIFont boldSystemFontOfSize:18];
        //        registerLabel.backgroundColor = [UIColor yellowColor];
        registerLabel.text = titleLabelArr[i];
        [self.view addSubview:registerLabel];
    }
    NSArray *placeholderTFArr = @[@" 请输入您的账号",@" 请输入您的密码",@" 请输入您的昵称"];
    for (int i = 0; i<placeholderTFArr.count; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:2018];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(label.right+10, 30+i*(10+40), kScreenWidth-label.right-10-20, 40)];
        textField.tag = 2016+i;
        //        textField.returnKeyType = UIReturnKeyNext;
        textField.autocapitalizationType = NO;
        textField.backgroundColor = [UIColor yellowColor];
        textField.placeholder = placeholderTFArr[i];
        textField.font = [UIFont boldSystemFontOfSize:16];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:textField];
        
        //注册位第一相应者
        [textField becomeFirstResponder];
        
    }
    
    //注册按钮
    UILabel *label = (UILabel *)[self.view viewWithTag:2018];
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.frame = CGRectMake(label.left+10, label.bottom+30, kScreenWidth-(label.left+10)*2, 40);
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.backgroundColor = [UIColor cyanColor];
    [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _registerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
}
#pragma mark - 注册按钮事件
- (void)registerButtonAction:(UIButton *)button{
    
    NSLog(@"开始注册");
    UITextField *accountNumTF = (UITextField *)[self.view viewWithTag:2016];
    UITextField *passwordTF = (UITextField *)[self.view viewWithTag:2017];
    UITextField *nickNameTF = (UITextField *)[self.view viewWithTag:2018];

    if (accountNumTF.text.length == 0 || passwordTF.text.length == 0 || nickNameTF.text.length == 0) {
        NSLog(@"输入的账号密码与昵称不能为空, 注册失败");
        //弹出提示窗口
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"输入信息不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertCtrl addAction:confirm];
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        //创建一个用户的实体对象
        UserInfo *userInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:_appDelegate.managedObjectContext];
        //设置用户信息内容
        userInfo.user_accountNum = accountNumTF.text;
        userInfo.user_password = passwordTF.text;
        userInfo.user_nickName = nickNameTF.text;
        //保存数据到操作对象中
        [_appDelegate.managedObjectContext insertObject:userInfo];
        [_appDelegate saveContext];
//        NSLog(@"userInfo:%@",userInfo);
        //调用block的代码块
        if (self.block != nil) {
            self.block(accountNumTF.text,passwordTF.text);
        }
        NSLog(@"注册成功");
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

#pragma mark - 手势事件，收起键盘
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    UITextField *accountNumTF = (UITextField *)[self.view viewWithTag:2016];
    [accountNumTF resignFirstResponder];
}


#pragma mark - UITextFieldDelegate

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
