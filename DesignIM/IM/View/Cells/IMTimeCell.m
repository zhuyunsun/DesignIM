//
//  IMTimeCell.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/30.
//

#import "IMTimeCell.h"

@implementation IMTimeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //时间cell的高度是固定的
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height / 35);
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:10.5];
        self.timeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.timeLabel];

    }
    return self;
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
