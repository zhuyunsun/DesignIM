//
//  IMViewController.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "IMViewController.h"
#import "IMTestMessage.h"
#import "IMInputView.h"
@interface IMViewController ()<InputHeightDelegate,IMOtherDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    CGFloat height;
    CGFloat width;
    
    IMDataView *dataView;
    UITapGestureRecognizer *tapGesture;
    
    IMInputView *inputView;
    
    
    CGRect oldDataRect;
    CGRect oldInputRect;
    
    CGFloat iphoneXBottom;
    CGFloat iphoneXTop;
    
    CGFloat  boardHeight;//键盘高度
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
     
     
     输入框操作导致的变化,
     多出的部分,展示信息上移的高,
     */
    //
    
    height = self.view.frame.size.height;
    width = self.view.frame.size.width;
    
    //
    CGFloat inputBarHeight = 55;
    
    iphoneXBottom = 34;
//    iphoneXBottom = 0.0;
    iphoneXTop = 88;
//    iphoneXTop = 64;
    
    
    CGRect oldR1 = CGRectMake(0, 0, width, height - iphoneXTop - iphoneXBottom - inputBarHeight);
    dataView = [[IMDataView alloc]initWithFrame:oldR1];
    [self.view addSubview:dataView];
    dataView.IMTableView.userInteractionEnabled = YES;
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [dataView.IMTableView addGestureRecognizer:tapGesture];
    oldDataRect = oldR1;
    //
    CGRect barRect = CGRectMake(0, CGRectGetMaxY(oldR1),width, inputBarHeight + iphoneXBottom);
    inputView = [[IMInputView alloc]initWithFrame:barRect];
    inputView.backgroundColor = [UIColor lightGrayColor];
    inputView.delegate = self;
    inputView.otherView.delegate = self;
    [self.view addSubview:inputView];
    oldInputRect = barRect;
    
    //
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    IMTestMessage *testMsg = [[IMTestMessage alloc]init];
    for (NSUInteger i = 0; i < 10; i ++) {
        IMModel *model = [testMsg randomTextAndPhoto];
        [arr addObject:model];
    }
    
    [arr insertObject:[testMsg randomTime] atIndex:arr.count - 1];
    dataView.IMDataArray = [arr copy];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"add" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];

    [self addKeyWordBoard];
}
-(void)addKeyWordBoard{
    NSLog(@"addKeyWordBoard");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWindowShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWindowHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyWindowShow:(NSNotification *)noti{
    NSLog(@"键盘弹出");
    if (inputView.boxState == InputBoxKeyboard) {
        
        return;
    }
    inputView.boxState = InputBoxKeyboard;
    NSDictionary *useInfo = [noti userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    if([noti.name isEqualToString:UIKeyboardWillShowNotification]){
        boardHeight = [value CGRectValue].size.height;
        [self becomNormal];
        [self getKeyBoardMoreHeight:boardHeight];
    }
}
-(void)keyWindowHide:(NSNotification *)noti{
//    [self becomNormal];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)getKeyBoardMoreHeight:(CGFloat)moreHeight{//给弹出键盘用
    NSLog(@"moreHeight = %f",moreHeight);
    moreHeight = moreHeight - iphoneXBottom;
    
    [dataView.IMTableView addGestureRecognizer:tapGesture];
    
    CGRect r1 = dataView.frame;
    r1.size.height = r1.size.height - moreHeight;
    [UIView animateWithDuration:0.23 animations:^{
        dataView.frame = r1;
        dataView.IMTableView.frame = r1;
        CGPoint offset = CGPointMake(0, dataView.IMTableView.contentSize.height - dataView.IMTableView.frame.size.height);
        if (offset.y > 0) {
            [dataView.IMTableView setContentOffset:offset animated:NO];
        }
    } completion:^(BOOL finished) {
    }];
    
    //
    CGRect r2 = inputView.frame;
    r2.origin.y = r2.origin.y - moreHeight;
    [UIView animateWithDuration:0.23 animations:^{
        inputView.frame = r2;
    }];
    
    
}


- (void)getMoreHeight:(CGFloat)moreHeight{//给弹出键盘用
    NSLog(@"moreHeight = %f",moreHeight);
//    moreHeight = moreHeight - iphoneXBottom;
    
    [dataView.IMTableView addGestureRecognizer:tapGesture];
    
    CGRect r1 = dataView.frame;
    r1.size.height = r1.size.height - moreHeight;
    [UIView animateWithDuration:0.23 animations:^{
        dataView.frame = r1;
        dataView.IMTableView.frame = r1;
        CGPoint offset = CGPointMake(0, dataView.IMTableView.contentSize.height - dataView.IMTableView.frame.size.height);
        if (offset.y > 0) {
            [dataView.IMTableView setContentOffset:offset animated:NO];
        }
    } completion:^(BOOL finished) {
    }];
    
    //
    CGRect r2 = inputView.frame;
    r2.origin.y = r2.origin.y - moreHeight;
    r2.size.height = r2.size.height + 300 - 34;//加上faceview的高度
    [UIView animateWithDuration:0.23 animations:^{
        inputView.frame = r2;
    }];
    
    
}
#pragma mark delegate
- (void)hideKeybord{
    if (inputView.boxState == InputBoxKeyboard) {
        //键盘状态,关闭键盘
        [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }
    inputView.boxState = InputBoxVoice;
    //恢复正常位置
    [self becomNormal];
}
- (void)showFaceView:(CGFloat)moreHeight{
    if (inputView.boxState == InputBoxNormal) {
        [self getMoreHeight:moreHeight];
    }
    if (inputView.boxState == InputBoxVoice) {
        [self getMoreHeight:moreHeight];
    }
    if (inputView.boxState == InputBoxKeyboard) {
         /*
          1,键盘高度
          2,faceview高度
          3,从键盘切换到faceview
          */
        [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        CGFloat newHeight = boardHeight - moreHeight;
        if (newHeight > 0) {
            newHeight = - newHeight + iphoneXBottom;
        }
        [self getMoreHeight:newHeight];
    }
    inputView.boxState = InputBoxFace;
}
-(void)showOtherView:(CGFloat)moreHeight{
    if (inputView.boxState == InputBoxNormal) {
        [self getMoreHeight:moreHeight];
    }
    if (inputView.boxState == InputBoxVoice) {
        [self getMoreHeight:moreHeight];
    }
    if (inputView.boxState == InputBoxKeyboard) {
        [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        CGFloat newHeight = boardHeight - moreHeight;
        if (newHeight > 0) {
            newHeight = - newHeight + iphoneXBottom;
        }
        [self getMoreHeight: newHeight];
    }
    inputView.boxState = InputBoxOther;
}
#pragma mark other delegate
- (void)getOtherAction:(IMOtherState)stateAction{
    NSLog(@"stateAction:%ld",stateAction);
    if (stateAction == IMOtherStatePhoto) {
        [self selectImage];
    }
}
//获取相片
-(void)selectImage{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == YES) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = NO;
        imagePicker.delegate = self;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }else{
        //
        NSLog(@"访问相册失败");
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"获取图片");
    /*
     获取到的图片处理:
     1,先把图片以时间的命名格式命名
     2,写进沙盒
     3,再从沙盒中拿图片
     */
    
    NSData *data = [NSData dataWithContentsOfFile:[IMTools getPath:image]];
    UIImage *image1 = [[UIImage alloc]initWithData:data];
    
    IMTestMessage *testMsg = [[IMTestMessage alloc]init];
    IMModel *model = [testMsg randomPhoto:image1];
    [dataView addData:model];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消");
}

#pragma mark acrions
-(void)addBtnAction{
    IMTestMessage *testMsg = [[IMTestMessage alloc]init];
    IMModel *model = [testMsg randomTextAndPhoto];
    [dataView addData:model];
}
-(void)tapAction{
    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    inputView.boxState = InputBoxNormal;
    [self becomNormal];
}
-(void)becomNormal{

    [inputView hideFaceAndOther];
    [dataView.IMTableView removeGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.25 animations:^{
        dataView.frame = oldDataRect;
        dataView.IMTableView.frame = oldDataRect;
        inputView.frame = oldInputRect;
    }];
}
//
- (void)viewDidAppear:(BOOL)animated{
    [dataView scrollBottom:NO];
}
@end
