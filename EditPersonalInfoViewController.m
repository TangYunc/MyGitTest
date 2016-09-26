//
//  EditPersonalInfoViewController.m
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import "EditPersonalInfoViewController.h"
#import "UniversalViewController.h"
#import "UIViewExt.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "PersonalInfo.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface EditPersonalInfoViewController ()

@end

@implementation EditPersonalInfoViewController

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changedTextLabel" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.hidesBackButton = YES;
    
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    _dataList = @[@"昵称",@"性别",@"出生日期",@"身高",@"体重",@"兴趣爱好",@"职业",@"公司",@"学校",@"常出没的地方"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 42, 42);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    //编辑信息
    [self editPersonalInfoViews];
    //添加一个通知，用于接受当UniversonalVC 的TextField值改变的时候传过来的值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationChangedText:) name:@"changedTextLabel" object:nil];

}
    //编辑信息
- (void)editPersonalInfoViews{

    _personalInfoTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _personalInfoTabelView.backgroundColor = [UIColor whiteColor];
    _personalInfoTabelView.dataSource = self;
    _personalInfoTabelView.delegate = self;
    [self.view addSubview:_personalInfoTabelView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *indentifier = @"cellId";
/*    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }*/
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    //添加辅助视图
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataList[indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.right-100, 5, 150, cell.height-10)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor blackColor];
    label.tag = 2016;
//    label.text = _detailString;
    [cell.contentView addSubview:label];
    return cell;
}
#pragma mark - 接收到通知调用的方法
- (void)notificationChangedText:(NSNotification *)notif
{
    UILabel *label = (UILabel *)[self.view viewWithTag:2016];
    label.text = notif.object;
//    _detailString = notif.object;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    UniversalViewController *universalVC = [[UniversalViewController alloc] init];
    universalVC.title = _dataList[indexPath.row];
    universalVC.placeholderString = _dataList[indexPath.row];
    [self.navigationController pushViewController:universalVC animated:YES];
    //取消选中单元格
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 编辑个人信息完成按钮事件
- (void)buttonAction:(UIButton *)button{

    NSLog(@"编辑个人信息完成，并且已经保存在数据库中");
/*    //创建一个用户的实体对象
    PersonalInfo *personal = [NSEntityDescription insertNewObjectForEntityForName:@"PersonalInfo" inManagedObjectContext:_appDelegate.managedObjectContext];
    //设置用户信息内容
    personal.personal_nickName = accountNumTF.text;
    personal.personal_gender = passwordTF.text;
    personal.personal_birthDay = nickNameTF.text;
    personal.personal_height;
    personal.personal_weight;
    personal.personal_hobby;
    personal.personal_profession;
    personal.personal_company;
    personal.personal_school;
    personal.personal_hauntPlace;
    //保存数据到操作对象中
    [_appDelegate.managedObjectContext insertObject:personal];
    [_appDelegate saveContext];
    //        NSLog(@"personal:%@",personal);
*/
    
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
