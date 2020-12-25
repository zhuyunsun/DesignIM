//
//  CommonCell.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

UIKIT_STATIC_INLINE CGFloat cellWindowHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}
UIKIT_STATIC_INLINE CGFloat cellWindowWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

NS_ASSUME_NONNULL_BEGIN

@interface CommonCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;

+(CGFloat)cellHeight;

-(void)changeModel:(CommonModel *)model;
@end

NS_ASSUME_NONNULL_END
