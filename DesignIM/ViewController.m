//
//  ViewController.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/23.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"IM";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 60);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"IM" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showIM) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}
-(void)showIM{
    NSLog(@"showIM");
}
@end
