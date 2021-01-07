//
//  IMOtherView.h
//  DesignIM
//
//  Created by 朱运 on 2021/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,IMOtherState){
    IMOtherStatePhoto = 1,
    IMOtherStateCamera,
    IMOtherStateVideo,
    IMOtherStateLocation,
    IMOtherStateFile
};
@protocol IMOtherDelegate;
@interface IMOtherView : UIView
@property(nonatomic,weak)id<IMOtherDelegate> delegate;
@end


@protocol IMOtherDelegate <NSObject>
@optional
-(void)getOtherAction:(IMOtherState)stateAction;
@end

NS_ASSUME_NONNULL_END
