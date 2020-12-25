//
//  TextCell.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "FFTextCell.h"

@implementation FFTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //把视图添加到contenview
        self.msgLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.msgLabel];
        
    }
    return self;
}
+(CGFloat)cellHeight{
    return cellHeightDefault();
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
