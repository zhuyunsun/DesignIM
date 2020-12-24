//
//  IMViewController.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "IMViewController.h"

@interface IMViewController (){
    CGFloat height;
    CGFloat width;
    
    IMDataView *dataView;
}

@end

@implementation IMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Talking";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = nil;//取消自定义返回按钮
    
    /*
     第一部分
     展示聊天信息界面,包含文字,表情混排,图片,地图,时间;
     
     第二部分
     输入框功能
     
     第三部分
     机型适配
     
     */
    //
    
    height = self.view.frame.size.height;
    width = self.view.frame.size.width;
    
    //
    CGFloat inputBarHeight = 55;
    CGRect oldR1 = CGRectMake(0, 0, width, height - 88 - 34 - inputBarHeight);
    dataView = [[IMDataView alloc]initWithFrame:oldR1];
    [self.view addSubview:dataView];
    
    CGRect barRect = CGRectMake(0, CGRectGetMaxY(oldR1),width, inputBarHeight);
    UIView *barView = [[UIView alloc]initWithFrame:barRect];
    barView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:barView];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < 50; i ++) {
        [arr addObject:@"1"];
    }
    dataView.IMDataArray = [arr copy];
}
@end
