//
//  CommonCell.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonCell.h"
@interface CommonCell(){
    
}
@end
@implementation CommonCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.headImageView];
        
        self.nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
        /*
         按照屏幕高度,百分比给定不同cell的高度,唯一变化的就是文本高度变化;
         1,时间cell高度,占屏幕高度
         2,文字正常cell高度
         3,文字过长cell的高度
         4,图片cell的高度
         5,地图cell的高度
         6,语音cell的高度
         7,视频cell的高度
         8,文件cell的高度
         
         每一个不同的cell中,基础类中头像和昵称frame重新按照当前cell的frame来布局;
         */
        
        //
        
        
    }
    return self;
}
+(CGFloat)cellHeight{
    return 1.0;
}
-(void)changeModel:(CommonModel *)model{
    TextModel *currentModel = (TextModel *)model;
    self.headImageView.image = [UIImage imageNamed:currentModel.headImageURL];
    if (currentModel.isSender == YES) {
        self.headImageView.frame = CGRectMake(cellWindowWidth() *0.88, cellWindowWidth() *0.02, cellWindowWidth() *0.1, cellWindowWidth() *0.1);
    }else{
        self.headImageView.frame = CGRectMake(cellWindowWidth() *0.02, cellWindowWidth() *0.02, cellWindowWidth() *0.1, cellWindowWidth() *0.1);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
