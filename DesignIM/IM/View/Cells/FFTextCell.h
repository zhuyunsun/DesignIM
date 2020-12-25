//
//  TextCell.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonCell.h"

NS_ASSUME_NONNULL_BEGIN
///默认文字高度,文字行数没有超过这个高度
UIKIT_STATIC_INLINE CGFloat cellHeightDefault(void){
    return cellWindowHeight() *0.15;
}

@interface FFTextCell : CommonCell
@property(nonatomic,strong)UILabel *msgLabel;
@end

NS_ASSUME_NONNULL_END
