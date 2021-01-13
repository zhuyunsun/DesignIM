//
//  CommonViewController.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;//(0,0)坐标系从导航栏下面开始;
    
    //左边item
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
