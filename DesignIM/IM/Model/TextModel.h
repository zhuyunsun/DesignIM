//
//  TextModel.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/25.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextModel : CommonModel
///富文本数据
@property(nonatomic,strong)NSAttributedString *msg;
@end

NS_ASSUME_NONNULL_END
