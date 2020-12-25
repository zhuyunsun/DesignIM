//
//  CommonModel.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CommonModel : NSObject
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,getter = isSender)BOOL sender;
@property(nonatomic,strong)NSString *headImageURL;
@property(nonatomic,strong)NSString *time;

@property(nonatomic,assign)CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
