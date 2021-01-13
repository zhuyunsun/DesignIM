//
//  CommonCell.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import <UIKit/UIKit.h>
#import "IMModel.h"

NS_ASSUME_NONNULL_BEGIN
UIKIT_STATIC_INLINE CGFloat cellWindowHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}
UIKIT_STATIC_INLINE CGFloat cellWindowWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

///默认文字高度,文字行数没有超过这个高度
UIKIT_STATIC_INLINE CGFloat cellHeightDefault(IMModel *model){
    CGFloat textHeight = cellWindowHeight() *0.13;
    if (model.msgHeight > textHeight) {
        return model.msgHeight + cellWindowWidth() *0.02 *2;//上下留空隙
    }
    return textHeight + cellWindowWidth() *0.02;
}
///图片cell的高度,给2个高度,当图片高比宽大时,返回更大的高度
UIKIT_STATIC_INLINE CGFloat cellHeightPhoto(IMModel *model){
    if (model.photo != nil) {
        UIImage *image = model.photo;
        if (image.size.height != 0.0 && image.size.width != 0.0) {
            if (image.size.height > image.size.width) {
                return cellWindowHeight() *0.23;
            }
        }
    }
    return cellWindowHeight() *0.19;
}
/// 位置截取的高度和宽度
UIKIT_STATIC_INLINE CGFloat cellHeightLocation(IMModel *model){
    if (model.locationImage != nil) {
        UIImage *image = model.locationImage;
        if (image.size.height != 0.0 && image.size.width != 0.0) {
            if (image.size.height > image.size.width) {
                return cellWindowHeight() *0.23;
            }
        }
    }
    return cellWindowHeight() *0.19;
}

@interface IMCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;

//text
@property(nonatomic,strong)UIView *msgBackView;
@property(nonatomic,strong)UILabel *msgLabel;
//photo
@property(nonatomic,strong)UIImageView *photoImageView;
//location
@property(nonatomic,strong)UIImageView *locationImageView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(IMModel *)model;
/// 根据model来返回cell的高度,写在IMCell类是为了方便管理
+(CGFloat)cellHeightModel:(IMModel *)model;
/// 根据model返回不同的cell复用标识
+(NSString *)cellStrModel:(IMModel *)model;
/// 根据数据来重新对子控件进行排版布局
-(void)changeModel:(IMModel *)model;
@end

NS_ASSUME_NONNULL_END
