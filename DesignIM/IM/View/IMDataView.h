//
//  DataView.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMDataView : CommonView
@property(nonatomic,strong)UITableView *IMTableView;
@property(nonatomic,copy)NSArray *IMDataArray;

-(void)addData:(id)model;
@end

NS_ASSUME_NONNULL_END
