//
//  IMLocationViewController.h
//  DesignIM
//
//  Created by 朱运 on 2021/1/13.
//

#import "CommonViewController.h"
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^LocationBlock)(UIImage *image,NSString *address,CLLocation *location);

@interface IMLocationViewController : CommonViewController
@property(nonatomic,copy)LocationBlock block;
-(void)getLoactionMessage:(LocationBlock )myBlock;
@end

NS_ASSUME_NONNULL_END
