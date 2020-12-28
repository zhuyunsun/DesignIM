//
//  IMTools.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface IMTools : NSObject
//带有表情的文本
+(NSMutableAttributedString *)formatMessageString:(NSString *)text fontSize:(CGFloat)font1;
@end

NS_ASSUME_NONNULL_END
