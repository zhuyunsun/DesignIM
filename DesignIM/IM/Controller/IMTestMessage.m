//
//  IMTestMessage.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/28.
//

#import "IMTestMessage.h"

@implementation IMTestMessage
-(IMModel *)randomTextAndPhoto{

    IMModel *model = [[IMModel alloc]init];
    NSArray *arr = @[@"0",@"1"];
    NSUInteger i = arc4random() % 2;
    NSUInteger j = arc4random() % 2;
    
    if ([arr[j] isEqualToString:@"0"]) {
        model.sender = NO;
        model.headImageURL = @"2";
    }else{
        model.sender = YES;
        model.headImageURL = @"6";
    }
    
    if ([arr[i] isEqualToString:@"0"]) {
        //
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *file1 = [bundle pathForResource:@"Words" ofType:@"plist"];
        NSArray *fileArr = [[NSArray alloc]initWithContentsOfFile:file1];
        NSUInteger word = arc4random() % fileArr.count;
        NSString *str = fileArr[word];
        model.msg = [[NSAttributedString alloc]initWithString:str];
        model.msgType = ModelMessageText;
        
        model.msgHeight = [self handelHighContent:str font:13.1 size:cellWindowWidth() *0.72];
    }else{
        //
        NSArray *photoArr = @[@"imA0",@"imA1",@"imA2",@"imA3",@"imA4",@"imA5",@"imA6",@"imA7",@"imA8",@"imA9"];
        NSUInteger count = photoArr.count;
        NSUInteger code;
        code = arc4random() % count;
        model.photo = [UIImage imageNamed:[NSString stringWithFormat:@"imA%ld",code]];
        model.msgType = ModelMessagePhoto;
    }
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];//MM和mm区分
    NSString *timeStr = [matter stringFromDate:[NSDate date]];
    model.time = timeStr;
//    NSLog(@"timer = %@",timeStr);
    return model;
}
-(IMModel *)randomPhoto:(UIImage *)image{
    IMModel *model = [[IMModel alloc]init];
    model.sender = YES;
    model.headImageURL = @"6";
    model.photo = image;
    model.msgType = ModelMessagePhoto;
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];//MM和mm区分
    NSString *timeStr = [matter stringFromDate:[NSDate date]];
    model.time = timeStr;
    
    return model;
}
-(IMTimeModel *)randomTime{
    IMTimeModel *model = [[IMTimeModel alloc]init];
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];//MM和mm区分
    NSString *timeStr = [matter stringFromDate:[NSDate date]];
    model.time = timeStr;
    return model;
}
-(CGFloat)handelHighContent:(NSString *)content font:(CGFloat)fontSize size:(CGFloat)width{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = CGSizeMake(width,CGFLOAT_MAX);
    NSDictionary * attributes = @{NSFontAttributeName:font};
    //高度根据图文混排来计算
    NSMutableAttributedString *str = [[IMTools formatMessageString:content fontSize:fontSize] mutableCopy];
    [str addAttributes:attributes range:NSMakeRange(0, str.length)];
    CGSize new = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return new.height;
}

@end
