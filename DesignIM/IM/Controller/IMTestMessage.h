//
//  IMTestMessage.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/28.
//

#import <Foundation/Foundation.h>
#import "IMModel.h"
#import "IMCell.h"
#import "IMTools.h"
#import "IMTimeModel.h"
NS_ASSUME_NONNULL_BEGIN
///模拟数据
@interface IMTestMessage : NSObject
/// 模拟随机文字和图片数据
-(IMModel *)randomTextAndPhoto;
-(IMModel *)randomPhoto:(UIImage *)image;
///时间model
-(IMTimeModel *)randomTime;
@end

NS_ASSUME_NONNULL_END
