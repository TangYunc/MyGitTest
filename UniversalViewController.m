//
//  UniversalViewController.m
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import "UniversalViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UniversalViewController ()

@end

@implementation UniversalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    
    
    
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    completeButton.frame = CGRectMake(0, 0, 44, 44);
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeButton];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 30)];
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.font = [UIFont boldSystemFontOfSize:16];
    _textField.clearButtonMode = YES;
    _textField.placeholder = [NSString stringWithFormat:@"输入您%@",_placeholderString];
    [self.view addSubview:_textField];
    //成为第一响应者
    [_textField becomeFirstResponder];
    //添加手势，点击收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - buttonAction:编辑完成按钮事件
- (void)buttonAction:(UIButton *)button{
    [_textField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changedTextLabel" object:_textField.text];

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 手势事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [_textField resignFirstResponder];
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
