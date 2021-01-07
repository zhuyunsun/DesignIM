//
//  IMInputView.h
//  DesignIM
//
//  Created by 朱运 on 2021/1/4.
//

#import <UIKit/UIKit.h>
#import "IMFaceView.h"
#import "IMOtherView.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,InputBoxState){
    InputBoxNormal = 1,//正常状态
    InputBoxVoice,//语音输入
    InputBoxKeyboard,//键盘输入
    InputBoxFace,//表情输入
    InputBoxOther//其他
};
@protocol InputHeightDelegate;
@interface IMInputView : UIView
///输入框状态
@property(nonatomic,assign)InputBoxState boxState;
@property(nonatomic,weak)id<InputHeightDelegate> delegate;
@property(nonatomic,strong)IMOtherView *otherView;

-(void)hideFaceAndOther;
@end

@protocol InputHeightDelegate <NSObject>
@optional
//-(void)getMoreHeight:(CGFloat)moreHeight;
///关闭键盘回调
-(void)hideKeybord;
///
-(void)showFaceView:(CGFloat)moreHeight;
-(void)showOtherView:(CGFloat)moreHeight;
@end
NS_ASSUME_NONNULL_END
