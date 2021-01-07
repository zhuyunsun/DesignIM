//
//  IMInputView.m
//  DesignIM
//
//  Created by 朱运 on 2021/1/4.
//

#import "IMInputView.h"
@interface IMInputView()<UITextViewDelegate,UITextFieldDelegate,IMFaceDelegate>{
    CGFloat height;
    CGFloat width;
    
    UIView *barView;
    UIButton *voiceBtn;
    UITextView *msgTextView;
    UILabel *voiceLabel;
    UIButton *faceBtn;
    UIButton *otherBtn;
    
    IMFaceView *faceView;
}
@end
@implementation IMInputView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /*
         文字输入栏
         1,键盘界面
         2,表情界面(排版)
         3,其他界面
         */
        height = frame.size.height;
        width = frame.size.width;
        height = 55;
        
        barView = [[UIView alloc]init];
        barView.frame = CGRectMake(0, 0,frame.size.width, 55);
        barView.backgroundColor = [UIColor clearColor];
        [self addSubview:barView];
        
        CGFloat btnHeight = CGRectGetHeight(barView.frame) *0.5;
        CGFloat btnY = (CGRectGetHeight(barView.frame) - btnHeight) / 2;
        CGFloat btnX = width *0.03;
        voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        voiceBtn.frame = CGRectMake(btnX,btnY, btnHeight, btnHeight);
        voiceBtn.backgroundColor = [UIColor clearColor];
        [voiceBtn setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
        [voiceBtn addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchDown];
        [barView addSubview:voiceBtn];
        
        CGFloat msgHeight = height *0.68;
        CGFloat msgY = (height - msgHeight) / 2;
        CGFloat msgWidth = width - (btnX *5 + btnHeight *3);
        msgTextView = [[UITextView alloc]init];
        msgTextView.frame = CGRectMake(CGRectGetMaxX(voiceBtn.frame) + btnX,msgY,msgWidth,msgHeight);
        msgTextView.backgroundColor = [UIColor whiteColor];
        msgTextView.layer.cornerRadius = 3;
        msgTextView.delegate = self;
        msgTextView.font = [UIFont systemFontOfSize:17.f];
        msgTextView.returnKeyType = UIReturnKeySend;
        msgTextView.scrollEnabled = NO;//文字上下回落
        msgTextView.enablesReturnKeyAutomatically = YES;//无文字灰色不可点
        [barView addSubview:msgTextView];
        
        voiceLabel = [[UILabel alloc]init];
        voiceLabel.frame = CGRectMake(CGRectGetMaxX(voiceBtn.frame) + btnX,msgY,msgWidth,msgHeight);
        voiceLabel.backgroundColor = [UIColor grayColor];
        voiceLabel.layer.cornerRadius = 3;
        voiceLabel.userInteractionEnabled = YES;
        voiceLabel.clipsToBounds = YES;
        voiceLabel.hidden = YES;
        voiceLabel.textAlignment = NSTextAlignmentCenter;
        voiceLabel.text = @"按住 说话";
        voiceLabel.textColor = [UIColor whiteColor];
        [barView addSubview:voiceLabel];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
        [voiceLabel addGestureRecognizer:longGesture];
        
        faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        faceBtn.frame = CGRectMake(CGRectGetMaxX(msgTextView.frame) + btnX,btnY, btnHeight, btnHeight);
        faceBtn.backgroundColor = [UIColor clearColor];
        [faceBtn setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
        [faceBtn addTarget:self action:@selector(faceAction:) forControlEvents:UIControlEventTouchDown];
        [barView addSubview:faceBtn];

        otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        otherBtn.frame = CGRectMake(CGRectGetMaxX(faceBtn.frame) + btnX,btnY, btnHeight, btnHeight);
        otherBtn.backgroundColor = [UIColor clearColor];
        [otherBtn setImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateNormal];
        [otherBtn addTarget:self action:@selector(otherAction:) forControlEvents:UIControlEventTouchDown];
        [barView addSubview:otherBtn];

        self.boxState = InputBoxNormal;
        
        
        /*
         关于表情view的加载
         1,inputView高度会发生变化,变大和恢复原样
         2,在适当的地方进行隐藏,frame值不变
         */
        faceView = [[IMFaceView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(barView.frame), width, 300 - 34)];
        faceView.backgroundColor = [UIColor lightGrayColor];
        faceView.hidden = YES;
        faceView.delegate = self;
        [self addSubview:faceView];
        
        
        self.otherView = [[IMOtherView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(barView.frame), width, 300 - 34)];
        self.otherView.backgroundColor = [UIColor lightGrayColor];
        self.otherView.hidden = YES;
        [self addSubview:self.otherView];

    }
    return self;
}
-(void)hideFaceAndOther{
    faceView.hidden = YES;
    self.otherView.hidden = YES;
    [faceBtn setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
}
#pragma mark delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self hideFaceAndOther];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

- (void)getFaceName:(NSString *)name{
    NSLog(@"表情名称:%@",name);
}
- (void)getDeleteAction{
    NSLog(@"删除操作");
}
- (void)getSendAction{
    NSLog(@"发送操作");
}
#pragma mark actions
-(void)voiceAction:(UIButton *)btn{
    faceView.hidden = YES;
    self.otherView.hidden = YES;
    UIImage *i1 = [UIImage imageNamed:@"chatBar_record"];
    NSData *data1 = UIImagePNGRepresentation(i1);
    NSData *data2 = UIImagePNGRepresentation(btn.currentImage);
    if ([data2 isEqual:data1]) {
        [voiceBtn setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
        //录音界面
        voiceLabel.hidden = NO;
        msgTextView.hidden = YES;
        [self.delegate hideKeybord];
    }else{
        [voiceBtn setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
        //正常状态
        self.boxState = InputBoxNormal;
        voiceLabel.hidden = YES;
        msgTextView.hidden = NO;
    }
}
-(void)faceAction:(UIButton *)btn{
    self.otherView.hidden = YES;
    NSLog(@"state = %ld",self.boxState);
    if (self.boxState == InputBoxFace) {
        faceView.hidden = NO;
        [msgTextView becomeFirstResponder];
        [btn setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
        return;
    }
    if (self.boxState == InputBoxOther) {
        faceView.hidden = NO;
        [btn setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
        self.boxState = InputBoxFace;
        return;
    }
    if (self.boxState == InputBoxVoice) {
        //
        voiceLabel.hidden = YES;
        msgTextView.hidden = NO;
        [voiceBtn setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
    }
    
    [self.delegate showFaceView:300 - 34];
    faceView.hidden = NO;
    [btn setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
    /*
     1,需要关闭键盘
     2,输入框位置需要发生变化
     */
}
-(void)otherAction:(UIButton *)btn{
    faceView.hidden = YES;
    [faceBtn setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
    NSLog(@"other");
    if (self.boxState == InputBoxOther) {
        self.otherView.hidden = YES;
        [msgTextView becomeFirstResponder];
        return;
    }
    if (self.boxState == InputBoxFace) {
        self.otherView.hidden = NO;
        self.boxState = InputBoxOther;
        return;
    }
    if (self.boxState == InputBoxVoice) {
        //
        voiceLabel.hidden = YES;
        msgTextView.hidden = NO;
        [voiceBtn setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
    }

    [self.delegate showOtherView:300 - 34];
    self.otherView.hidden = NO;
}
-(void)longAction:(UILongPressGestureRecognizer *)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按,开始录音");
    }
    if (ges.state == UIGestureRecognizerStateEnded) {
        NSLog(@"长按离开,结束录音");
    }
}
@end
