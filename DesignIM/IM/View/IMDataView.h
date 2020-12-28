//
//  DataView.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonView.h"
#import "IMCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface IMDataView : CommonView
@property(nonatomic,strong)UITableView *IMTableView;
@property(nonatomic,copy)NSArray<IMModel *> *IMDataArray;

-(void)addData:(IMModel *)model;
@end

NS_ASSUME_NONNULL_END
