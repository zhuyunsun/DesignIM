//
//  IMFaceView.h
//  DesignIM
//
//  Created by 朱运 on 2021/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IMFaceDelegate;
@interface IMFaceView : UIView
@property(nonatomic,weak)id<IMFaceDelegate> delegate;
@end
@protocol IMFaceDelegate <NSObject>
@required
-(void)getFaceName:(NSString *)name;
-(void)getDeleteAction;
-(void)getSendAction;
@end

@interface FaceCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@end
NS_ASSUME_NONNULL_END
