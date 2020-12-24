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
        NSLog(@"w = %f,h = %f",self.contentView.frame.size.width,self.contentView.frame.size.height);
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
