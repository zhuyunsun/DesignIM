//
//  CommonModel.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,ModelMessageType){
    ModelMessageText = 1,
    ModelMessagePhoto,
    ModelMessageMap,
    ModelMessageVoice,
    ModelMessageVideo,
    ModelMessageFile
};
@interface IMModel : NSObject
@property(nonatomic,assign)ModelMessageType msgType;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,getter = isSender)BOOL sender;
@property(nonatomic,strong)NSString *headImageURL;
@property(nonatomic,strong)NSString *time;

///text
@property(nonatomic,strong)NSAttributedString *msg;
///富文本高度
@property(nonatomic,assign)CGFloat msgHeight;
///photo
@property(nonatomic,strong)UIImage *photo;
@end

NS_ASSUME_NONNULL_END
