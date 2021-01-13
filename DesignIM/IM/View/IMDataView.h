//
//  DataView.h
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "CommonView.h"
#import "IMCell.h"
#import "FFBigImage.h"
NS_ASSUME_NONNULL_BEGIN
@protocol IMDataDelegate;
@interface IMDataView : CommonView
@property(nonatomic,strong)UITableView *IMTableView;
@property(nonatomic,copy)NSArray<IMModel *> *IMDataArray;
@property(nonatomic,weak)id<IMDataDelegate> delegate;

-(void)addData:(IMModel *)model;
-(void)scrollBottom:(BOOL)animated;
@end

@protocol IMDataDelegate <NSObject>
@optional
-(void)showBigImageAction;
-(void)showMapAction:(IMModel *)model;
@end
NS_ASSUME_NONNULL_END
