//
//  IMOtherView.m
//  DesignIM
//
//  Created by 朱运 on 2021/1/6.
//

#import "IMOtherView.h"
@interface IMOtherView(){
    CGFloat height;
    CGFloat width;
}
@end
@implementation IMOtherView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /*
         1,相册图片和视频
         2,拍摄图片和视频
         3,位置信息
         4,文件(保留)
         
         不用这么复杂,直接UIButton来写
         */
        
        height = frame.size.height;
        width = frame.size.width;
        
        NSArray *arr = @[@"chatBar_colorMore_photo",@"chatBar_colorMore_camera",@"chatBar_colorMore_location",@"chatBar_colorMore_video"];
        NSArray *titleArr = @[@"相册",@"相机",@"位置",@"视频"];
        
        CGFloat v1Height = width *0.21;
        CGFloat middle = (width - arr.count *v1Height) / 5;
        CGFloat btnHeight = v1Height *0.7;
        
        for (NSUInteger i = 0; i < arr.count; i ++) {
            
            UIView *v1 = [[UIView alloc]init];
            v1.frame = CGRectMake(middle + (middle + v1Height) *i,height *0.04, v1Height, v1Height);
            v1.backgroundColor = [UIColor clearColor];
            [self addSubview:v1];
            
            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(v1Height *0.15,0, btnHeight, btnHeight);
            btn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
            btn.tag = i + 50000;
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
            [v1 addSubview:btn];
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(0, btnHeight, v1Height, v1Height *0.3);
            label.text = titleArr[i];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.adjustsFontSizeToFitWidth = YES;
            label.textColor = [UIColor grayColor];
            [v1 addSubview:label];
            
            if (i == arr.count - 1) {
                v1.hidden = YES;//实现不了功能先隐藏
            }
        }

        
        UIView *v2 = [[UIView alloc]init];
        v2.frame = CGRectMake(middle,height *0.04 *2 + v1Height, v1Height, v1Height);
        v2.backgroundColor = [UIColor clearColor];
//        [self addSubview:v2];
        
        UIButton *locationBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        locationBtn.frame = CGRectMake(v1Height *0.15,0, btnHeight, btnHeight);
        locationBtn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [locationBtn setImage:[UIImage imageNamed:@"Connect_FileTransfer_Icon_61x61_"] forState:UIControlStateNormal];
        [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchDown];
//        [v2 addSubview:locationBtn];

        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, btnHeight, v1Height, v1Height *0.3);
        label.text = @"文件";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [UIColor grayColor];
//        [v2 addSubview:label];


    }
    return self;
}
-(void)locationBtnAction:(UIButton *)btn{
    //文件
    [self.delegate getOtherAction:IMOtherStateFile];
}
-(void)btnAction:(UIButton *)btn{
    NSUInteger i = btn.tag - 50000;
    if (i == 0) {
        //图片
        [self.delegate getOtherAction:IMOtherStatePhoto];
    }
    if (i == 1) {
        //拍摄
        [self.delegate getOtherAction:IMOtherStateCamera];
    }
    if (i == 2) {
        //位置
        [self.delegate getOtherAction:IMOtherStateLocation];
    }
    if (i == 3) {
        //视频对话
        [self.delegate getOtherAction:IMOtherStateVideo];
    }
}
@end
