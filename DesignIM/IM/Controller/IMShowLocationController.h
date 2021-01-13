//
//  IMShowLocationController.h
//  DesignIM
//
//  Created by 朱运 on 2021/1/13.
//

#import "CommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMShowLocationController : CommonViewController
@property(nonatomic,strong)CLLocation *showLocation;
@property(nonatomic,strong)NSString *addressStr;

@end

NS_ASSUME_NONNULL_END
