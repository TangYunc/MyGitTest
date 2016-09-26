//
//  EditPersonalInfoViewController.h
//  LoginAndRegister
//
//  Created by Mr_Tang on 16/1/7.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface EditPersonalInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_personalInfoTabelView;
    AppDelegate *_appDelegate;
    UILabel *_label;

}
@property(nonatomic,strong)NSString *detailString;
@property(nonatomic,strong)NSArray *dataList;
@end
