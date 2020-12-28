//
//  IMTools.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/28.
//

#import "IMTools.h"

@implementation IMTools
+(NSAttributedString *) formatMessageString:(NSString *)text fontSize:(CGFloat)font1{
    //1、创建一个可变的属性字符串
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSDictionary *dic=@{NSFontAttributeName: [UIFont systemFontOfSize:font1]};
    NSRange range = NSMakeRange(0, text.length);
    [attributeString addAttributes:dic range:range];
    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[\\w{10}\\_\\d{1,3}\\.\\w{3}\\]"; //匹配表情
    /*
     \\[ -->[
     \\w{10} -->字母,数字,_,10个
     \\_ -->_
     \\d{1,3} -->数字1位到3位
     \\. -->.
     \\w{3} -->3个字母...
     \\] -->]
     */
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        //        NSLog(@"error:%@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    //    NSLog(@"resultArray = %d",resultArray.count);
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];

    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];
        //        NSLog(@"subStr = %@",subStr);这个OK
        NSMutableArray *faceArr = [[NSMutableArray alloc]init];
        for (NSUInteger i = 1; i < 111; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"[Expression_%ld.png]",i];
            [faceArr addObject:imageName];
        }
        
        for (NSString *face in faceArr) {
            //            NSLog(@"face.faceName = %@",face);
            if ([face isEqualToString:subStr]) {
                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                NSString *imageName = [face stringByReplacingOccurrencesOfString:@"[" withString:@""];
                imageName = [imageName stringByReplacingOccurrencesOfString:@"]" withString:@""];
                textAttachment.image = [UIImage imageNamed:imageName];
                //                NSLog(@"读取到的图片=%@",[NSString stringWithFormat:@"DINSDKBundle.bundle/%@",face.faceName]);
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -4, 20, 20);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                
            }
        }
    }
    //    NSLog(@"imageArray = %lu = %@",(unsigned long)imageArray.count,imageArray);
    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        @try {
            //            NSLog(@"doing...");
            [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
        } @catch(NSException *exception) {
            //            NSLog(@"cathch error...");
            //            NSLog(@"exception = %@", exception);
        } @finally {
            //            NSLog(@"finish...");
        }
    }
    
    return [attributeString copy];
    
}
@end
