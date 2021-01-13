//
//  CommonCell.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "IMCell.h"
@interface IMCell(){
    
}
@end
@implementation IMCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(IMModel *)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.headImageView];
        
//        self.nameLabel = [[UILabel alloc]init];
//        [self.contentView addSubview:self.nameLabel];
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
        
        //根据model来决定加载那些子控件
        if (model.msgType == ModelMessageText) {
            //文字背景框
            self.msgBackView = [[UIView alloc]init];
            [self.contentView addSubview:self.msgBackView];
            //
            self.msgLabel = [[UILabel alloc]init];
            self.msgLabel.numberOfLines = 0;
            self.msgLabel.font = [UIFont systemFontOfSize:13.1];
            [self.contentView addSubview:self.msgLabel];
            self.msgLabel.backgroundColor = [UIColor clearColor];
        }
        if (model.msgType == ModelMessagePhoto) {
            self.photoImageView = [[UIImageView alloc]init];
            [self.contentView addSubview:self.photoImageView];
        }
        if (model.msgType == ModelMessageMap) {
            self.locationImageView = [[UIImageView alloc]init];
            [self.contentView addSubview:self.locationImageView];
        }
    }
    return self;
}
+(CGFloat)cellHeightModel:(IMModel *)model{
    if (model.msgType == ModelMessageText) {
        return cellHeightDefault(model);
    }
    if (model.msgType == ModelMessagePhoto) {
        return cellHeightPhoto(model);
    }
    if (model.msgType == ModelMessageMap) {
        return cellHeightLocation(model);
    }
    return cellHeightDefault(model);
}
+(NSString *)cellStrModel:(IMModel *)model{
    //是否要区分发送者和接受者的复用标识
    /*
     标识的作用是识别复用的cell,不同的cell加载不同的子视图;
     同一个信息类型子控件add到cell上是一样的,不同的是frame要根据
     是接受者还是发送者来进行布局调整;
     分析结果:
     不需要根据是发送者或者是接受者来对cell标识进行区分,
     信息类型时区分cell标识的唯一标准.
     */
    if (model.msgType == ModelMessageText) {
      static NSString *textStr = @"textStr";
      return textStr;
    }else
    if (model.msgType == ModelMessagePhoto) {
      static NSString *photoStr = @"photoStr";
      return photoStr;
    }else
    if (model.msgType == ModelMessageMap) {
      static NSString *mapStr = @"mapStr";
      return mapStr;
    }else
    if (model.msgType == ModelMessageVoice) {
      static NSString *voiceStr = @"voiceStr";
      return voiceStr;
    }else
    if (model.msgType == ModelMessageVideo) {
      static NSString *videoStr = @"videoStr";
      return videoStr;
    }else{//model.msgType == ModelMessageFile
      static NSString *fileStr = @"fileStr";
      return fileStr;
    }
}
-(void)changeModel:(IMModel *)model{
    /*
     根据不同数据确定x点坐标足以
     */
    //头像
    CGFloat headImageViewSize = cellWindowWidth() *0.1;
    CGFloat middleWidth = cellWindowWidth() *0.02;
    CGFloat headImageAroundWidth = headImageViewSize + middleWidth *2;
    self.headImageView.image = [UIImage imageNamed:model.headImageURL];
    CGFloat headImageX = 0.0;
    if (model.isSender == YES) {
        headImageX = cellWindowWidth() *0.88;
    }else{
        headImageX = cellWindowWidth() *0.02;
    }
    self.headImageView.frame = CGRectMake(headImageX, middleWidth, headImageViewSize, headImageViewSize);
    
    //text
    if (model.msgType == ModelMessageText) {
        
        /*
         计算的是文字的高度,但是在cell中的布局需要留出空隙;cell的高度比文字的高度需要高一些;
         */
        
        CGFloat width = cellWindowWidth() - headImageAroundWidth *2;
        CGFloat y = middleWidth;
        CGFloat x = headImageAroundWidth;
        self.msgLabel.frame = CGRectMake(x,y,width,model.msgHeight);
        self.msgLabel.attributedText = model.msg;
        
        self.msgBackView.frame = CGRectMake(x, y, width, cellHeightDefault(model) - y*2);
        self.msgBackView.backgroundColor = [UIColor lightGrayColor];
        //需要判断文字的行数,一行时,文字靠右;多行时,文字靠左
        if (model.isSender) {
            CGFloat textSize = [UIFont systemFontOfSize:13.1].lineHeight;
            NSUInteger textRow = (NSUInteger)(model.msgHeight / textSize);
            if (textRow > 1) {
                self.msgLabel.textAlignment = NSTextAlignmentLeft;
            }else{
                self.msgLabel.textAlignment = NSTextAlignmentRight;
            }

        }else{
            self.msgLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    //photo
    if (model.msgType == ModelMessagePhoto) {
        /*
         图片来源:
         本地图片,网络图片地址
         */
        UIImage *image = model.photo;
        self.photoImageView.image = image;
        
        CGFloat photoX = 0.0;
        CGFloat imageHeight = cellHeightPhoto(model) *0.85;
        CGFloat width = (image.size.width / image.size.height) * imageHeight;
        CGFloat y = (cellHeightPhoto(model) - imageHeight) / 2;
        if (model.isSender == YES) {
            photoX = cellWindowWidth()  - headImageAroundWidth - width;
        }else{
            photoX = headImageAroundWidth;
        }
        self.photoImageView.frame = CGRectMake(photoX,y, width,imageHeight);

    }
    //map
    if (model.msgType == ModelMessageMap) {
        UIImage *image = model.locationImage;
        self.locationImageView.image = image;
        
        CGFloat photoX = 0.0;
        CGFloat imageHeight = cellHeightPhoto(model) *0.85;
        CGFloat width = (image.size.width / image.size.height) * imageHeight;
        CGFloat y = (cellHeightPhoto(model) - imageHeight) / 2;
        if (model.isSender == YES) {
            photoX = cellWindowWidth()  - headImageAroundWidth - width;
        }else{
            photoX = headImageAroundWidth;
        }
        self.locationImageView.frame = CGRectMake(photoX,y, width,imageHeight);

    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
