//
//  CommonView.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonView.h"

@implementation CommonView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.width = frame.size.width;
        self.height = frame.size.height;
    }
    return self;
}
@end
