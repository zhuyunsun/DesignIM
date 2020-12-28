//
//  DataView.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "IMDataView.h"

@interface IMDataView()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;
}
@end
@implementation IMDataView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addView];
    }
    return self;
}
-(void)addView{
    self.IMTableView = [[UITableView alloc]init];
    self.IMTableView.frame = CGRectMake(0, 0, self.width, self.height);
    self.IMTableView.dataSource = self;
    self.IMTableView.delegate = self;
    self.IMTableView.tableFooterView = [[UIView alloc]init];
    [self addSubview:self.IMTableView];
    
    
    self.userInteractionEnabled = YES;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    IMModel *model = dataSource[indexPath.row];
    return [IMCell cellHeightModel:model];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (IMCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IMModel *model = dataSource[indexPath.row];
    //
    NSString *normalStr = [IMCell cellStrModel:model];
    IMCell *cell = [tableView dequeueReusableCellWithIdentifier:normalStr];
    if (cell == nil) {
        cell = [[IMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalStr model:model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell changeModel:model];//数据在这里加载
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
//
- (void)setIMDataArray:(NSArray *)IMDataArray{
    dataSource = [IMDataArray copy];
    [self.IMTableView reloadData];
}

-(void)addData:(IMModel *)model{
    NSMutableArray *newArr = [[NSMutableArray alloc]initWithArray:dataSource];
    [newArr addObject:model];
    dataSource = [newArr copy];
    [self.IMTableView reloadData];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"发生改变");
}
@end

/*
 多个cell和model
 根据model来判断加载那个cell;不用判断加载那些子控件
 单个cell和model
 根据model中的数据类型来决定cell中加载那些子控件;cell创建时要把model传进去,决定add那些子控件
 性能是一样的,都要判断,都要决定加载cell的那些子控件;
 
 创建cell时,把子控件加载到cell上面;
 根据model类型,赋值子控件frame和数据;
 
 复用cell,在创建时,根据model类型,赋予不同的复用标识;
 
 cell高度,根据model来赋值不同的高度,高度跟整个屏幕高度相关,唯一变化的是富文本时需要计算富文本的高度;
 */
